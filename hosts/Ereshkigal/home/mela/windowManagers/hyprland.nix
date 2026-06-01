{
  wayland.windowManager.hyprland = {
    # ONLY ENABLE 1 LAYOUT!!
    layout = {
      master.enable = false;
      dwindle.enable = false;
      hy3.enable = true;
    };
    hyprspace.enable = false;
    hyprexpo.enable = true;
    settings = {
      ecosystem = {
        enforce_permissions = true;
      };
      general = {
        allow_tearing = true;
      };
      cursor = {
        no_hardware_cursors = 2;
      };
      monitor = "eDP-1, 1920x1080@60, 0x0, 1";
      input = {
        kb_layout = "gb";
        kb_options = "compose:rwin";
        follow_mouse = "1";

        sensitivity = "0";
        force_no_accel = "1";
        numlock_by_default = "true";
      };
      bind = [
        "$mod, F9, pass, class:^(com.obsproject.Studio)$"
        "$mod, F10, pass, class:^(com.obsproject.Studio)$"
        "$mod, F12, pass, class:^(com.obsproject.Studio)$"
      ];
      bindl = [
        "$mod, mouse:282, exec, $playerctl next" # next
        "$mod, mouse:281, exec, $playerctl previous" # previous,
        ", mouse:277, exec, $playerctl play-pause" # toggle between media play and pause
      ];
      bindel = [
        ", mouse:281, exec, uwsm-app -- playerVol inc" # volume up of mpd
        ", mouse:282, exec, uwsm-app -- playerVol dec" # volume down of mpd
      ];
      bindnt = [
        ", mouse:275, exec, toggle-mute"
        "Shift, mouse:275, exec, toggle-mute --mute-all"
        "$mod, M, exec, toggle-mute"
        "$mod+Shift, M, exec, toggle-mute --mute-all"
      ];
    };
  };
}
