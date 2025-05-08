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
      C1=""
      C2=""
      C3=""

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
          black=$(tput setaf 0) # Black - Regular
          red=$(tput setaf 1) # Red
          green=$(tput setaf 2) # Green
          yellow=$(tput setaf 3) # Yellow
          blue=$(tput setaf 4) # Blue
          purple=$(tput setaf 5) # Purple
          cyan=$(tput setaf 6) # Cyan
          white=$(tput setaf 7) # White
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
          line1="''${white}$title"
          line2="''${white}$artist - $album"
          line2="''${line2:0:48}"
          line3="''${blue}─────────────────────────────────╶"
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

      main
      stty echo
      tput cvvis
      clear
      exit 0
    '')
  ];
}
