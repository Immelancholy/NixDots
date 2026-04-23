{lib, ... }: {
  programs.zen-browser.enable = lib.mkForce false;
}
