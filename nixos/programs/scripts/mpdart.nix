{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "mpdart" ''
      get_art () {
        song=$(playerctl --player=mpd metadata --format "{{title}}")
        art=$(playerctl --player=mpd metadata --format "{{mpris:artUrl}}")
        if [ "$song" != "$song_old" ]; then
          clear
          echo " "
          echo " "
          echo " "
          kitten icat --align=center "$art"
          song_old=$song
        fi
      }

      while :
      do
        state=$(mpc status %state%)
        if [ "$state" = "playing" ]; then
          get_art
        fi
        song_old=""
      done
    '')
  ];
}
