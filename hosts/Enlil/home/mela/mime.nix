{lib, ...}: let
    associations = {
    "text/html" = ["helium.desktop"];
    "x-scheme-handler/http" = ["helium.desktop"];
    "x-scheme-handler/https" = ["helium.desktop"];
    "x-scheme-handler/chrome" = ["helium.desktop"];
    "x-scheme-handler/about" = ["helium.desktop"];
    "x-scheme-handler/unknown" = ["helium.desktop"];
    "default-web-browser" = ["helium.desktop"];
    "application/xhtml+xml" = ["helium.desktop"];
    "application/xhtml_xml" = ["helium.desktop"];
    "application/x-extension-htm" = ["helium.desktop"];
    "application/x-extension-html" = ["helium.desktop"];
    "application/x-extension-shtml" = ["helium.desktop"];
    "application/x-extension-xhtml" = ["helium.desktop"];
    "application/x-extension-xht" = ["helium.desktop"];
  };
  in {
  programs.zen-browser.defaultBrowser.enable = lib.mkForce false;
  xdg.mimeApps = {
    associations.added = associations;
    defaultApplications = associations;
  };
}
