{
  inputs,
  config,
  pkgs,
  ...
}: {
  disko.devices.disk.main.device = "/dev/nvme0n1";
  nixpkgs.overlays = [inputs.rust-overlay.overlays.default];
  networking.hostName = "nix-relic-desktop";
  userAccounts.users = [];
  userAccounts.sudoUsers = ["mela"];

  imports = [
    ./users
  ];

  stylix = {
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";

    image = ../../nixos/home/backgrounds/Makima_Midnight.png;
  };

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
      enable = true;
      animatedBackground = {
        enable = true;
        path = ../../nixos/home/backgrounds/Makima_Midnight.mp4;
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
