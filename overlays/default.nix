{ self }:
{
  additions = final: prev: import ../pkgs { inherit self; } final.pkgs;
  modifications = final: prev: {
    ani-cli = prev.ani-cli.overrideAttrs ({
      src = "${self.inputs.ani-cli}";
      runtimeInputs = with prev.pkgs; [
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
