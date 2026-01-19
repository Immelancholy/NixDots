{
  writeShellApplication,
  pkgs,
}:
writeShellApplication {
  name = "toggle-exit-node";
  runtimeInputs = with pkgs; [tailscale];
  text = ''
    lan_access=false
    node_on() {
        cmd=$(tailscale exit-node suggest | grep node:)
        suggested=''${cmd:21}

        if [ "$lan_access" == true ]; then
            sudo tailscale set --exit-node="$suggested" --exit-node-allow-lan-access=true
        else
            sudo tailscale set --exit-node="$suggested"
        fi
        echo "Exit node set to: $suggested"
    }
    node_off() {
        sudo tailscale set --exit-node=
        echo "Exit node disabled."
    }
    while getopts "udlh" option; do
        case $option in
            u)
                node_on
                exit 0
                ;;
            d)
                node_off
                exit 0
                ;;
            l)
                lan_access=true
                ;;
            h)
                echo "Usage: $0 [-u to enable Mullvad exit node] [-d to disable Mullvad exit node] [-l enable lan access]"
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
