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
  userAccounts.users = [
  ]; # user accounts here
  userAccounts.sudoUsers = [
    "mela"
  ]; # sudo enabled accounts here (You'll want to go here if you're installing these. )

  services.openssh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+5oVR8PMnCW5lP533YWut9mqzqj+Fepk5U9Uo/sKbv Laptop"
  ];

  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.allowed-rates" = [44100 48000 88200 96000 192000];
      "default.clock.min-quantum" = 64;
      "default.clock.max-quantum" = 512;
      "default.clock.quantum-limit" = 4096;
      "default.clock.quantum-floor" = 32;
    };
  };

  home-manager.users.mela = {
    programs.obs-studio.enable = false;
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
      useLiveWallpaper = false;
      settings = {
        cursor = {
          no_hardware_cursors = false;
        };
        monitor = ", preferred, auto, 1";
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
    home.sessionVariables = {
      NOTES_PATH = "/home/mela/Documents/Obsidian-Vault"; # path to notes folder ( for neovim )
      PROJECTS_PATH = "/home/mela/Documents/Projects"; # path to Projects folder ( for neovim )
    };
    home.packages = with pkgs; [
      # reaper
      # inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
      # temurin-bin
      # bespokesynth
      # reaper-sws-extension
      # teams-for-linux
      # shotcut
      # krita
      # qbittorrent
      # rustlings
      # obsidian
      # obsidian-export
    ];
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      plugins = {
        obsidian = {
          enable = false;
          settings = {
            ui.enable = false;
            workspaces = [
              {
                name = "";
                path = "";
              }
            ];
          };
        };
      };
    };
    services.flatpak = {
      packages = [
      ];
    };
  };

  services.qpwgraph.enable = true;

  services.solaar.enable = true;
  hardware.logitech.wireless.enable = true;

  environment.sessionVariables = {
    FLAKE_PATH = "/home/mela/Nix-Relic"; # path to flake.nix
  };

  programs.steam = {
    enable = false;
    gamescopeSession.enable = true;
  };

  services.mpdchck = {
    enable = true;
    address = "/run/user/1000/mpd/socket";
    port = 6600;
  };

  drivers = {
    amd.enable = false;
    intel.enable = false;
    nvidia = {
      enable = true;
      open = false;
      powerManagement = true;
      finePowerManagement = false;
      # package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
      prime = {
        enable = true;
        intelBusId = "PCI:0:2:0"; # For Intel
        # amdgpuBusId = ""; # For AMD
        nvidiaBusId = "PCI:1:0:0";
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
  boot.secureBoot.enable = false;
}
