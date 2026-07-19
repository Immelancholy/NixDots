{ self }:
{
  additions = final: prev: import ../pkgs { inherit self; } final.pkgs;
  modifications = final: prev: {
    ani-cli = prev.ani-cli.overrideAttrs (oa: {
      src = "${self.inputs.ani-cli}";
      runtimeInputs = with prev.pkgs; [ ] ++ oa.runtimeInputs;
    });
    # pnpm_10_29_2 = final.pnpm_10;
  };
}
