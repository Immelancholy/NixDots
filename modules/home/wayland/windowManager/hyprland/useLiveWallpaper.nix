{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;

  paper-change = ''
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
    ];
    # wayland.windowManager.hyprland.settings = {
    #   exec-once = [
    #     ''${paper-change}''
    #   ];
    # };
    systemd.user.services = {
      Unit = {
        Description = "Wallpaper changer";
        After = "default.target";
      };
      Service = {
        ExecStart = "${paper-change}";
        Type = "simple";
      };
      Install = {
        WantedBy = "graphical-session.target";
      };
    };
  };
}
