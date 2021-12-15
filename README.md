# digitalocean-k8s-challenge

## Troubleshooting
- don't check in secrets!
- https://github.com/fluxcd/flux2/discussions/2097
  - kubectl patch secret -n flux-system flux-system -p '{"data":{"known_hosts":"Z2l0aHViLmNvbSBlY2RzYS1zaGEyLW5pc3RwMjU2IEFBQUFFMlZqWkhOaExYTm9ZVEl0Ym1semRIQXlOVFlBQUFBSWJtbHpkSEF5TlRZQUFBQkJCRW1LU0VOalFFZXpPbXhrWk15N29wS2d3RkI5bmt0NVlScllNak51RzVOODd1UmdnNkNMcmJvNXdBZFQveTZ2MG1LVjBVMncwV1oyWUIvKytUcG9ja2c9"}}'
  - kubectl -n flux-system rollout restart deployment/source-controller
  - --- github.com github.com ecdsa-sha2-nistp256 AAAAE2Vj
    +++ github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTI
    @@ -1 +1 @@
    -github.com github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
    +github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
- argocd without TLS because TLS termination at ambassador `argocd-cmd-params-cm` `server.insecure: "true"`