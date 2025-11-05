{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./vesktop.nix
  ];

  stylix = {
    targets = {
      blender.enable = true;
    };
  };

  programs.mpv = {
    package = pkgs.mpv.override {
      extraMakeWrapperArgs = [
        "--prefix"
        "ENABLE_HDR_WSI"
        "="
        "1"
      ];
      scripts = [
        pkgs.mpvScripts.mpris
        pkgs.mpvScripts.modernz
        pkgs.mpvScripts.thumbfast
      ];
    };
    config = {
      profile = "gpu-hq";
      gpu-api = "vulkan";
      osc = "no";
      hwdec = "auto";
      vo = "gpu-next";
      gpu-context = "waylandvk";
      target-colorspace-hint = true;
    };
    scripts = lib.mkForce [];
  };

  programs.ssh = {
    enable = true;
    package = null;
    enableDefaultConfig = false;
    matchBlocks = {
      "ereshkigal" = {
        host = "ereshkigal";
        forwardAgent = true;
      };
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };
  };

  player = {
    enable = true;
  };

  home.sessionVariables = {
    CAVA_STDOUT_MAX_INSTANCES = 2;
  };

  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio;

    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      droidcam-obs
      obs-pipewire-audio-capture
    ];
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Immelancholy";
        email = "lenalowes0@gmail.com";
      };
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
      experimental = {
        xx_color_management_v4 = true;
      };
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
    prismlauncher
    inputs.viu.packages.${pkgs.stdenv.hostPlatform.system}.default
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
    systemdService.enable = false;
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
          legacy_commands = false;
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
