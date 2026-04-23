{
  additions = final: _prev: import ../pkgs final.pkgs;
  modifications = final: prev: {
    ani-cli = prev.ani-cli.overrideAttrs (finalAttrs: previousAttrs: {
      src = prev.fetchFromGitHub {
        owner = "justchokingaround";
        repo = "ani-cli";
        rev = "967821592a52bf6d0481672b961f8ccae5d67cac";
        hash = "sha256-R+sXA5NZ/gDElMUTUHyOha7ZZ6FKgwTpAYuWUF4hqto=";
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
