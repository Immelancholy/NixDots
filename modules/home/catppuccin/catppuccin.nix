{
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.catppuccin.zen;
  user = config.home.username;
in {
  options.catppuccin.zen = {
    enable = mkEnableOption "enable catppuccin zen theme";
  };

  config = mkIf cfg.enable {
    home.file = {
      ".zen/${user}.Default/chrome/userChrome.css" = {
        source = "${inputs.catppuccinZen}/themes/Mocha/Mauve/userChrome.css";
      };
      ".zen/${user}.Default/chrome/userContent.css" = {
        source = "${inputs.catppuccinZen}/themes/Mocha/Mauve/userContent.css";
      };
      ".zen/${user}.Default/chrome/zen-logo-mocha.svg" = {
        source = "${inputs.catppuccinZen}/themes/Mocha/Mauve/zen-logo-mocha.svg";
      };
      ".zen/profiles.ini".text = ''
        [Profile0]
        Name=${user}Default
        IsRelative=1
        Path=${user}.Default
        ZenAvatarPath=chrome://browser/content/zen-avatars/avatar-82.svg
        Default=1

        [General]
        StartWithLastProfile=1
        Version=2
      '';
    };
  };
}
