{ pkgs, config, ... }:
let
  inherit (config.stylix.cursor) name size;
in
{
  home.packages = [
    pkgs.bibata-hyprcursor
  ];
  xdg.configFile."hypr/userconf.lua".text = /* Lua */ ''
    local cursor = "${name + "-Hyprcursor"} ${toString size}"
    hl.on("hyprland.start", function()
      hl.exec_cmd("hyprctl setcursor " .. cursor)
      hl.exec_cmd("hyprlock")
    end)

    hl.on("config.reloaded", function()
      hl.exec_cmd("hyprctl setcursor " .. cursor)
      hl.exec_cmd("hyprlock")
    end)

    function Universal_User_Binds()
      hl.bind(Moda .. " + D", hl.dsp.workspace.toggle_special("DAW"))
      hl.bind(Mods .. " + D", hl.dsp.window.move({ workspace = "special:DAW" }))
      hl.bind("F9", hl.dsp.pass({ window = "class:^(com.obsproject.Studio)$" }))
      hl.bind("F10", hl.dsp.pass({ window = "class:^(com.obsproject.Studio)$" }))
      hl.bind("F12", hl.dsp.pass({ window = "class:^(com.obsproject.Studio)$" }))
    end
    function Default_User_Binds() end
    function Manage_User_Binds() end
    function Resize_User_Binds() end
    function Move_User_Binds() end
    function Player_User_Binds() end

    hl.window_rule({
      match = {
        class = "^(REAPER)$",
      },
      workspace = "special:DAW",
    })
    hl.window_rule({
      match = {
        title = "^(REAPER v.* - EVALUATION LICENSE)$",
      },
      fullscreen = true,
    })
    hl.window_rule({
      name = "tsui-top-bar",
      match = { title = "^(tsui-top-bar)$" },
      float = true,
      pin = true,
      size = "715 565",
      move = { 1115, 50 },
    })
  '';
}
