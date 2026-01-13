{nix-relic, ...}: {
  wayland.windowManager.hyprland = {
    # ONLY ENABLE 1 LAYOUT!!
    layout = {
      master.enable = false;
      dwindle.enable = false;
      hy3.enable = true;
    };
    settings = {
      cursor = {
        no_hardware_cursors = false;
      };
      monitor = "eDP-1, 1920x1080@60, 0x0, 1";
      input = {
        kb_layout = "gb";
        follow_mouse = "1";

        sensitivity = "0";
        force_no_accel = "1";
        numlock_by_default = "true";
      };
    };
  };
}
