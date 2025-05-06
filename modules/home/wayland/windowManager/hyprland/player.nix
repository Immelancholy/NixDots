{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;
in {
  options.wayland.windowManager.hyprland = {
    player = mkOption {
      type = types.str;
      default = ''uwsm app -- kitty --class "mpd" --session=mpd.session'';
      description = "Launch command for music player";
    };
  };
  config = {
    wayalnd.windowManager.hyprland.settings = {
      exec = [
        ''[workspace 1 silent; float; size 858 559; move 640 40] ${cfg.player}''
      ];
      bind = [
        ''$mods, U, exec, [workspace 1 silent; float; size 858 559; move 640 40] ${cfg.player}''
      ];
    };
  };
}
