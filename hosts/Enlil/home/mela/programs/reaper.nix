{pkgs, ...}: {
  home.packages = with pkgs; [
    reaper
    dexed
    lsp-plugins
    calf
    zlequalizer
    zlcompressor
    zlsplitter
  ];

  xdg.configFile."REAPER/UserPlugins/reaper_reapack-x86_64.so" = {
    source = "${pkgs.reaper-reapack-extension}/UserPlugins/reaper_reapack-x86_64.so";
  };
}
