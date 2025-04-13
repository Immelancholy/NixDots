{
  pkgs,
  inputs,
  config,
  ...
}: {
  nixpkgs.overlays = [inputs.rust-overlay.overlays.default];
  userAccounts.users = [];
  userAccounts.sudoUsers = ["mela"];

  home-manager.users.mela = {
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
    programs.cava = {
      settings = {
        input = {
          method = "pipewire";
          source = "58";
          sample_rate = 48000;
          sample_bits = 32;
        };
      };
    };
    wayland.windowManager.hyprland = {
      # ONLY ENABLE 1 LAYOUT!!
      layout = {
        master.enable = false;
        dwindle.enable = false;
        hy3.enable = true;
      };
      useHyprspace = true;
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
      };
    };
    home.sessionVariables = {
      NOTES_PATH = "/home/mela/Documents/Obsidian-Vault"; # path to notes folder ( for neovim )
      PROJECTS_PATH = "/home/mela/Projects"; # path to Projects folder ( for neovim )
    };
    home.packages = with pkgs; [
      (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {extensions = ["rust-src" "rust-analyzer"];}))
      reaper
      bespokesynth
      reaper-sws-extension
      teams-for-linux
      shotcut
      krita
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

  services.solaar.enable = true;
  hardware.logitech.wireless.enable = true;

  environment.sessionVariables = {
    FLAKE_PATH = "/home/mela/NixDots"; # path to flake.nix
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
        # intelBusId = ""; For Intel
        # amdgpuBusId = ""; For AMD
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
