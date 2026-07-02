{ config, ... }:
let
  inherit (config.stylix.lib) colors;
  mkHex = colors: builtins.mapAttrs (_: value: "#${value}") colors;
  colors-hex = mkHex colors;
in
with colors-hex;
{
  programs.quickshell-overview = {
    enable = true;
    settings = {
      overview = {
        effects = {
          enableBlur = true;
          glassMode = true;
        };
      };
    };
    colors = {
      enable = true;
      m3primary = "";
      m3onPrimary = "";

      m3primaryContainer = "";
      m3onPrimaryContainer = "";

      m3secondary = "";
      m3onSecondary = "";

      m3secondaryContainer = "";
      m3onSecondaryContainer = "";

      m3background = "";
      m3onBackground = "";

      m3surface = "";

      m3surfaceContainerLow = "";
      m3surfaceContainer = "";
      m3surfaceContainerHigh = "";
      m3surfaceContainerHighest = "";

      m3onSurface = "";

      m3surfaceVariant = "";
      m3onSurfaceVariant = "";

      m3inverseSurface = "";
      m3inverseOnSurface = "";

      m3outline = "";
      m3outlineVariant = "";

      m3shadow = "";
    };
  };
}
