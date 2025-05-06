{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./vesktop.nix
  ];
  services.mpd = {
    extraConfig = ''
      audio_output {
        type  "pipewire"
        name  "Pipewire Sound Server"
        target  "easyeffects_sink"
      }
    '';
  };
  wayland.windowManager.hyprland = {
    # ONLY ENABLE 1 LAYOUT!!
    player = {
      cmd = "uwsm app -- spotify.desktop";
      class = "spotify";
    };
    layout = {
      master.enable = false;
      dwindle.enable = false;
      hy3.enable = true;
    };
    useHyprspace = false;
    liveWallpaper = {
      enable = false;
      path = ../../../../nixos/home/backgrounds/Evil_Miku.mp4;
    };
    settings = {
      cursor = {
        no_hardware_cursors = false;
      };
      monitor = "eDP-1, 1920x1080@60, 0x0, 1";
      input = {
        kb_layout = "gb";
        follow_mouse = "1";

        sensitivity = "0";
        force_no_accel = "1";
        numlock_by_default = "true";
      };
    };
  };
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
  dconf.settings = {
    "com/github/wwmm/easyeffects" = {
      last-loaded-input-preset = "Rode NT1";
      last-loaded-output-preset = "ATH-R70x";
      process-all-outputs = false;
    };
    "com/github/wwmm/easyeffects/streaminputs" = {
      input-device = "alsa_input.usb-Blue_Microphones_Yeti_Stereo_Microphone_797_2018_09_03_71046-00.analog-stereo";
      use-default-input-device = false;
    };
    "com/github/wwmm/easyeffects/streamoutputs" = {
      blocklist = ["Zen"];
      output-device = "alsa_input.pci-0000_00_1f.3.analog-stereo";
      use-default-output-device = false;
    };
  };
}
