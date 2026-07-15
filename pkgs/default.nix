{ self }:
pkgs: {
  autoeq-fiio = pkgs.callPackage ./autoeq-fiio.nix { };
  keychron-udev-rules = pkgs.callPackage ./keychron-udev-rules.nix { };
  momoisay = pkgs.callPackage ./momoisay.nix { inherit self; };
  pipemixer = pkgs.callPackage ./pipemixer.nix { inherit self; };
  toggle-tsui = pkgs.callPackage ./toggle-tsui.nix { inherit self; };
  bibata-hyprcursor = pkgs.callPackage ./bibata-hyprcursor { };
  toofan = pkgs.callPackage ./toofan.nix { inherit self; };
}
