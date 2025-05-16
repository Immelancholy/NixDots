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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+5oVR8PMnCW5lP533YWut9mqzqj+Fepk5U9Uo/sKbv Laptop"
      ];
      extraGroups = ["tty"];
    };
    luka = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+5oVR8PMnCW5lP533YWut9mqzqj+Fepk5U9Uo/sKbv Laptop"
      ];
      extraGroups = ["tty"];
    };
  };

  networking = {
    hostName = "Ereshkigal";
    nameservers = ["100.100.100.100" "192.242.2.2" "9.9.9.9"];
    search = ["jaglion-teeth.ts.net"];
  };

  programs.weylus.users = [
    "mela"
  ];

  nix.settings.trusted-users = [
    "mela"
  ];

  security.pam.sshAgentAuth = {
    enable = true;
    authorizedKeysFiles = [
      "/etc/ssh/authorized_keys.d/%u"
    ];
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
      PermitRootLogin = "no";
      MaxStartups = 3;
      AllowTcpForwarding = "no";
    };
  };

  # users.users.root.openssh.authorizedKeys.keys = [
  #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+5oVR8PMnCW5lP533YWut9mqzqj+Fepk5U9Uo/sKbv Laptop"
  # ];

  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.allowed-rates" = [44100 48000 88200 96000 192000];
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
    FRAMERATE = 60;
  };

  programs.steam = {
    enable = false;
    gamescopeSession.enable = false;
  };

  services.mpdchck = {
    enable = false;
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
    sddm = {
      enable = true;
      animatedBackground = {
        enable = true;
        path = ../../nixos/home/backgrounds/Evil_Miku.mp4;
      };
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
