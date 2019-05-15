workflow "deploy docker" {
  resolves = "push"
  on = "issues"
}

action "debug" {
  uses = "actions/bin/debug"
}

action "login" {
  needs = ["debug"]
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD", "DOCKER_REGISTRY_URL"]
}

action "build" {
  needs = ["login"]
  uses = "actions/docker/cli@master"
  args = "build -t register-docker-image ."
}

action "tag" {
  needs = ["build"]
  uses = "actions/docker/tag@master"
  env = {
    IMAGE_NAME = "register-docker-image"
    CONTAINER_REGISTRY_PATH = "docker.pkg.github.com/yuichielectric/register-docker-action"
  }
  args = ["$IMAGE_NAME", "$CONTAINER_REGISTRY_PATH/$IMAGE_NAME"]
}

action "push" {
  needs = ["tag"]
  uses = "actions/docker/cli@master"
  env = {
    IMAGE_NAME = "register-docker-image"
    CONTAINER_REGISTRY_PATH = "docker.pkg.github.com/yuichielectric/register-docker-action"
  }
  args = ["push", "$CONTAINER_REGISTRY_PATH/$IMAGE_NAME"]
}
