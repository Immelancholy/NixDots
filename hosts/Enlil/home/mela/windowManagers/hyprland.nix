{lib, ...}: {
  wayland.windowManager.hyprland = {
    # ONLY ENABLE 1 LAYOUT!!
    layout = {
      master.enable = false;
      dwindle.enable = false;
      scrolling.enable = true;
    };
    easymotion.enable = true;
    settings = {
      "$editor" = lib.mkForce "uwsm app -- nvim.desktop";
      "$browser" = lib.mkForce "uwsm app -- helium.desktop";
      windowrule = [
        ''match:class ^(steam_app_\d+)$, workspace special''
        ''match:class ^(helium)$, opacity 0.9 0.8''
      ];
      exec-once = [
        "systemctl start --user qpwgraph"
        "$browser"
        "hyprctl dispatch movetoworkspacesilent 2,class:helium"
        "uwsm app -- $discord"
        "[workspace 5 silent] uwsm app -- lm-studio"
      ];
      ecosystem = {
        enforce_permissions = true;
      };
      general = {
        allow_tearing = true;
      };
      cursor = {
        no_hardware_cursors = 2;
      };
      "monitorv2[desc:Microstep MAG 274CXF]" = {
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
      "monitorv2[desc:HAT Kamvas Pro 16 0xF0000001]" = {
        output = "HDMI-A-1";
        mode = "2569x1440@60";
        position = "1920x0";
        scale = 1;
      };
      workspace = [
        "r[1-5], monitor:DP-1"
        "1, monitor:DP-1"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:HDMI-A-1"
      ];
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
