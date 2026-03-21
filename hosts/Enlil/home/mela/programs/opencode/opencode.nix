{
  inputs,
  pkgs,
  ...
}: {
  programs.opencode = {
    enable = false;
    package = inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default;

    agents = {
      tutor = ./agents/tutor.md;
    };

    settings = {
      default_agent = "tutor";
      agent = {
        general = {
          model = "zai-coding-plan/glm-4.7";
        };
        explore = {
          model = "zai-coding-plan/glm-4.7";
        };
      };
      model = "chutes/zai-org/GLM-5-TEE";

      plugin = [
        "@simonwjackson/opencode-direnv"
      ];
      
      mcp = {
        context7 = {
          enabled = true;
          type = "local";
          command = [
            "npx"
            "-y"
            "@upstash/context7-mcp"
          ];
        };
      };
    };
  };
}
