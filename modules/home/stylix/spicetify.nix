{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.stylix.targets.spicetify;
in {
  config = mkIf (!cfg.enable) {
    programs.spicetify = {
      theme = spicePkgs.themes.catppuccin;

      colorScheme = config.catppuccin.flavor;
    };
  };
}
