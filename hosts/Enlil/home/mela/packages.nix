{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    (rust-bin.selectLatestNightlyWith (
      toolchain:
      toolchain.default.override {
        extensions = [
          "rust-src"
          "rust-analyzer"
        ];
      }
    ))
    osu-lazer-bin
    ani-cli
    momoisay
    temurin-bin
    bespokesynth
    reaper-sws-extension
    teams-for-linux
    stable.kdePackages.kdenlive
    krita
    qbittorrent
    rustlings
    obsidian
    obsidian-export
    gimp3-with-plugins
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.tsui.packages.${pkgs.stdenv.hostPlatform.system}.tsui
    blender
  ];
}
