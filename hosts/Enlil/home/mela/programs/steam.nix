{
  config,
  lib,
  ...
}: let
  colors = config.lib.stylix.colors;

  decTo255 = decStrOrNum: let
    parsed =
      if builtins.typeOf decStrOrNum == "string"
      then builtins.elemAt (builtins.fromJSON ("[" + decStrOrNum + "]")) 0
      else decStrOrNum; # already numeric
  in
    toString (builtins.floor (parsed * 255));

  rgbOf = colorPrefix: let
    r = decTo255 (colors."${colorPrefix}-dec-r");
    g = decTo255 (colors."${colorPrefix}-dec-g");
    b = decTo255 (colors."${colorPrefix}-dec-b");
  in "${r}, ${g}, ${b}";
in {
  home.file.".local/share/Steam/steamui/skins/Adwaita-for-Steam/adwaita/colorthemes/stylix/stylix.css".text =
    /*
    css
    */
    ''
      :root {
              /* The main accent color and the matching text value */
              --adw-accent-bg-rgb: ${rgbOf "base07"} !important;
              --adw-accent-fg-rgb: ${rgbOf "base00"} !important;
              --adw-accent-rgb: ${rgbOf "base07"} !important;

              /* destructive-action buttons */
              --adw-destructive-bg-rgb: ${rgbOf "base08"} !important;
              --adw-destructive-fg-rgb: ${rgbOf "base05"} !important;
              --adw-destructive-rgb: ${rgbOf "base08"} !important;

              /* Levelbars, entries, labels and infobars. These don't need text colors */
              --adw-success-bg-rgb: ${rgbOf "base0C"} !important;
              --adw-success-fg-rgb: ${rgbOf "base05"} !important;
              --adw-success-rgb: ${rgbOf "base05"} !important;

              --adw-warning-bg-rgb: 238, 212, 159 !important;
              --adw-warning-fg-rgb: ${rgbOf "base00"} !important;
              --adw-warning-fg-a: 0.8 !important;
              --adw-warning-rgb: ${rgbOf "base09"} !important;

              --adw-error-bg-rgb: ${rgbOf "base08"} !important;
              --adw-error-fg-rgb: ${rgbOf "base05"} !important;
              --adw-error-rgb: ${rgbOf "base08"} !important;

              /* Window */
              --adw-window-bg-rgb: ${rgbOf "base00"} !important;
              --adw-window-fg-rgb: ${rgbOf "base05"} !important;

              /* Views - e.g. text view or tree view */
              --adw-view-bg-rgb: ${rgbOf "base00"} !important;
              --adw-view-fg-rgb: ${rgbOf "base05"} !important;

              /* Header bar, search bar, tab bar */
              --adw-headerbar-bg-rgb: ${rgbOf "base00"} !important;
              --adw-headerbar-fg-rgb: ${rgbOf "base05"} !important;
              --adw-headerbar-border-rgb: ${rgbOf "base02"} !important;
              --adw-headerbar-backdrop-rgb: ${rgbOf "base00"} !important;
              --adw-headerbar-shade-rgb: 0, 0, 0 !important;
              --adw-headerbar-shade-a: 0.36 !important;
              --adw-headerbar-darker-shade-rgb: 0, 0, 0 !important;
              --adw-headerbar-darker-shade-a: 0.9 !important;

              /* Split pane views */
              --adw-sidebar-bg-rgb: ${rgbOf "base00"} !important;
              --adw-sidebar-fg-rgb: ${rgbOf "base05"} !important;
              --adw-sidebar-backdrop-rgb: ${rgbOf "base00"} !important;
              --adw-sidebar-shade-rgb: 0, 0, 0 !important;
              --adw-sidebar-shade-a: 0.36 !important;

              --adw-secondary-sidebar-bg-rgb: ${rgbOf "base00"} !important;
              --adw-secondary-sidebar-fg-rgb: ${rgbOf "base05"} !important;
              --adw-secondary-sidebar-backdrop-rgb: ${rgbOf "base00"} !important;
              --adw-secondary-sidebar-shade-rgb: 0, 0, 0 !important;
              --adw-secondary-sidebar-shade-a: 0.36 !important;

              /* Cards, boxed lists */
              --adw-card-bg-rgb: 255, 255, 255 !important;
              --adw-card-bg-a: 0.08 !important;
              --adw-card-fg-rgb: 255, 255, 255 !important;
              --adw-card-shade-rgb: 0, 0, 0 !important;
              --adw-card-shade-a: 0.36 !important;

              /* Dialogs */
              --adw-dialog-bg-rgb: ${rgbOf "base01"} !important;
              --adw-dialog-fg-rgb: ${rgbOf "base05"} !important;

              /* Popovers */
              --adw-popover-bg-rgb: ${rgbOf "base01"} !important;
              --adw-popover-fg-rgb: ${rgbOf "base05"} !important;

              /* Thumbnails */
              --adw-thumbnail-bg-rgb: ${rgbOf "base01"} !important;
              --adw-popover-fg-rgb: ${rgbOf "base05"} !important;

              /* Miscellaneous */
              --adw-shade-rgb: 0, 0, 0 !important;
              --adw-shade-a: 0.36 !important;

      }
    '';
}
