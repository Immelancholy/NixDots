{pkgs, ...}: {
  home.packages = with pkgs; [
    inori
  ];
  xdf.configFile."inori/config.toml".text = ''
    qwerty_keybindings = true

    [theme.item_highlight_active]
    fg = "#cba6f7"
    bg = "#11111b"

    [theme.item_highlight_inactive]
    bg = "#cdd6f4"
  '';
}
