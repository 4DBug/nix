{ config, pkgs, ... }:

{
    services.searx = {
        enable = true;
        redisCreateLocally = true;

        settings.server = {
            bind_address = "127.0.0.1";
            
            port = 1025;
        };

        environmentFile = "/home/bug/nix/modules/searxng_key";
    };
}