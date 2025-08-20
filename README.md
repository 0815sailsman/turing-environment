# turing-environment
GitOps environment repository. Describes the services that should be running on my server using podman compose files.

## Adding new services
Atm only podman compose services are supported, so adding a new service consists of creating the appropriate directory in the services directory and writing the podman-compose file, possibly including any non-sensitive env files next to it.

Executing deploy.sh on the server then pulls this repo and checks for changes, re-starting any updates services.

.env files in a service dir set vars in the container, while podman-compose.env files are used for startup / replacing in the compose yml itself.

## Continuous deployment of "latest" images
Is not directly possible. You have to manually notify the deployment server or similar that a new image is available.
See https://github.com/0815sailsman/gitops-deploy-server?tab=readme-ov-file#endpoints if you are using my custom deployment server.

## Secrets
If a service requires secrets, the current solution is to create a secrets directory in the root of the repo (which is untracked from VCS because of the gitignore) and just put your secrets in env files in there and then load them from your compose file as env files.
