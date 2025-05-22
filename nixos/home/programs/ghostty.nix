{
  inputs,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default;
    installVimSyntax = true;
    settings = {
      cursor-style-blink = true;
      cursor-click-to-move = true;
      window-padding-balance = true;
      window-padding-x = 5;
      window-padding-y = 5;
      background-opacity = 0.80;
      desktop-notifications = true;
      gtk-gsk-renderer = "default";
      window-padding-color = "background";
    };
  };
}
