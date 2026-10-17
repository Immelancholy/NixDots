{
  pkgs,
  lib,
  ...
}:
let
  steam_pkg = pkgs.millennium-steam.override {
    extraEnv = {
      OBS_VKCAPTURE = true;
      MANGOHUD = true;
      DXVK_HUD = "compiler";
      LD_PRELOAD = "${pkgs.gamemode.lib}/lib/libgamemode.so";
    };
  };
in
{
  programs.steam = {
    enable = true;
    package = lib.mkForce steam_pkg;
    gamescopeSession = {
      enable = true;
    };
  };
}
