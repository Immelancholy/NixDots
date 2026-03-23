pkgs: {
  autoeq-fiio = pkgs.callPackage ./autoeq-fiio.nix {};
  keychron-udev-rules = pkgs.callPackage ./keychron-udev-rules.nix {};
  toggle-exit-node = pkgs.callPackage ./toggle-exit-node.nix {};
}
