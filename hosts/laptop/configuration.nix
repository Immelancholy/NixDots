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
  disko.devices.disk.main.device = "/dev/sdb";
  # userAccounts.users = [
  # ]; # user accounts here
  # userAccounts.sudoUsers = [
  #   "mela"
  #   "larry"
  # ]; # sudo enabled accounts here (You'll want to go here if you're installing these. )

  users.users = {
    mela = {
      isNormalUser = true;
      description = "Account for Mela";
      extraGroups = ["networkmanager" "wheel" "video" "seat"];
      shell = pkgs.zsh;
      initialPassword = "password";
      uid = 1000;
    };
    larry = {
      isNormalUser = true;
      description = "Account for Larry";
      extraGroups = ["networkmanager" "wheel" "video" "seat"];
      shell = pkgs.zsh;
      initialPassword = "password";
      uid = 1001;
    };
  };
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

  home-manager.users.larry = {
    home.username = "larry";
    home.homedirectory = "/home/larry";
    imports = [
      ../../home
      # inputs.stylix.homemanagermodules.stylix
      ../../modules/home
      inputs.catppuccin.homemodules.catppuccin
      inputs.nixvim.homemanagermodules.nixvim
      inputs.spicetify-nix.homemanagermodules.default
      inputs.nix-flatpak.homemanagermodules.nix-flatpak
    ];
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
      useHyprspace = false;
      useLiveWallpaper = false;
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
  };
  home-manager.users.mela = {
    home.username = "mela";
    home.homedirectory = "/home/mela";
    imports = [
      ../../home
      # inputs.stylix.homemanagermodules.stylix
      ../../modules/home
      inputs.catppuccin.homemodules.catppuccin
      inputs.nixvim.homemanagermodules.nixvim
      inputs.spicetify-nix.homemanagermodules.default
      inputs.nix-flatpak.homemanagermodules.nix-flatpak
    ];
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
      useHyprspace = false;
      useLiveWallpaper = false;
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
  };

  services.qpwgraph.enable = true;

  services.solaar.enable = true;
  hardware.logitech.wireless.enable = true;

  environment.sessionVariables = {
    FLAKE_PATH = "/home/mela/NixDots"; # path to flake.nix
    SYSTEM = ".#nix-relic-laptop";
    FRAMERATE = 60;
  };

  programs.steam = {
    enable = false;
    gamescopeSession.enable = true;
  };

  services.mpdchck = {
    enable = false;
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
      finePowerManagement = true;
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
  boot.secureBoot.enable = true;
}
