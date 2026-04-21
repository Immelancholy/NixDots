{
  additions = final: _prev: import ../pkgs final.pkgs;
  modifications = final: prev: {
    ani-cli = prev.ani-cli.overrideAttrs (finalAttrs: previousAttrs: {
      src = prev.fetchFromGitHub {
        owner = "pystardust";
        repo = "ani-cli";
        tag = "v4.12";
        hash = "sha256-ELGjAp4YGgPLN62g7Fgkb83CMotAGeRnRgIGU8rd73E=";
      };
      runtimeInputs = with prev; [
        gnugrep
        gnused
        curl
        fzf
        ffmpeg
        aria2
        openssl
      ];
    });
  };
}
