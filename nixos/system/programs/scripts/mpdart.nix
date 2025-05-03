{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "mpdart" ''
      source "${inputs.bash-utility}/src/format.sh"
      TMP="/tmp"
      COVER="$TMP/albumArt.jpg"
      MUSIC_DIR="~/Music"

      get_art () {
        song=$(mpc current --format %file%)
        if [ "$song" != "$song_old" ]; then
          clear
          title=$(mpc current --format %title%)
          DIR="$MUSIC_DIR$(dirname "$(mpc current -f %file%)")"
          for ART in "$DIR/cover."{png,jpg,webp}; do
            if [ -f "$ART" ]; then
              convert "$ART" $COVER &> /dev/null
            fi
          done
          artist=$(mpc current --format %artist%)
          line1="-------- $artist --------"
          line2="-------- $title --------"
          kitten icat --align=center "$COVER"
          format::text_center "$line1"
          format::text_center "$line2"
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
