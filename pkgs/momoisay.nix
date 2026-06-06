{
  self,
  stdenv,
  ncurses,
}:
stdenv.mkDerivation {
  pname = "momoisay";
  version = "1.1.1";

  src = self.inputs.momoisay;

  nativeBuildInputs = [
    ncurses
  ];

  installPhase = /* bash */ ''
    mkdir -p $out/bin
    cp momoisay $out/bin
  '';
}
