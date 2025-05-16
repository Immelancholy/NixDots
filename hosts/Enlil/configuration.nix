{
  inputs,
  config,
  pkgs,
  ...
}: {
  nix-relic.users.users = {
    mela = {
      isAdmin = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBLCQZSKxQcuHRUbEN7AK1lSf0VmXzTTYJA4BTs0pIgT Enlil"
      ];
      extraGroups = ["tty"];
    };
  };

  nixpkgs.overlays = [inputs.rust-overlay.overlays.default];
  environment.systemPackages = with pkgs; [
    sshpass
    # anifetch
    nix-prefetch
  ];

  networking = {
    hostName = "Enlil";
    nameservers = ["100.100.100.100" "192.242.2.2" "9.9.9.9"];
    search = ["jaglion-teeth.ts.net"];
  };

  programs.weylus.users = [
    "mela"
  ];

  nix.settings.trusted-users = [
    "mela"
  ];

  security.pam = {
    services.sudo.rssh = true;
    rssh = {
      enable = true;
      settings = {
        auth_key_file = "/etc/ssh/authorized_keys.d/$user";
        loglevel = "debug";
      };
    };
  };

  stylix = {
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";

    image = ../../nixos/home/backgrounds/Evil_Miku.png;
  };

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

  # users.users.root.openssh.authorizedKeys.keys = [
  #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBLCQZSKxQcuHRUbEN7AK1lSf0VmXzTTYJA4BTs0pIgT Desktop"
  # ];

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

  services.solaar.enable = true;
  hardware.logitech.wireless.enable = true;

  environment.sessionVariables = {
    FLAKE_PATH = "/home/mela/NixDots"; # path to flake.nix
    FRAMERATE = 144;
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
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
    sddm = {
      enable = false;
      screenWidth = "1920";
      screenHeight = "1080";
      animatedBackground = {
        enable = true;
        path = ../../nixos/home/backgrounds/Evil_Miku.mp4;
      };
    };
    tuiGreet.enable = true;
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
