{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.viu.packages.${pkgs.system}.default
    teams-for-linux
    obsidian
    obsidian-export
  ];
}
