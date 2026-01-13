{nix-relic, ...}: {
  nix-relic = {
    flakePath = "/home/mela/NixDots";
    updateScript.enableToken = true;
    cava = {
      framerate = 60;
      noiseReduction = 72;
    };
    framerates = {
      steamGamescopeSession = 60;
      neo = 60;
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
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+5oVR8PMnCW5lP533YWut9mqzqj+Fepk5U9Uo/sKbv Ereshkigal"
        ];
        extraGroups = ["tty"];
      };
      luka = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+5oVR8PMnCW5lP533YWut9mqzqj+Fepk5U9Uo/sKbv Ereshkigal"
        ];
        extraGroups = ["tty"];
      };
    };
  };

  networking = {
    nameservers = ["100.100.100.100" "192.242.2.2" "9.9.9.9"];
    search = ["jaglion-teeth.ts.net"];
  };

  nix.settings.trusted-users = [
    "mela"
  ];

  stylix = {
    polarity = "dark";
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
