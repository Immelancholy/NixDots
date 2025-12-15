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
      profile = "gpu-hq";
      gpu-api = "vulkan";
      osc = "no";
      hwdec = "auto";
      vo = "gpu-next";
      gpu-context = "waylandvk";
      target-colorspace-hint = true;
    };
    scripts = lib.mkForce [];
  };
}
