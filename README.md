# register-docker-action
GitHub Action to register docker image to GitHub Package Registry

## Instructions

```bash
$ docker build -t register-docker-action .
$ docker tag register-docker-action docker.pkg.github.com/yuichielectric/register-docker-action/app:1.0.2
$ docker push docker.pkg.github.com/yuichielectric/register-docker-action/app:1.0.2
```
