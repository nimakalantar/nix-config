{config, ...}: {
  # Use BuildKit
  environment.variables.DOCKER_BUILDKIT = "1";

  # Enable docker service
  virtualisation.docker.enable = true;

  virtualisation.oci-containers.backend = "docker";
}
