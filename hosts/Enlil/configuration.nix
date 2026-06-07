{
  inputs,
  nix-relic,
  lib,
  ...
}:
let
  disable = lib.mkForce false;
in
{
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
      path = "${nix-relic}/backgrounds/Momo_Smoke.png";
      animatedWallpaper = {
        enable = true;
        path = "${nix-relic}/backgrounds/Momo_Smoke.mp4";
      };
    };
    users = {
      users = {
        mela = {
          isAdmin = true;
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBLCQZSKxQcuHRUbEN7AK1lSf0VmXzTTYJA4BTs0pIgT Enlil"
          ];
          extraGroups = [
            "tty"
            "docker"
            "gamemode"
          ];
          initialPassword = "password";
        };
      };
    };
  };

  users.groups = {
    audio.members = [ "mela" ];
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

  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "95";
    }
    {
      domain = "@audio";
      item = "nofile";
      type = "soft";
      value = "99999";
    }
    {
      domain = "@audio";
      item = "nofile";
      type = "hard";
      value = "99999";
    }
  ];

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
      nix-relic.inputs.rust-overlay.overlays.default
      inputs.millennium.overlays.default
      inputs.anifetch.overlays.anifetch
    ];
  };

  networking = {
    nameservers = [
      "100.100.100.100"
      "192.242.2.2"
      "9.9.9.9"
    ];
    search = [ "jaglion-teeth.ts.net" ];
    firewall = {
      allowedTCPPorts = [ 1234 ];
    };
  };

}
