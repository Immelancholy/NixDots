{
  age = {
    secretsDir = "/run/user/1000/agenix";

    identityPaths = [
      "/home/mela/.ssh/id_ed25519_age"
    ];

    secrets = {
      context7-zed.file = ../../secrets/context7-zed.age;
    };
  };
}
