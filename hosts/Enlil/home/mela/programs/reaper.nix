{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (reaper.override { jackLibrary = pkgs.pipewire.jack; })
    dexed
    lsp-plugins
    calf
    zlequalizer
    zlcompressor
    zlsplitter
    zam-plugins
  ];

  xdg.configFile."REAPER/UserPlugins/reaper_reapack-x86_64.so" = {
    source = "${pkgs.reaper-reapack-extension}/UserPlugins/reaper_reapack-x86_64.so";
  };
}
