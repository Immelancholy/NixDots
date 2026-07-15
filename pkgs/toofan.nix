{ buildGoModule, self }:
buildGoModule {
  pname = "toofan";
  version = "git";
  src = self.inputs.toofan;
  vendorHash = "sha256-YSjJ8NOL97hXZLnfGYIjoKmARv+gWOsv+5qkl9konnA=";
}
