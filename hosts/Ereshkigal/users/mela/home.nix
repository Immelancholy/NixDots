{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./vesktop.nix
    ../../../../nixos/home/fetch_images.nix
  ];

  programs.ssh = {
    enable = true;
    package = null;
    matchBlocks = {
      "enlil" = {
        host = "enlil";
        forwardAgent = true;
      };
    };
  };

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
  };

  player = {
    enable = true;
  };

  programs.obs-studio.enable = true;
  services.remmina = {
    enable = true;
  };
  programs.git = {
    enable = true;
    userName = "Immelancholy";
    userEmail = "lenalowes0@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
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
    layout = {
      master.enable = false;
      dwindle.enable = false;
      hy3.enable = true;
    };
    useHyprspace = true;
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
      bind = [
        # "$mod, F9, pass, class:^(com.obsproject.Studio)$"
        # "$mod, F10, pass, class:^(com.obsproject.Studio)$"
        # "$mod, F12, pass, class:^(com.obsproject.Studio)$"
      ];
    };
  };
  home.packages = with pkgs; [
    teams-for-linux
    obsidian
    obsidian-export
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    plugins = {
      obsidian = {
        enable = true;
        settings = {
          ui.enable = false;
          workspaces = [
            {
              name = "Obsidian-Vault";
              path = "/home/mela/Documents/Obsidian-Vault";
            }
          ];
        };
      };
    };
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
