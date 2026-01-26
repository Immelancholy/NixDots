{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {extensions = ["rust-src" "rust-analyzer"];}))
    reaper
    prismlauncher
    inputs.viu.packages.${pkgs.stdenv.hostPlatform.system}.default
    temurin-bin
    bespokesynth
    reaper-sws-extension
    teams-for-linux
    kdePackages.kdenlive
    krita
    qbittorrent
    rustlings
    obsidian
    obsidian-export
    gimp3-with-plugins
    inkscape-with-extensions
    pinta
    inputs.affinity-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    brave
    inputs.alejandra.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
