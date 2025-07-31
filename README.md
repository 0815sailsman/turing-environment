# turing-environment
GitOps environment repository. Describes the services that should be running on my server using podman compose files.

## Adding new services
Atm only podman compose services are supported, so adding a new service consists of creating the appropriate directory in the services directory and writing the podman-compose file, possibly including any non-sensitive env files next to it.

Executing deploy.sh on the server then pulls this repo and checks for changes, re-starting any updates services.

## Secrets
If a service requires secrets, the current solution is to create a secrets directory in the root of the repo (which is untracked from VCS because of the gitignore) and just put your secrets in env files in there and then load them from your compose file as env files.
