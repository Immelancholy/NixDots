pkgs: {
  autoeq-fiio = pkgs.callPackage ./autoeq-fiio.nix {};
  easyeffects = pkgs.callPackage ./easyeffects/package.nix {};
  zed-editor = pkgs.callPackage ./zed-editor.nix {};
  keychron-udev-rules = pkgs.callPackage ./keychron-udev-rules.nix {};
  toggle-exit-node = pkgs.callPackage ./toggle-exit-node.nix {};
}
