let
  associations = {
    "x-scheme-handler/mailto" = ["userapp-Thunderbird-STADF3.desktop"];
    "message/rfc822" = ["userapp-Thunderbird-STADF3.desktop"];
    "x-scheme-handler/mid" = [""];
  };
in {
  xdg.mimeApps = {
    associations.added = associations;
    defaultApplications = associations;
  };
}
