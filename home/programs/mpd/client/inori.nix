{pkgs, ...}: {
  home.packages = with pkgs; [
    inori
  ];
  xdg.configFile."inori/config.toml".text = ''
    qwerty_keybindings = true

    [theme.item_highlight_active]
    fg = "#11111b"
    bg = "#cba6f7"

    [theme.item_highlight_inactive]
    fg = "#cdd6f4"
  '';
}
