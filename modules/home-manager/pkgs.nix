{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    deploy-rs
    sops
    alejandra
    hadolint
    circleci-cli
    trivy
    pre-commit
    python310
    python310Packages.pip
    python310Packages.icecream
  ];
}
