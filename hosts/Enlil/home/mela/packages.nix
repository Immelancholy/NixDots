{
  pkgs,
  inputs,
  ...
}: let
  momoisay = pkgs.stdenv.mkDerivation {
    pname = "momoisay";
    version = "1.1.1";

    src = inputs.momoisay;

    nativeBuildInputs = with pkgs; [
      ncurses
    ];

    installPhase =
      /*
      bash
      */
      ''
        mkdir -p $out/bin
        cp momoisay $out/bin
      '';
  };
in {
  home.packages = with pkgs; [
    (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {extensions = ["rust-src" "rust-analyzer"];}))
    prismlauncher
    (ani-cli.overrideAttrs (finalAttrs: previousAttrs: {
      src = "${inputs.ani-cli}";
      runtimeInputs = with pkgs; [
        gnugrep
        gnused
        curl
        fzf
        ffmpeg
        aria2
        openssl
      ];
    }))
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
    inkscape-with-extensions
    inputs.alejandra.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    blender
  ];
}
