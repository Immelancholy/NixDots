{
  pkgs,
  lib,
  ...
}: {
  programs.mpv = {
    package = pkgs.mpv.override {
      extraMakeWrapperArgs = [
        "--prefix"
        "ENABLE_HDR_WSI"
        "="
        "1"
      ];
      scripts = [
        pkgs.mpvScripts.mpris
        pkgs.mpvScripts.modernz
        pkgs.mpvScripts.thumbfast
      ];
    };
    config = {
      osc = "no";
      hwdec = "auto";
      vo = "gpu";
      gpu-context = "wayland";
      target-colorspace-hint-mode = "source";
      target-peak = 300;
    };
    scripts = lib.mkForce [];
  };
}
