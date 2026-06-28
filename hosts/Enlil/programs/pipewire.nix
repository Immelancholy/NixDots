{
  services.pipewire = {
    extraConfig = {
      pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.allowed-rates" = [
            44100
            48000
            88200
            96000
            192000
          ];
          "default.clock.min-quantum" = 64;
          "default.clock.max-quantum" = 256;
          "default.clock.quantum-limit" = 512;
          "default.clock.quantum-floor" = 64;
        };
      };
      jack."92-low-latency" = {
        "jack.properties" = {
          "rt.prio" = 99;
          "node.latency" = "512/192000";
          "node.rate" = "1/192000";
          "node.quantum" = "512/192000";
          "node.force-quantum" = 512;
        };
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
