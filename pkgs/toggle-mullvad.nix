{
  writeShellApplication,
  pkgs,
}:
writeShellApplication {
  name = "toggle-exit-node";
  runtimeInputs = with pkgs; [tailscale];
  text = ''
    node_on() {
        cmd=$(tailscale exit-node suggest | grep node:)
        suggested=''${cmd:21}

        sudo tailscale set --exit-node="$suggested"
        echo "Exit node set to: $suggested"
    }
    node_off() {
        sudo tailscale set --exit-node=
        echo "Exit node disabled."
    }
    while getopts ":udh:" option; do
        case $option in
            u)
                node_on
                exit 0
                ;;
            d)
                node_off
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
