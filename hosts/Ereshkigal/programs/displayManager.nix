{nix-relic, ...}: {
  displayManager = {
    sddm = {
      enable = true;
      animatedBackground = {
        enable = true;
        path = "${nix-relic}/backgrounds/Evil_Miku.mp4";
      };
    };
    tuiGreet.enable = false;
  };
}
