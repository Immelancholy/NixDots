{pkgs, ...}: {
  userAccounts.users = [];
  userAccounts.sudoUsers = ["mela"];

  home-manager.users.mela = {
    home.packages = with pkgs; [
      reaper
      bespokesynth
      reaper-sws-extension
      teams-for-linux
      shotcut
      krita
    ];
    programs.git = {
      enable = true;
      userName = "Immelancholy";
      userEmail = "lenalowes0@gmail.com";
    };
    programs.cava = {
      input = {
        method = "pipewire";
        source = "58";
        sample_rate = 48000;
        sample_bits = 32;
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
    services.remmina = {
      enable = true;
    };
  };

  services.solaar.enable = true;

  environment.sessionVariables = {
    FLAKE_PATH = "/home/mela/NixDots"; #path to flake.nix
  };

  drivers = {
    amd.enable = false;
    nvidia.enable = true;
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
