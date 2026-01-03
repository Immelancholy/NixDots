pkgs: {
  wooz = pkgs.callPackage ./wooz.nix {};
  bongo-cat = pkgs.callPackage ./bongo-cat.nix {};
  cavasik = pkgs.callPackage ./cavasik.nix {};
  autoeq-fiio = pkgs.callPackage ./autoeq-fiio.nix {};
}
