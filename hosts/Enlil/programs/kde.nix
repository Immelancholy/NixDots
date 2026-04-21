{
  pkgs,
  lib,
  ...
}: {
  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = true;
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    konsole
    discover
    juk
    kate
    kwalletmanager
    kwallet
    kwallet-pam
    gwenview
    dolphin
  ];
  services.displayManager.sddm.package = lib.mkForce pkgs.kdePackages.sddm;
}
