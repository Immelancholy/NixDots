{
  writeShellApplication,
  procps,
  kitty,
  self,
  uwsm,
  pkgs,
  lib,
}:
let
  tsui-top-bar = writeShellApplication {
    name = "tsui-top-bar";
    runtimeInputs = [
      self.inputs.tsui.packages.${pkgs.stdenv.hostPlatform.system}.tsui
    ];
    text = ''
      tsui "$@"
    '';
  };
in
writeShellApplication {
  name = "toggle-tsui";
  runtimeInputs = [
    procps
    kitty
    uwsm
  ];
  text = /* Bash */ ''
    if pgrep -f "kitty.*tsui-top-bar" >/dev/null; then
            pkill -f "kitty.*tsui-top-bar"
    elif pgrep -f "kitty.*-top-bar" >/dev/null; then
            pkill -f "kitty.*-top-bar"
            uwsm-app -- kitty --class "tsui" --title "tsui-top-bar" -e ${lib.getExe tsui-top-bar} "$@"
    else
            uwsm-app -- kitty --class "tsui" --title "tsui-top-bar" -e ${lib.getExe tsui-top-bar} "$@"
    fi
  '';
}
