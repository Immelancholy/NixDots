{
  pkgs,
  inputs,
  ...
}: let
  llm-git-commit = inputs.llm-git-commit.packages.${pkgs.stdenv.hostPlatform.system}.default;
  pyWithLlm = (
    pkgs.python3.withPackages (ps: [ps.llm llm-git-commit ps.llm-openrouter])
  );
  llm-with-plugins = (
    pkgs.writeShellScriptBin "llm" ''
      exec ${pyWithLlm}/bin/llm "$@"
    ''
  );
in {
  environment.systemPackages = with pkgs; [
    llm-with-plugins
    autoeq-fiio
    nexusmods-app-unfree
    picard
    (winboat.override {nodejs_24 = pkgs.stable.nodejs_24;})
    freerdp
    sshpass
    anifetch
    nix-prefetch
    heroic
    blender
    nodePackages_latest.nodejs
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
