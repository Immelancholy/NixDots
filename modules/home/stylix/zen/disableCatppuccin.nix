{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.zen.stylix;
in {
  config = mkIf (!cfg.enable) {
    catppuccin = {
      zen = {
        enable = true;
      };
    };
  };
}
