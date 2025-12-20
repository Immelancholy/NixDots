let
  mela = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGu/xySf0raYgnIp6aNTl6U6ExPZsNTQmKb4LdFo2fID";
  users = [mela];
in {
  "context7-zed.age".publicKeys = mela;
}
