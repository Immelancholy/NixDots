{
  services.mpd = {
    network.listenAddress = "0.0.0.0";
    extraConfig = ''
      audio_output {
        type  "pipewire"
        name  "Pipewire Sound Server"
        target  "alsa_output.usb-Focusrite_Scarlett_2i2_4th_Gen_S2FR37A5837814-00.pro-output-0"
      }
    '';
  };
}
