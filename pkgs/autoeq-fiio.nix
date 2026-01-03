{
  writers,
  python3Packages,
  fetchFromGitHub,
}: let
  script = fetchFromGitHub {
    owner = "yoeljacobsen";
    repo = "AutoEQ-to-FIIO";
    rev = "1b05e1b89f43f01acf3231773aaadf4367e33e8d";
    hash = "sha256-wUrYFfgkQItRZCdNsnbkbefZhXMFJNeRHMSM9KBiXQk=";
  };
in
  writers.writePython3Bin "autoeq-fiio" {
    doCheck = false;
    libraries = with python3Packages; [
      requests
    ];
  }
  (builtins.readFile "${script}/autoeq_to_fiio.py")
