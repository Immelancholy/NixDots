{
  pkgs,
  inputs,
  ...
}: let
  associations = {
    "text/plain" = ["nvim.desktop"];
    "text/css" = ["nvim.desktop"];
    "text/csv" = ["nvim.desktop"];
    "text/javascript" = ["nvim.desktop"];
    "application/json" = ["nvim.desktop"];
    "application/xml" = ["nvim.desktop"];
    "application/x-shellscript" = ["nvim.desktop"];
  };
in {
  xdg.mimeApps = {
    associations.added = associations;
    defaultApplications = associations;
  };
  home.packages = [
    inputs.RheaynaVim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
