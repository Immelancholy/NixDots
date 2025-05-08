{
  pkgs,
  inputs,
  ...
}: let
  Nakari = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GcHyQ8DWUAAOAho?format=jpg&name=medium";
    hash = "sha256-YB13taH2jBB6POHniL/muHxCT1Mpir40YgjCkU5Vetc=";
  };

  Goth_Chell = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GXERYazW0AErHbS?format=jpg&name=medium";
    hash = "sha256-OX8v3Xh+sDhgVv6P3leWHHZrIPiVuBrnd9iAoEPtFBQ=";
  };

  Azurenti = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GS9F_-JWMAALb1S?format=jpg&name=medium";
    hash = "sha256-+IdQuGYwOTUwS/B7tMpDf91o3uerAWaXSs4Wn5/jABU=";
  };

  Fubuki = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GJDueQOXsAA7DjN?format=jpg&name=medium";
    hash = "sha256-m7175RBqjgsDb+yNyRkR0AnVp9rvG1nrX7HKpqSJLSU=";
  };

  Shorea = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GG0t0K6bcAA8-xW?format=jpg&name=medium";
    hash = "sha256-NJNpjZUxK+6vvOUJMt/NxkaSA1fUqee7czH+z2f/SU4=";
  };
in {
  imports = [
    ./vesktop.nix
  ];

  home.file = {
    "Pictures/fastfetch_logos/Nakari.jpg" = {
      source = Nakari;
    };
    "Pictures/fastfetch_logos/Goth_Chell.jpg" = {
      source = Goth_Chell;
    };
    "Pictures/fastfetch_logos/Azurenti.jpg" = {
      source = Azurenti;
    };
    "Pictures/fastfetch_logos/Fubuki.jpg" = {
      source = Fubuki;
    };
    "Pictures/fastfetch_logos/Shorea.jpg" = {
      source = Shorea;
    };
  };
  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
  };
  stylix.targets = {
    # tmux.enable = false;
    # yazi.enable = false;
    # btop.enable = false;
    # spicetify.enable = false;
    # kitty.enable = false;
    # nixvim.enable = false;
    # zen.enable = false;
    # vesktop.enable = false;
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
    useHyprspace = false;
    liveWallpaper = {
      enable = true;
      path = ../../../../nixos/home/backgrounds/Evil_Miku.mp4;
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
