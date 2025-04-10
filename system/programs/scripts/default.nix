{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "waycava.sh" (builtins.readFile ./Bash/waycava.sh))
    (writeShellScriptBin "rofi-power-menu" (builtins.readFile ./Bash/rofi-power-menu))
  ];
  imports = [
    ./hyprgame.nix
    ./btop.nix
    ./cava.nix
    ./checkshell.nix
    ./cliphist.nix
    ./mpdchck.nix
    ./sr.nix
    ./neo.nix
    # ./nv.nix
    ./rmpc.nix
    ./swww.nix
    ./tmux_dev.nix
    ./tmux_nix.nix
    ./tmux_notes.nix
    ./ss.nix
    ./muteChromium.nix
    ./restartQpwGraph.nix
  ];
}
