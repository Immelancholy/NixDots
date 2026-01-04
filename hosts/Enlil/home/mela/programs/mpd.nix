{
  services.mpd = {
    network.listenAddress = "0.0.0.0";
    extraConfig = ''
      audio_output {
        type  "pipewire"
        name  "Pipewire Sound Server"
        target  "easyeffects_sink"
      }
    '';
  };
}
