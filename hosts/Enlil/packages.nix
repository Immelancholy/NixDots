{
  pkgs,
  inputs,
  ...
}: let
  lgc = inputs.llm-git-commit.packages.${pkgs.stdenv.hostPlatform.system}.default;

  python = pkgs.stable.python3.override {
    self = python;
    packageOverrides = pyfinal: pyprev: {
      llm-git-commit = lgc;
    };
  };
  pyWithLlm = (
    python.withPackages (ps: with ps; [llm llm-git-commit llm-openrouter])
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
    ungoogled-chromium
    lmstudio
    toggle-mullvad
  ];
}
