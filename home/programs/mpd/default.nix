{config, ...}: let
  user = config.home.username;
in {
  services = {
    mpd = {
      enable = true;
      network = {
        listenAddress = "/run/user/1000/mpd/socket";
        startWhenNeeded = true;
      };
      musicDirectory = "/home/${user}/Music";
      extraConfig = ''
        restore_paused "yes"

        metadata_to_use	"artist,albumartist,album,title,track,name,genre,date,composer,performer,disc"
        auto_update 	"yes"
        auto_update_depth "4"
        follow_outside_symlinks	"yes"
        follow_inside_symlinks		"yes"
        audio_output {
          type  "fifo"
          name  "mpd_cava"
          path  "/run/user/1000/mpd_cava.fifo"
          format  "44100:16:2"
        }
        # audio_output {
        #   type  "fifo"
        #   name  "mpd_waycava"
        #   path  "/run/user/1000/mpd_waycava.fifo"
        #   format  "44100:16:2"
        # }
        audio_output {
          type  "pipewire"
          name  "Pipewire Cava"
          target  "virtual_cable_in"
        }
      '';
    };
    mpdris2 = {
      enable = true;
      notifications = true;
    };
    mpd-discord-rpc = {
      enable = true;
      settings = {
        hosts = [
          "${config.services.mpd.network.listenAddress}:${builtins.toString config.services.mpd.network.port}"
        ];
        format = {
          details = "$title";
          state = "$On $album by $artist";
        };
      };
    };
  };
}
