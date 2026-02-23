{
  den.aspects.gitea = {
    nixos = {
      services.gitea = {
        enable = true;
        config = {
          database = {
            type = "sqlite3";
            path = "/var/lib/gitea/gitea.db";
          };

          server = {
            domain = "example.com";
            httpPort = 3000;
          };
        };
      };
    };
  };
}
