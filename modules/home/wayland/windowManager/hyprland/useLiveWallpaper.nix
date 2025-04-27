{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;
  user = config.home.username;

  paper-change = ''
    /etc/profiles/per-user/${user}/bin/mpvpaper -f -p -o "--loop hwdec=auto --no-audio" '*' ${cfg.liveWallpaper.path}
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
    ];
    # wayland.windowManager.hyprland.settings = {
    #   exec-once = [
    #     ''${paper-change}''
    #   ];
    # };
    systemd.user.services.paper-change = {
      Unit = {
        Description = "Wallpaper changer";
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "${paper-change}";
        Type = "simple";
        Environment = "PATH=/etc/profiles/per-user/${user}/bin:/run/current-system/sw/bin";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
