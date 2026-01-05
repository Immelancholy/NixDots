{
  additions = final: _prev: import ../pkgs final.pkgs;
  modifications = final: prev: {
    gamemode = prev.gamemode.overrideAttrs (old: {
      src = prev.fetchFromGitHub {
        owner = "FeralInteractive";
        repo = "gamemode";
        rev = "f0a569a5199974751a4a75ebdc41c8f0b8e4c909";
        hash = "sha256-9DB8iWiyrM4EJ94ERC5SE9acrhqeI00BF1wU0umeNFg=";
      };
    });
    zed-editor = prev.zed-editor.overrideAttrs (old: {
      src = prev.fetchFromGitHub {
        owner = "zed-industries";
        repo = "zed";
        tag = "v0.217.3";
        hash = "sha256-flUkt39vttnF1HjzxLQ4pizFqxHxlIkaV+mb/GtxphU=";
      };
    });
  };
}
