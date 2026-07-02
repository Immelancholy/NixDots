self:
{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.quickshell-overview;
  quickshell-overview = self.packages.${pkgs.stdenv.hostPlatform.system}.quickshell-overview;
  jsonFormat = pkgs.formats.json { };
in
{
  options.programs.quickshell-overview = {
    enable = mkEnableOption "Enable quickshell-overview for hyprland";
    package = mkOption {
      type = with types; nullOr package;
      default = quickshell-overview;
    };
    settings = mkOption {
      inherit (jsonFormat) type;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    home.packages = mkIf (cfg.package != null) [ cfg.package ];

    xdg.configFile."quickshell/overview/config.json" = mkIf (cfg.settings != { }) {
      source = jsonFormat.generate "config.json" cfg.settings;
    };
  };
}
