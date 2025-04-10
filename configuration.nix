{
  userAccounts.users = [];
  userAccounts.sudoUsers = ["mela"];

  environment.sessionVariables = {
    FLAKE_PATH = "home/mela/NixDots"; #path to flake.nix
  };

  drivers = {
    amd.enable = false;
    nvidia.enable = true;
  };

  displayManager = {
    sddm.enable = true;
    tuiGreet.enable = false;
  };

  locale = "en_GB.UTF-8";

  services.xserver.xkb = {
    layout = "gb";
    model = "";
    variant = "";
    options = "";
  };
  console = {
    earlySetup = true;
    keyMap = "uk";
  };
  time.timeZone = "Europe/London";
  boot.secureBoot.enable = false;
}
