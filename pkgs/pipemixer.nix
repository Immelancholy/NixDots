{
  stdenv,
  self,
  meson,
  python3Packages,
  pkg-config,
  pipewire,
  ncurses,
  inih,
}:
stdenv.mkDerivation {
  pname = "pipemixer";
  version = "git";

  src = self.inputs.pipemixer;

  nativeBuildInputs = [
    meson
    pkg-config
    python3Packages.ninja
  ];

  buildInputs = [
    pipewire
    ncurses
    inih
  ];
}
