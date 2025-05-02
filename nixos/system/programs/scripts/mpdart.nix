{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "mpdart" ''
      function get_screen_width()
      {
          screen_width=$(tput cols)
          declare -g screen_width
      }
      function center_text()
      {
          textsize=''${#1}
          span=$(((screen_width + textsize) / 2))

          printf '%*s\n' "''${span}" "$1"
      }
      get_art () {
        song=$(mpc current --format %file%)
        if [ "$song" != "$song_old" ]; then
          clear
          art=$(playerctl --player=mpd metadata --format "{{mpris:artUrl}}")
          title=$(mpc current --format %title%)
          artist=$(mpc current --format %artist%)
          line1="-------- $artist --------"
          line2="-------- $title --------"
          kitten icat --align=center "$art"
          get_screen_width
          center_text "$line1"
          center_text "$line2"
          song_old=$song
        fi
      }

      while :
      do
        state=$(mpc status %state%)
        if [ "$state" = "playing" ]; then
          get_art
        elif [ "$state" = "stopped" ]; then
          song_old=""
          clear
        fi
      done
    '')
  ];
}
