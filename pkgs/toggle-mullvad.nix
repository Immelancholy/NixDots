{
  writeShellApplication,
  pkgs,
}:
writeShellApplication {
  name = "toggle-mullvad";
  runtimeInputs = with pkgs; [tailscale];
  text = ''
    mullvad_on() {
        cmd=$(tailscale exit-node suggest | grep node:)
        suggested=''${cmd:21}

        sudo tailscale set --exit-node="$suggested"
    }
    mullvad_off() {
        sudo tailscale set --exit-node=
    }
    while getopts ":u:d:h:" option; do
        case $option in
            u)
                mullvad_on
                exit 0
                ;;
            d)
                mullvad_off
                exit 0
                ;;
            h)
                echo "Usage: $0 [-u to enable Mullvad exit node] [-d to disable Mullvad exit node]"
                exit 0
                ;;
            *)
                echo "Usage: $0 [-u to enable Mullvad exit node] [-d to disable Mullvad exit node]"
                exit 1
                ;;
        esac
    done
  '';
}
