{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;
  user = config.home.username;

  paper-change = pkgs.writeShellScriptBin "paper-change" ''
    pkill mpvpaper
    uwsm app -- mpvpaper -f -p -o "--loop hwdec=auto --no-audio" '*' ${cfg.liveWallpaper.path}
  '';
in {
  options.wayland.windowManager.hyprland = {
    liveWallpaper.enable = mkEnableOption "Use animated wallpaper";
    liveWallpaper.path = mkOption {
      type = types.path;
      default = null;
      description = "Path to animated background";
    };
  };
  config = mkIf cfg.liveWallpaper.enable {
    home.packages = with pkgs; [
      mpvpaper
      paper-change
    ];
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "systemctl start --user paper-change"
      ];
    };
    systemd.user.services.paper-change = {
      Unit = {
        Description = "Wallpaper changer";
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = ''/run/current-system/sw/bin/hyprctl dispatch exec paper-change'';
        Type = "simple";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
