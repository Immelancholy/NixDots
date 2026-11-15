{ pkgs, ... }:
{
  xdg.configFile."hypr/userconf.lua".text = /* Lua */ ''
    hl.on("hyprland.start", function()
      hl.exec_cmd("hyprctl setcursor " .. Cursor)
      hl.exec_cmd("hyprlock")
    end)

    hl.on("config.reloaded", function()
      hl.exec_cmd("hyprctl setcursor " .. Cursor)
      hl.exec_cmd("hyprlock")
    end)

    function WorkspaceOneExecs()
      hl.dispatch(hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-cava relic-cava"))
      hl.dispatch(hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-btop relic-btop"))
      hl.dispatch(hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-neo relic-neo"))
      hl.dispatch(
        hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-fastfetch kitty @ launch --type overlay --env class=fastfetch")
      )
      hl.dispatch(hl.dsp.exec_cmd(Player))
    end

    function ExtraGameCalls()
      hl.dispatch(hl.dsp.workspace.move({ workspace = "name:Start", monitor = "HDMI-A-1" }))
    end
    function ExtraGameExitCalls()
      hl.dispatch(hl.dsp.workspace.move({ workspace = "name:Start", monitor = "DP-1" }))
    end

    function WorkspaceOneKills()
      hl.dispatch(hl.dsp.window.kill({ window = "title:^(" .. PlayerTitle .. ")$" }))
      hl.dispatch(hl.dsp.window.kill({ window = "title:^(relic-neo)$" }))
      hl.dispatch(hl.dsp.window.kill({ window = "title:^(relic-fastfetch)$" }))
      hl.dispatch(hl.dsp.window.kill({ window = "title:^(relic-btop)$" }))
      hl.dispatch(hl.dsp.window.kill({ window = "title:^(relic-cava)$" }))
    end

    function Universal_User_Binds()
      hl.bind(Moda .. " + R", hl.dsp.workspace.toggle_special("DAW"))
      hl.bind(Mods .. " + R", hl.dsp.window.move({ workspace = "special:DAW" }))
      hl.bind(Moda .. " + A", hl.dsp.focus({ workspace = "name:Art" }))
      hl.bind(Mods .. " + A", hl.dsp.window.move({ workspace = "name:Art" }))
      -- hl.bind(Mod .. " + F9", hl.dsp.pass({ window = "class:^(com.obsproject.Studio)$" }))
      -- hl.bind(Mod .. " + F10", hl.dsp.pass({ window = "class:^(com.obsproject.Studio)$" }))
      -- hl.bind(Mod .. " + F12", hl.dsp.pass({ window = "class:^(com.obsproject.Studio)$" }))
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
        title = "^(REAPER v.* - .+)$",
      },
      fullscreen = true,
    })
    hl.window_rule({
      match = {
        class = "^(org.kde.krita)$",
      },
      workspace = "name:Art",
    })
    hl.window_rule({
      match = {
        title = "^(Krita)$",
      },
      fullscreen = true,
    })
    hl.window_rule({
      name = "tsui-top-bar",
      match = { title = "^(tsui-top-bar)$" },
      float = true,
      pin = true,
      size = "715 565",
      move = { "(monitor_w - window_w) * 0.925", 50 },
    })

    hl.workspace_rule({
      workspace = "1",
      monitor = "DP-1",
    })
    hl.workspace_rule({
      workspace = "name:Start",
      monitor = "DP-1",
      persistent = true,
      default = true,
    })
    hl.workspace_rule({
      workspace = "name:Game",
      monitor = "DP-1",
      persistent = true,
    })
    hl.workspace_rule({
      workspace = "name:QpwGraph",
      monitor = "DP-1",
      persistent = true,
    })
    hl.workspace_rule({
      workspace = "name:Art",
      monitor = "HDMI-A-1",
      persistent = true,
    })
    hl.workspace_rule({
      workspace = "name:Discord",
      monitor = "HDMI-A-1",
      default = true,
      persistent = true,
    })
  '';
  home.packages = [
    pkgs.bibata-hyprcursor
  ];
}
