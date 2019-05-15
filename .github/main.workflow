workflow "deploy docker" {
  resolves = "push"
  on = "issues"
}

action "login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD", "DOCKER_REGISTRY_URL"]
}

action "build" {
  needs = ["login"]
  uses = "actions/docker/cli@master"
  args = "build -t docker-image ."
}

action "tag" {
  needs = ["build"]
  uses = "actions/docker/tag@master"
  env = {
    IMAGE_NAME = "docker-image"
    CONTAINER_REGISTRY_PATH = "docker.pkg.github.com/yuichielectric/danger-textlint-actions"
  }
  args = ["$IMAGE_NAME", "$CONTAINER_REGISTRY_PATH/$IMAGE_NAME"]
}

action "push" {
  needs = ["tag"]
  uses = "actions/docker/cli@master"
  env = {
    IMAGE_NAME = "docker-image"
    CONTAINER_REGISTRY_PATH = "docker.pkg.github.com/yuichielectric/danger-textlint-actions"
  }
  args = ["push", "$CONTAINER_REGISTRY_PATH/$IMAGE_NAME"]
}
