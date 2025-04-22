{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "mpdart" ''
      get_art () {
        song=$(playerctl --player=mpd metadata --format "{{title}}")
        art=$(playerctl --player=mpd metadata --format "{{mpris:artUrl}}")
        if [ "$song" != "$song_old" ]; then
          clear
          kitten icat --align=center "$art"
          playerctl --player=mpd metadata --format "-------- {{artist}} --------"
          playerctl --player=mpd metadata --format "{{title}}"
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
