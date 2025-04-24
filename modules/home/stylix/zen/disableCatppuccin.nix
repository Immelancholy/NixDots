{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.zen.theme;
in {
  config = mkIf (!cfg.enable) {
    catppuccin = {
      zen = {
        enable = true;
      };
    };
  };
}
