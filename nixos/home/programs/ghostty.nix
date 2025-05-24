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
      font-synthetic-style = false;
      cursor-style-blink = true;
      cursor-click-to-move = true;
      window-padding-balance = true;
      window-padding-x = 5;
      window-padding-y = 5;
      background-opacity = 0.8;
      desktop-notifications = true;
      window-padding-color = "background";
      title = "ghostty";
      alpha-blending = "linear-corrected";
      keybind = [
        "ctrl+s>c=new_tab"
        "ctrl+s>n=next_tab"
        "ctrl+s>p=previous_tab"
        "ctrl+s>1=goto_tab:1"
        "ctrl+s>2=goto_tab:2"
        "ctrl+s>3=goto_tab:3"
        "ctrl+s>4=goto_tab:4"
        "ctrl+s>5=goto_tab:5"
        "ctrl+s>6=goto_tab:6"
        "ctrl+s>7=goto_tab:7"
        "ctrl+s>8=goto_tab:8"
        "ctrl+s>9=goto_tab:9"

        "ctrl+s>'-'=new_split:down"
        "ctrl+s>'|'=new_split:right"
        "ctrl+s>h=goto_split:left"
        "ctrl+s>j=goto_split:bottom"
        "ctrl+s>k=goto_split:top"
        "ctrl+s>l=goto_split:right"
        "ctrl+s>shift+h=resize_split:left,100"
        "ctrl+s>shift+j=resize_split:down,100"
        "ctrl+s>shift+k=resize_split:up,100"
        "ctrl+s>shift+l=resize_split:right,100"
        "ctrl+s>x=close_surface"
        "ctrl+s>enter=toggle_split_zoom"
      ];
    };
  };
}
