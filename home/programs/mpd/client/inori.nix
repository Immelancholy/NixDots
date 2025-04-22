{pkgs, ...}: {
  home.packages = with pkgs; [
    inori
    miniplayer
  ];
  xdg.configFile."inori/config.toml".text = ''
    qwerty_keybindings = true

    [theme.item_highlight_active]
    fg = "#11111b"
    bg = "#cba6f7"

    [theme.item_highlight_inactive]
    fg = "#cdd6f4"

    [theme.block_active]
    fg = "#cba6f7"

    [theme.playing]
    fg = "#cba6f7"

    [theme.status_artist]
    fg = "#89dceb"

    [theme.status_album]
    fg = "#cba6f7"

    [theme.album]
    fg = "#cba6f7"
  '';
  xdg.configFile."miniplayer/config" = ''
    [player]
    font_width      = 11
    font_height     = 24
    volume_step     = 5
    auto_close      = false
    album_art_only  = true
    show_playlist   = true

    [art]
    image_method    = pixcat

    [mpd]
    host   = localhost
    port   = 6600
    # pass = example

    # [keybindings]
    # >      = next_track
    # <      = last_track
    # +      = volume_up
    # -      = volume_down
    # p      = play_pause
    # q      = quit
    # h      = help
    # i      = toggle_info
    # up     = select_up
    # down   = select_down
    # enter  = select
    # Up     = move_up
    # Down   = move_down
    # delete = delete
    # x      = shuffle
    # r      = repeat
    # :      = command_line

    # [theme]
    # # If a color is set to "auto", it will automatically pick the color based on the album art
    # accent_color = auto
    # bar_color = auto
    # time_color = white
    # command_hierarchy_color = yellow
    # command_sep_color = white
    #
    # # The command line
    # command_sep  = ->
    # command_char = :
    #
    # # The progress bar. Only one character allowed for body and head
    # bar_body = -
    # bar_head = >
  '';
}
