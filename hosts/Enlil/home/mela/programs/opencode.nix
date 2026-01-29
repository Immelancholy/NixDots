{
  inputs,
  pkgs,
  ...
}: {
  programs.opencode = {
    enable = true;
    package = inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default;

    settings = {
      model = "chutes/moonshotai/Kimi-K2.5-TEE";

      plugin = [
        "@simonwjackson/opencode-direnv"
        "opencode-lmstudio@latest"
      ];
      
      provider = {
        lmstudio = {
          npm = "@ai-sdk/openai-compatible";
          name = "LM Studio (local)";
          options = {
            baseUrl = "http://192.168.1.162:1234/v1";
          };
        };
      };
      
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
