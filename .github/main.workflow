workflow "deploy docker" {
  resolves = "push"
  on = "release"
}

action "login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD", DOCKER_REGISTRY_URL]
}

action "build" {
  needs = ["login"]
  uses = "actions/docker/cli@master"
  args = "build -t yuichielectric/register-docker-action ."
}

action "push" {
  needs = ["build"]
  uses = "actions/docker/cli@master"
  args = "push docker.pkg.github.com/yuichielectric/register-docker-action:1.0.0"
}
