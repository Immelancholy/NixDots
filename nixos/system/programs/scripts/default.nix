{pkgs, ...}: {
  # environment.systemPackages = with pkgs; [
  #   (writeShellScriptBin "waycava.sh" (builtins.readFile ./Bash/waycava.sh))
  #   (writeShellScriptBin "rofi-power-menu" (builtins.readFile ./Bash/rofi-power-menu))
  # ];
  imports = [
    ./cavaCfg.nix
    ./neo-color-cfg.nix
  ];
}
