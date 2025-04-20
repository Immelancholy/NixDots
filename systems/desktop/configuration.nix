{
  pkgs,
  inputs,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  disko.devices.disk.main.device = "/dev/nvme0n1";
  nixpkgs.overlays = [inputs.rust-overlay.overlays.default];
  userAccounts.users = [];
  userAccounts.sudoUsers = ["mela"];

  services.openssh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBLCQZSKxQcuHRUbEN7AK1lSf0VmXzTTYJA4BTs0pIgT Desktop"
  ];
  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.allowed-rates" = [44100 48000 88200 96000];
      "default.clock.min-quantum" = 64;
      "default.clock.max-quantum" = 512;
      "default.clock.quantum-limit" = 4096;
      "default.clock.quantum-floor" = 32;
    };
  };

  home-manager.users.mela = {
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
      useLiveWallpaper = true;
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
    home.sessionVariables = {
      NOTES_PATH = "/home/mela/Documents/Obsidian-Vault"; # path to notes folder ( for neovim )
      PROJECTS_PATH = "/home/mela/Documents/Projects"; # path to Projects folder ( for neovim )
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
  };

  services.qpwgraph.enable = true;

  services.solaar.enable = true;
  hardware.logitech.wireless.enable = true;

  environment.sessionVariables = {
    FLAKE_PATH = "/home/mela/NixDots"; # path to flake.nix
    SYSTEM = ".#nix-relic-desktop";
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  services.mpdchck = {
    enable = true;
    address = "/run/user/1000/mpd/socket";
  };

  drivers = {
    amd.enable = false;
    intel.enable = false;
    nvidia = {
      enable = true;
      open = true;
      powerManagement = true;
      finePowerManagement = false;
      package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
      prime = {
        enable = false;
        # intelBusId = ""; # For Intel
        # amdgpuBusId = ""; # For AMD
        nvidiaBusId = "";
      };
    };
  };

  displayManager = {
    sddm.enable = true;
    tuiGreet.enable = false;
  };

  locale = "en_GB.UTF-8";

  services.xserver.xkb = {
    layout = "gb";
    model = "";
    variant = "";
    options = "";
  };
  console = {
    earlySetup = true;
    keyMap = "uk";
  };
  time.timeZone = "Europe/London";
  boot.secureBoot.enable = true;
}
