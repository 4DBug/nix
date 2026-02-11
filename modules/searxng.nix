{ config, lib, pkgs, ... }:

{
  systemd.services.searx-init.serviceConfig.EnvironmentFile = [
    "/home/bug/.searxng.env"
  ];

  services.searx = {
    enable = true;
    redisCreateLocally = false;
    configureUwsgi = false;
    settingsFile = ./searxng.yml;
    environmentFile = "/home/bug/.searxng.env";

    settings = {
      general.instance_name = "search.bug.tools";

      server.port = 8888;
      server.bind_address = "0.0.0.0";
      server.secret_key = "$SEARX_SECRET_KEY";
    };
  };
}