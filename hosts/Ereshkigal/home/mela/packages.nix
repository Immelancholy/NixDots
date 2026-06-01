{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    inputs.viu.packages.${pkgs.stdenv.hostPlatform.system}.default
    teams-for-linux
    obsidian
    obsidian-export
  ];
}
