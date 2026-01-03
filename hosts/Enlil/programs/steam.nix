{
  pkgs,
  lib,
  ...
}: let
  steam_pkg = pkgs.steam.override {
    extraEnv = {
      OBS_VKCAPTURE = true;
      MANGOHUD = true;
      DXVK_HUD = "compiler";
      LD_PRELOAD = "${pkgs.gamemode.lib}/lib/libgamemode.so";
      PROTON_ENABLE_WAYLAND = 1;
      PROTON_USE_NTSYNC = 1;
    };
  };
in {
  programs.steam = {
    enable = true;
    package = lib.mkDefault steam_pkg;
    gamescopeSession = {
      enable = true;
    };
  };
}
