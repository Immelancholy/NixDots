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
      "ereshkigal" = {
        host = "ereshkigal";
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

  home.sessionVariables = {
    CAVA_STDOUT_MAX_INSTANCES = 2;
  };

  programs.obs-studio.enable = true;
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
      enable = true;
      path = ../../../../nixos/home/backgrounds/Evil_Miku.mp4;
    };
    settings = {
      general = {
        allow_tearing = true;
      };
      cursor = {
        no_hardware_cursors = false;
      };
      monitor = "HDMI-A-1, 1920x1080@144, 0x0, 1, bitdepth, 8";
      input = {
        kb_layout = "gb";
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
        "$mod, mouse:275, exec, toggle-mute --unmute-all"
      ];
    };
  };
  programs.gh = {
    enable = true;
    extensions = [
    ];
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      editor = "$EDITOR";
    };
  };
  home.packages = with pkgs; [
    (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {extensions = ["rust-src" "rust-analyzer"];}))
    reaper
    inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
    inputs.fastanime.packages.${pkgs.system}.default
    temurin-bin
    bespokesynth
    reaper-sws-extension
    teams-for-linux
    shotcut
    krita
    qbittorrent
    rustlings
    obsidian
    obsidian-export
    gimp3-with-plugins
    inkscape-with-extensions
    pinta
  ];
  services.remmina = {
    enable = true;
  };
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    plugins = {
      rustaceanvim = {
        enable = true;
        settings = {
          rustanalyzerPackafe = null;
          server = {
            cmd = [
              "rust-analyzer"
            ];
            default_settings = {
              rust-analyzer = {
                check = {
                  command = "clippy";
                };
                inlayHints = {
                  lifetimeElisionHints = {
                    enable = "always";
                  };
                };
              };
            };
            standalone = false;
          };
        };
      };
      obsidian = {
        enable = true;
        settings = {
          ui.enable = false;
          workspaces = [
            {
              name = "Obsidian-Vault";
              path = "/home/mela/Documents/Obsidian-Vault/";
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
      input-device = "dummy_plug_out";
      use-default-input-device = false;
    };
    "com/github/wwmm/easyeffects/streamoutputs" = {
      blocklist = ["Zen"];
      output-device = "alsa_output.usb-Audient_Audient_iD4-00.pro-output-0";
      use-default-output-device = false;
    };
  };
}
