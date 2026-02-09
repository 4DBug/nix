{ config, pkgs, ... }:

{
    services.searx = {
        enable = true;

        environmentFile = "/home/bug/nix/modules/searxng_key";
        redisCreateLocally = true;

        settings = {
            server = {
                bind_address = "127.0.0.1";
                port = 1025;
            };

            general = {
                instance_name = "search.bug.tools";
            };

            engines = {
                remove = [
                    "ahmia"
                    "torch"
                    "radio_browser"
                    "wikidata"
                ];
            };

            limiter.enable = false;
        };
    };
}