{ config, pkgs, ... }:

{
    services.searx = {
        enable = true;
        redisCreateLocally = true;

        settings.server = {
            bind_address = "::1";
            
            port = 8080;
        };
    };
}