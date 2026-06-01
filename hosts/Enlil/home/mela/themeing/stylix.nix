{ lib, ... }:
{
  stylix = {
    targets = {
      blender.enable = true;
    };
    # targets.zen-browser.opacity.override.applications = lib.mkForce 0.1;
  };
}
