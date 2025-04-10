{
  programs.git = {
    enable = true;
    userName = "Immelancholy";
    userEmail = "lenalowes0@gmail.com";
  };
  wayland.windowManager.hyprland = {
    # ONLY ENABLE 1 LAYOUT!!
    layout = {
      master.enable = false;
      dwindle.enable = false;
      hy3.enable = true;
    };
    useHyprspace = true;
    settings = {
      monitor = "HDMI-A-1, 1920x1080@144, 0x0, 1, bitdepth, 8";
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
