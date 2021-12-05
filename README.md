# digitalocean-k8s-challenge

## Troubleshooting
- don't check in secrets!
- https://github.com/fluxcd/flux2/discussions/2097
  - kubectl patch secret -n flux-system flux-system -p '{"data":{"known_hosts":"Z2l0aHViLmNvbSBlY2RzYS1zaGEyLW5pc3RwMjU2IEFBQUFFMlZqWkhOaExYTm9ZVEl0Ym1semRIQXlOVFlBQUFBSWJtbHpkSEF5TlRZQUFBQkJCRW1LU0VOalFFZXpPbXhrWk15N29wS2d3RkI5bmt0NVlScllNak51RzVOODd1UmdnNkNMcmJvNXdBZFQveTZ2MG1LVjBVMncwV1oyWUIvKytUcG9ja2c9"}}'
  - kubectl -n flux-system rollout restart deployment/source-controller
