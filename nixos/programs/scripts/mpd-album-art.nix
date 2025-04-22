{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "mpdArt" ''
      while :
      do
        state=$(playerctl --player=mpd status)
        if ["$state" = "Playing"]; then
          while :
          do
            state=$(playerctl --player=mpd status)
            if [ "$state" != "Playing" ]; then
              break
            else
              while "$currentTrack" != "$oldTrack"
              do
                currentTrack=$(playerctl --player=mpd metadata --format "{{title}}")
                art=$(playerctl --player=mpd metadate --format "{{mpris:artUrl}}")

                ${pkgs.kitty}/bin/kitten icat $art

                oldTrack=''${currentTrack}
              done
            fi
          done
        fi
      done
    '')
  ];
}
