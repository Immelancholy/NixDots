{
  programs.ssh = {
    enable = true;
    package = null;
    enableDefaultConfig = false;
    matchBlocks = {
      "enlil" = {
        host = "enlil";
        forwardAgent = true;
      };
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };
  };
}
