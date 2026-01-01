{
  inputs,
  nix-relic,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-legion-t526amr5
  ];
  nix-relic = {
    flakePath = "/home/mela/.nix/nixos-config";
    updateScript.enableToken = true;
    cava = {
      framerate = 280;
      noiseReduction = 93;
    };
    framerates = {
      steamGamescopeSession = 280;
      neo = 280;
    };
    wallpaper = {
      path = "${nix-relic}/backgrounds/Sailor_Moon.png";
      animatedWallpaper = {
        enable = true;
        path = "${nix-relic}/backgrounds/Sailor_Moon.mp4";
      };
    };
    users.users = {
      mela = {
        isAdmin = true;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBLCQZSKxQcuHRUbEN7AK1lSf0VmXzTTYJA4BTs0pIgT Enlil"
        ];
        extraGroups = ["tty" "docker" "gamemode"];
        initialPassword = "password";
      };
    };
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

  nix.settings = {
    trusted-users = [
      "mela"
    ];
    experimental-features = [
      "pipe-operators"
    ];
  };

  nixpkgs = {
    config = {
      cudaSupport = true;
    };
    overlays = [
      inputs.anifetch.overlays.anifetch
      nix-relic.inputs.rust-overlay.overlays.default
    ];
  };

  networking = {
    nameservers = ["100.100.100.100" "192.242.2.2" "9.9.9.9"];
    search = ["jaglion-teeth.ts.net"];
  };

  boot.secureBoot.enable = true;
}
