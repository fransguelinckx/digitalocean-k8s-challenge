# [digitalocean-k8s-challenge](https://www.digitalocean.com/community/pages/kubernetes-challenge#anchor--challenges)

## challenge
The main challenge I chose was to deploy a gitops CI/CD implementation with tekton and argocd. Because this is a great learning opportunity, I decided to pile on fluxcd for bootstrapping the cluster, deploying ambassador instead of a 'classic' ingress controller and configuring certmanager to manage a wildcard certificate.
In the next sections I'll list up the technologies I've used along the way, what I've learned, what went well and what didn't.

## terraform
I was already familiar with terraform, so setting up a k8s cluster on digital ocean was fairly straightforward. Especially when following the [starter kit](https://github.com/digitalocean/Kubernetes-Starter-Kit-Developers/).
Caveat: don't check in secrets! I did at some point, but github was so kind to warn me about it, so I removed them from the repo and rotated the affected secrets.

## fluxcd
This technology was pretty new to me, so I was pretty curious. Again a lot of help from the [starter kit](https://github.com/digitalocean/Kubernetes-Starter-Kit-Developers/)!
Once set up, it's very easy to deploy helm charts and kustomized manifests. I tried it out with prometheus, grafana and loki.
Caveat: There was an issue with the known hosts config from github. [This issue](https://github.com/fluxcd/flux2/discussions/2097) explains it best and also offers a solution.
TLDR:
```
kubectl patch secret -n flux-system flux-system -p '{"data":{"known_hosts":"Z2l0aHViLmNvbSBlY2RzYS1zaGEyLW5pc3RwMjU2IEFBQUFFMlZqWkhOaExYTm9ZVEl0Ym1semRIQXlOVFlBQUFBSWJtbHpkSEF5TlRZQUFBQkJCRW1LU0VOalFFZXpPbXhrWk15N29wS2d3RkI5bmt0NVlScllNak51RzVOODd1UmdnNkNMcmJvNXdBZFQveTZ2MG1LVjBVMncwV1oyWUIvKytUcG9ja2c9"}}'
kubectl -n flux-system rollout restart deployment/source-controller
```

## certmanager+ambassador
Setup was easy, configuring a cluster-wide wildcard certificate took more of an effort. First you need a domain name and point it to digital ocean's name servers. Next [this guide](https://github.com/digitalocean/Kubernetes-Starter-Kit-Developers/blob/main/03-setup-ingress-controller/guides/wildcard_certificates.md) explains the rest of the process step for step, except for 1 thing: you need to point your domain name to the k8s load balancer.

## argocd
Deploying argocd is again pretty straight forward when you follow their getting started guide. Exposing the UI with an ambassador mapping took me some time because I had to figure out I had to disable TLS on argocd to prevent an endless redirect loop (ambassador -> argocd -> ambassador -> argocd -> ...). To train my new fluxcd skills, I backported the installation of argocd, the mapping and disabling TLS to fluxcd using a kustomization.

Link to argocd: https://argocd.otogone.be

## tekton
This last step was by far the most complex to understand and implement. [This blog post](https://medium.com/dzerolabs/installing-ambassador-argocd-and-tekton-on-kubernetes-540aacc983b9) helped a lot! In short I deployed 2 pipelines: 1 that gets triggered by a github webhook from [this repo](https://github.com/fransguelinckx/tekton-pipeline-example-app) and 1 that gets triggered by the first one to deploy the app (2048 game) that was built, using argocd. After some trial and error I got it working, yay!
In retrospect I like the cloud-nativeness of tekton and it certainly triggered my interest. Although it will still take some time to get used to the concepts and terminology of it.

Link to the 2048 app: https://2048.otogone.be

## digital ocean
A big thank you to the people of digital ocean for organizing and facilitating this k8s challenge 👏🏻! Had a lot of fun experimenting with their platform and tinkering with new technologies. 
