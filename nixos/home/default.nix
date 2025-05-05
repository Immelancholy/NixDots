{
  nixosConfig,
  lib,
  config,
  pkgs,
  ...
}: let
  user = config.home.username;
in {
  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  imports = [
    ./programs
    ./themeing.nix
    ./zsh.nix
    ./env.nix
    ./mimeapps.nix
    ./stylix.nix
    ./activationScripts
  ];

  xdg = {
    enable = true;
    userDirs.enable = true;
    configFile = {
      "autostart/input-mapper-autoload.desktop" = lib.mkIf nixosConfig.services.input-remapper.enable {
        source = "${nixosConfig.services.input-remapper.package}/share/applications/input-remapper-autoload.desktop";
      };
      "uwsm/env".text = ''
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export QT_AUTO_SCREEN_SCALE_FACTOR=1
        export GDK_SCALE=1
        export XCURSOR_THEME="${config.stylix.cursor.name}"
        export XCURSOR_SIZE=${config.stylix.cursor.size}
      '';
      "uwsm/env-hyprland".text = ''
        export NIXOS_OZONE_WL=1
        export QT_QPA_PLATFORM="wayland;xcb"
        export MOZ_ENABLE_WAYLAND=1
        export GDK_BACKEND="wayland,x11
        export HYPRCURSOR_THEME="${config.stylix.cursor.name}"
        export HYPRCURSOR_SIZE=${config.stylix.cursor.size}
      '';
    };
  };
  home.file = {
    ".vimium/Vimium-C-Binds.json".text = ''
      {
        "name": "Vimium C",
        "@time": "14/04/2025, 12:38:22",
        "time": 1744630702689,
        "environment": {
          "extension": "1.99.997",
          "platform": "linux",
          "firefox": 137
        },
        "keyLayout": 2,
        "keyMappings": [
          "#!no-check",
          "unmap t",
          "map J nextTab",
          "map K previousTab",
          ""
        ],
        "vimSync": true
      }
    '';
    "Pictures/wallpapers" = {
      source = ./backgrounds;
      recursive = true;
    };
  };

  home.stateVersion = "25.05";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
