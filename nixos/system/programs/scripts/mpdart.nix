{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "mpdart" ''
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
          columns=$(tput cols)
          printf "%*s\n" $(((''${#line1}+$columns)/2)) "$line1"
          printf "%*s\n" $(((''${#line2}+$columns)/2)) "$line2"
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
