{
  pkgs,
  inputs,
  ...
}: let
  megarex = pkgs.fetchurl {
    url = "https://www.dropbox.com/scl/fi/3haz3x3yifeymuo3anrkd/ailivewallpapers.com-muse-dash-at-rest-2560x1440.mp4?rlkey=nvu35gv2pqgbe12kprvs8yi4k&dl=1";
    hash = "sha256-IjLZwXqggUaT5Nbcya48WQkxbL2U17v7H/kjcYKn7/w=";
  };
  madness = pkgs.fetchurl {
    url = "https://www.dropbox.com/scl/fi/yph1240qyi9bfuz0d6gcp/ailivewallpapers.com-whispers-of-madness-2560x1440.mp4?rlkey=dgxnzp3dcmdzim3tkzqpl0n5g&dl=1";
    hash = "";
  };
in {
  home-manager.users.mela = {
    catppuccin = {
      flavor = "mocha";
      accent = "mauve";
    };
    # stylix.targets = {
    #   tmux.enable = false;
    #   yazi.enable = false;
    #   btop.enable = false;
    #   spicetify.enable = false;
    #   kitty.enable = false;
    #   nixvim.enable = false;
    #   zen.enable = false;
    #   vesktop.enable = false;
    # };
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
      useHyprspace = false;
      liveWallpaper = {
        enable = true;
        path = madness;
      };
      settings = {
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
      };
    };
    home.packages = with pkgs; [
      (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {extensions = ["rust-src" "rust-analyzer"];}))
      reaper
      inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
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
  };
}
