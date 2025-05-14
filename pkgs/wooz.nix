{
  stdenv,
  fetchFromGitHub,
  pkgs,
  ...
}:
stdenv.mkDerivation {
  pname = "wooz";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "negrel";
    repo = "wooz";
    rev = "9635978be9e8f179ffb03ab0ed4667fc1a93415e";
    hash = "sha256-V+INCnxqrJcv3krGIg1SU1tkazrw/d5iyZC/rdAfLJw=";
  };

  buildInputs = with pkgs; [
    meson
    ninja
  ];

  buildPhase = ''
    export CFLAGS="-03"
    meson build
    ninja -c build install
  '';

  installPhase = ''
    cp -r $src/bin $out/bin
  '';
}
