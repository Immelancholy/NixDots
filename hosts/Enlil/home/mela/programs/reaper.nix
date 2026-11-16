{
  pkgs,
  inputs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    dexed
    lsp-plugins
    calf
    zlequalizer
    zlcompressor
    zlsplitter
    zam-plugins
    vital
    pipewire.jack
  ];
  programs.reaper = {
    enable = true;
    package = pkgs.reaper.override {
      jackLibrary = pkgs.pipewire.jack;
    };
    extensions = {
      reapack = {
        enable = true;
        repositories = [
          {
            name = "Bird-Bird";
            url = "https://github.com/Bird-Bird/ReaScript_Testing/raw/main/index.xml";
          }
          {
            name = "reaper-keys";
            url = "https://raw.githubusercontent.com/gwatcha/reaper-keys/master/index.xml";
          }
        ];

        packages = [
          {
            repository = "ReaTeam Extensions";
            category = "API";
            name = "js_ReaScriptAPI.ext";
          }
          {
            repository = "ReaTeam Extensions";
            category = "API";
            name = "reaper_imgui.ext";
          }
          {
            repository = "reaper-keys";
            category = "Scripts";
            name = "install-reaper-keys.lua";
          }
        ];

        synchronizeOnActivation = true;
      };
      sws.enable = true;

    };
    packages = with pkgs; [ ];
  };
}
