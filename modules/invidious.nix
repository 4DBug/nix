
{ config, pkgs, ... }:

{
    services.invidious = {
        enable = true;

        domain = "tube.bug.tools";

        port = 3030;

        database.createLocally = true;

        settings = {
            https_only = true;
            external_port = 443;

            registration_enabled = false;
            login_enabled = true;

            popular_enabled = true;

            default_user_preferences = {
                local = true;
            };
        };
    };
}
