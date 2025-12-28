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
      general = {
        allow_tearing = true;
      };
      cursor = {
        no_hardware_cursors = 2;
      };
      monitorv2 = {
        output = "DP-1";
        mode = "1920x1080@280";
        position = "0x0";
        scale = 1;
        vrr = 1;
        bitdepth = 10;
        cm = "srgb";
        supports_wide_color = 1;
        supports_hdr = 1;
        sdr_min_luminance = 0.005;
        sdr_max_luminance = 300;
        min_luminance = 0;
        max_luminance = 300;
        max_avg_luminance = 300;
      };
      render = {
        send_content_type = true;
        direct_scanout = 1;
        cm_fs_passthrough = 0;
        cm_auto_hdr = 1;
      };
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
        "$mod, mouse:282, exec, $playerctl next" #next
        "$mod, mouse:281, exec, $playerctl previous" #previous,
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
