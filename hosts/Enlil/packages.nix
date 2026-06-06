{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    anifetch
    autoeq-fiio
    picard
    winboat
    freerdp
    sshpass
    nix-prefetch
    heroic
    # blender
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
    toggle-exit-node
  ];
}
