{
  services.pipewire = {
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.allowed-rates" = [44100 48000 88200 96000 192000];
        "default.clock.min-quantum" = 64;
        "default.clock.max-quantum" = 256;
        "default.clock.quantum-limit" = 512;
        "default.clock.quantum-floor" = 64;
      };
    };
    wireplumber.extraConfig = {
      "51-bluez-config" = {
        "monitor.bluez.rules" = [
          {
            matches = [
              {
                "device.name" = "~bluez_card";
              }
            ];
            actions = {
              update-props = {
                "bluez5.a2dp.ldac.quality" = "hq";
              };
            };
          }
        ];
      };
    };
  };
}
