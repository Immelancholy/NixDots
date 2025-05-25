{
  osConfig,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    sourceFirst = true;
    settings = {
      "$scr" = "$XDG_BIN_HOME";
      "$term" = "uwsm app -- ghostty";
      "$files" = "uwsm app -- nemo.desktop";
      "$filest" = "uwsm app -- yazi.desktop";
      "$mod" = "SUPER";
      "$mods" = "SUPERSHIFT";
      "$menu" = ''rofi -show drun -run-command "uwsm-app -- {cmd}" run filebrowser power-menu -modi drun,run,filebrowser,power-menu:rofi-power-menu'';
      "$browser" = "uwsm app -- zen.desktop";
      "$edit" = "uwsm app -- nvim.desktop";
      "$playerctl" = "uwsm app -- playerctl --player=$player";
      "$discord" = "uwsm app -- vesktop.desktop";
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        key_press_enables_dpms = true;
      };
      cursor = {
        hide_on_key_press = true;
      };
      ecosystem = {
        enforce_permissions = true;
      };
      permission = [
        "${osConfig.programs.hyprland.portalPackage}/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
        "${lib.getExe pkgs.grim}, screencopy, allow"
      ];
    };
  };
  imports = [
    ./binds.nix
    ./theme
    ./execs.nix
    ./windowrules.nix
  ];
}
