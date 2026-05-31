{config, lib, pkgs, ...}: let
  inherit (config.player) cmd class;
  inherit (config.wayland.windowManager.hyprland) liveWallpaper;
  paper-change = pkgs.writeShellScriptBin "paper-change" ''
    if command -v mpvpaper
    then
      pkill mpvpaper
      uwsm app -- mpvpaper -f -p -o "--loop no-audio" '*' ${liveWallpaper.path}
    else
      pkill mpvpaper
    fi
  '';
in {

  xdg.configFile."hypr/lua/autostart.lua".text =
    /*
    Lua
    */
    ''
      local browser = Browser
      local discord = Discord
      local editor = Editor
      local files = Files
      local filest = Filest
      local menu = Editor
      local mod = Mod
      local moda = Moda
      local modc = Modc
      local mods = Mods
      local player = Player
      local playerctl = Playerctl
      local scr = Scr
      local term = Term

      local function launches()
        hl.dispatch(hl.dsp.exec_cmd("dunstctl set-paused true"))
        hl.dispatch(hl.dsp.exec_cmd("dunstctl close-all"))
        hl.dispatch(hl.dsp.exec_cmd("pkill localsend"))
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(${class})$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(neo)$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(fastfetch)$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(btop)$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(cava)$" }))
        hl.dispatch(hl.dsp.exec_cmd("${lib.getExe paper-change}"))
        hl.dispatch(hl.dsp.exec_cmd(
        "uwsm app -- kitty --class cava cava.sh",
        { workspace = "1 silent", float = true, size = { 888, 462 }, move = { 610, 609 } }
        ))
        hl.dispatch(hl.dsp.exec_cmd(
        "uwsm app -- kitty --class btop btop.sh",
        { workspace = "1 silent", float = true, size = { 590, 637 }, move = { 10, 433 } }
        ))
        hl.dispatch(hl.dsp.exec_cmd(
        "uwsm app -- kitty --class neo neo.sh",
        { workspace = "1 silent", float = true, size = { 402, 1030 }, move = { 1508, 42 } }
        ))
        hl.dispatch(hl.dsp.exec_cmd(
        "uwsm app -- kitty --class fastfetch kitty @ launch --type overlay --env class=fastfetch",
        { workspace = "1 silent", float = true, size = { 590, 383 }, move = { 10, 42 } }
        ))
        hl.dispatch(hl.dsp.exec_cmd(
        "${cmd}",
        { workspace = "1 silent", float = true, size = { 888, 559 }, move = { 610, 42 } }
        ))
        hl.dispatch(hl.dsp.exec_cmd("uwsm app -- localsend_app --hidden"))
        hl.dispatch(hl.dsp.exec_cmd("systemctl restart --user easyeffects"))
        hl.dispatch(hl.dsp.exec_cmd("systemctl restart --user qpwgraph"))
        hl.dispatch(hl.dsp.exec_cmd("systemctl restart --user waybar"))
        hl.dispatch(hl.dsp.exec_cmd("dunstctl set-paused false"))
        hl.dispatch(hl.dsp.exec_cmd("dunstctl close-all"))
        hl.dispatch(hl.dsp.exec_cmd("notify-send \"|-<(Theme Loaded)>-|\""))
      end

      hl.on("hyprland.start", function()
        launches()
      	hl.exec_cmd("uwsm app -- " .. discord)
      	hl.exec_cmd(browser, { workspace = "2 silent" })
      end)

      hl.on("config.reloaded", function()
        launches()
      end)
    '';
}
