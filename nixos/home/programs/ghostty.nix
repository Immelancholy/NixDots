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
        "ctrl+c>c=new_tab"
        "ctrl+c>n=next_tab"
        "ctrl+c>p=previous_tab"
        "ctrl+c>1=goto_tab:1"
        "ctrl+c>2=goto_tab:2"
        "ctrl+c>3=goto_tab:3"
        "ctrl+c>4=goto_tab:4"
        "ctrl+c>5=goto_tab:5"
        "ctrl+c>6=goto_tab:6"
        "ctrl+c>7=goto_tab:7"
        "ctrl+c>8=goto_tab:8"
        "ctrl+c>9=goto_tab:9"

        "ctrl+c>d=new_split:down"
        "ctrl+c>r=new_split:right"
        "ctrl+c>h=goto_split:left"
        "ctrl+c>j=goto_split:bottom"
        "ctrl+c>k=goto_split:top"
        "ctrl+c>l=goto_split:right"
        "ctrl+c>shift+h=resize_split:left,100"
        "ctrl+c>shift+j=resize_split:down,100"
        "ctrl+c>shift+k=resize_split:up,100"
        "ctrl+c>shift+l=resize_split:right,100"
        "ctrl+c>x=close_surface"
        "ctrl+c>enter=toggle_split_zoom"
      ];
    };
  };
}
