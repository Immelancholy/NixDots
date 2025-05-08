{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "mpdart" ''
      stty -echo
      tput civis
      TMP="/tmp"
      COVER="$TMP/albumArt.jpg"
      MUSIC_DIR="$HOME/Music"
      PROG_NAME=$(basename "$0")

      get_colors () {
        config="$XDG_CONFIG_HOME/mpdart"
        colorfile="$config/colors"
        if [ -f "$colorfile" ]; then
          colors=()
          while IFS= read -r color; do
            colors+=("$color")
          done < "$colorfile"

          col1=$(tput setaf ''${colors[0]})
          col2=$(tput setaf ''${colors[1]})
          col3=$(tput setaf ''${colors[2]})
          col4=$(tput setaf ''${colors[3]})
          col5=$(tput setaf ''${colors[4]})
        else
          mkdir -p $config
      cat > $colorfile <<EOF
      7
      7
      7
      7
      4
      EOF

          colors=()
          while IFS= read -r color; do
            colors+=("$color")
          done < "$colorfile"

          col1=$(tput setaf ''${colors[0]})
          col2=$(tput setaf ''${colors[1]})
          col3=$(tput setaf ''${colors[2]})
          col4=$(tput setaf ''${colors[3]})
          col5=$(tput setaf 7)
        fi
      }

      show_help() {
          printf "%s" "\
      usage: mpdart [-h|--help] [--music_dir \"path/to/dir\"]

      optional arguments:
         -h, --help            show this help message and exit
         --music_dir           the music directory which MPD plays from
      "
      }

      options=$(getopt -o h --long 'music_dir:,verbose,help' -- "$@")
      eval set -- "$options"

      while true; do
          case "$1" in
              --music_dir)
                  shift;
                  MUSIC_DIR=$1
                  ;;
              -h|--help)
                  show_help
                  exit
                  ;;
              --)
                  shift
                  break
                  ;;
          esac
          shift
      done

      cleanup () {
        stty echo
        tput cvvis
        clear
        exit 1
      }

      trap cleanup SIGINT

      get_art () {
        song=$(mpc current --format %file%)
        if [ "$song" != "$song_old" ]; then
          clear
          title=$(mpc current --format %title%)
          album=$(mpc current --format %album%)
          DIR="$MUSIC_DIR/$(dirname "$(mpc current -f %file%)")"
          ffmpeg -i "$MUSIC_DIR/$(mpc current -f %file%)" "$COVER" -y &> /dev/null
          if ! [ $? -eq 0 ]; then
            for ART in "$DIR/cover."{png,jpg,webp}; do
              if [ -f "$ART" ]; then
                convert "$ART" $COVER &> /dev/null
              fi
            done
            for ART in "$DIR/../cover."{png,jpg,webp}; do
              if [ -f "$ART" ]; then
                convert "$ART" $COVER &> /dev/null
              fi
            done
          fi
          artist=$(mpc current --format %artist%)
          line1="''${col1}$title"
          line2="''${col2}$artist ''${col3}- ''${col4}$album"
          line2="''${line2:0:48}"
          line3="''${col5}─────────────────────────────────╶"
          kitten icat --align=center "$COVER"
          printf '%s\n' "$line1"
          printf '%s\n' "$line2"
          printf '%s' "$line3"
          song_old=$song
        fi
      }

      FIRST_RUN=true

      main () {
        while :
        do
          state=$(mpc status %state%)
          cols=$(tput cols)
          if [ "$FIRST_RUN" == true ]; then
            FIRST_RUN=false
            cols_old=$cols
            clear
          fi
          if [ "$cols" != "$cols_old" ]; then
            song_old=""
            get_art
            cols_old=$cols
          fi
          if [ "$state" = "playing" ]; then
            get_art
          elif [ "$state" = "stopped" ]; then
            song_old=""
            clear
          fi
          read -rsn1 -t 0.00001 key
          if [ "$key" = 'q' ]; then
            break
          fi
        done
      }

      get_colors
      main
      stty echo
      tput cvvis
      clear
      exit 0
    '')
  ];
}
