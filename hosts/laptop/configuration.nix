{
  inputs,
  config,
  ...
}: {
  disko.devices.disk.main.device = "/dev/sdb";
  userAccounts.users = [
  ]; # user accounts here
  userAccounts.sudoUsers = [
    "mela"
  ]; # sudo enabled accounts here (You'll want to go here if you're installing these. )
  imports = [
    ./users
  ];

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

  services.qpwgraph.enable = true;

  services.solaar.enable = true;
  hardware.logitech.wireless.enable = true;

  environment.sessionVariables = {
    FLAKE_PATH = "/home/mela/NixDots"; # path to flake.nix
    SYSTEM = ".#laptop";
    FRAMERATE = 60;
  };

  programs.steam = {
    enable = false;
    gamescopeSession.enable = true;
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
