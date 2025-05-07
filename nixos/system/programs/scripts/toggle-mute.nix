{pkgs, ...}: let
  toggle-mute = pkgs.writeShellScriptBin "toggle-mute" ''
    MUTED=$(wpctl get-volume @DEFAULT_SOURCE@)
    MUTED=''${MUTED:13}
    COMMES=$(wpctl status | grep "commes_mic_out" | awk '{print $2}' | grep -m1 "" | cut -f1 -d ".")
    function mute () {
      if [ "$MUTED" = "[MUTED]" ]; then
        wpctl mute @DEFAULT_SOURCE@ 0
        wpctl mute "$COMMES" 1
      elif [ "$COMMES" = "" ]; then
        wpctl mute @DEFAULT_SOURCE@ 1
        wpctl mute "$COMMES" 0
      fi
    }
    mute
  '';
in {
  environment.systemPackages = [
    toggle-mute
  ];
}
