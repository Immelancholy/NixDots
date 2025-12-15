{
  pkgs,
  inputs,
  ...
}: let
  llm-git-commit = inputs.llm-git-commit.packages.${pkgs.stdenv.hostPlatform.system}.default;
  pyWithLlm = (
    pkgs.python3.withPackages (ps: [ps.llm ps.llm-mistral llm-git-commit ps.llm-openrouter])
  );
  llm-with-plugins = (
    pkgs.writeShellScriptBin "llm" ''
      exec ${pyWithLlm}/bin/llm "$@"
    ''
  );
in {
  environment.systemPackages = with pkgs; [
    nexusmods-app-unfree
    picard
    (winboat.override {nodejs_24 = pkgs.stable.nodejs_24;})
    llm-with-plugins
    freerdp
    sshpass
    anifetch
    nix-prefetch
    heroic
    blender
    nodePackages_latest.nodejs
  ];
}
