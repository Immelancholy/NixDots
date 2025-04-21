{
  config,
  lib,
  ...
}:
with lib; {
  options.catppuccin.zen = {
    enable = mkEnableOption "enable catppuccin zen theme";
  };
}
