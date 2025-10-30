{
  inputs,
  config,
  pkgs,
  ...
}: let
  llm-git-commit = inputs.llm-git-commit.packages.${pkgs.system}.default;
  pyWithLlm = (
    pkgs.python3.withPackages (ps: [ps.llm ps.llm-mistral llm-git-commit ps.llm-openrouter])
  );
  llm-with-plugins = (
    pkgs.writeShellScriptBin "llm" ''
      exec ${pyWithLlm}/bin/llm "$@"
    ''
  );
in {
  nix-relic = {
    users.users = {
      mela = {
        isAdmin = true;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBLCQZSKxQcuHRUbEN7AK1lSf0VmXzTTYJA4BTs0pIgT Enlil"
        ];
        extraGroups = ["tty" "docker"];
        initialPassword = "password";
      };
    };
    wallpaper = {
      path = "${inputs.nix-relic-modules}/backgrounds/Momo_Smoke.png";
      animatedWallpaper = {
        enable = true;
        path = "${inputs.nix-relic-modules}/backgrounds/Momo_Smoke.mp4";
      };
    };
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  services.lsfg-vk.enable = true;

  nixpkgs.overlays = [
    inputs.anifetch.overlays.anifetch
    inputs.rust-overlay.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    inputs.winboat.packages.${pkgs.system}.winboat
    llm-with-plugins
    freerdp
    sshpass
    anifetch
    nix-prefetch
    heroic
    blender
    nodePackages_latest.nodejs
  ];

  networking = {
    nameservers = ["100.100.100.100" "192.242.2.2" "9.9.9.9"];
    search = ["jaglion-teeth.ts.net"];
  };

  programs.weylus.users = [
    "mela"
  ];

  nix.settings.trusted-users = [
    "mela"
  ];

  services.tailscale = {
    enable = true;
  };

  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      MaxStartups = 3;
      AllowTcpForwarding = "no";
    };
  };

  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.allowed-rates" = [44100 48000 88200 96000];
      "default.clock.min-quantum" = 64;
      "default.clock.max-quantum" = 512;
      "default.clock.quantum-limit" = 4096;
      "default.clock.quantum-floor" = 32;
    };
  };

  services.qpwgraph.enable = true;

  services.solaar = {
    enable = true;
    package = inputs.solaar.packages.${pkgs.system}.default;
  };
  hardware.logitech.wireless.enable = true;

  environment.sessionVariables = {
    FLAKE_PATH = "/home/mela/NixDots"; # path to flake.nix
    FRAMERATE = 280;
  };

  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
    };
  };

  services.mpdchck = {
    enable = true;
  };

  drivers = {
    amd.enable = false;
    intel.enable = false;
    nvidia = {
      enable = true;
      open = true;
      powerManagement = true;
      finePowerManagement = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      prime = {
        enable = false;
        # intelBusId = ""; # For Intel
        # amdgpuBusId = ""; # For AMD
        nvidiaBusId = "";
      };
    };
  };

  displayManager = {
    sddm = {
      enable = true;
      screenWidth = "1920";
      screenHeight = "1080";
    };
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
