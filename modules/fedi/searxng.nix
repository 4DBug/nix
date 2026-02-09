{ config, lib, pkgs, ... }:

{
  # remove sops dependency from searxng module
  systemd.services.searx-init.serviceConfig.EnvironmentFile = [ 
    "/home/bug/nix/modules/fedi/searxng_key"
  ];

  services.searx = {
    enable = true;
    redisCreateLocally = false;
    configureUwsgi = false;
    settingsFile = config/searxng.yml;
    environmentFile = "/home/bug/nix/modules/fedi/searxng_key";
    settings = {
      server.port = 8888;
      server.bind_address = "0.0.0.0";
      server.secret_key = "$SEARX_SECRET_KEY";
    };
  };
}
