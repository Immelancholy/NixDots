{pkgs, ...}: {
  home.packages = with pkgs; [
    reaper
  ];

  xdg.configFile."REAPER/UserPlugins/reaper_reapack-x86_64.so" = {
    source = "${pkgs.reaper-reapack-extension}/UserPlugins/reaper_reapack-x86_64.so";
  };
  home.file.".vst3/Dexed.vst3" = {
    source = "${pkgs.dexed}/lib/vst3/Dexed.vst3";
  };
}
