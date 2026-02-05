{ config, pkgs, ... }:

{
    nixpkgs.overlays = [ copyparty.overlays.default ];

    services.copyparty = {
        enable = true;

        user = "copyparty";

        group = "copyparty";

        settings = {
            i = "0.0.0.0";
            p = [ 3210 3211 ];
            no-reload = true;
            ignored-flag = false;
        };

        accounts = {
            bug = {
                passwordFile = "";
            };
        };

        groups = {
            g1 = [ "bug" ];
        };

        volumes = {
            "/" = {
                path = "/srv/copyparty";

                access = {
                    r = "*";
                    rw = [ "bug" ];
                };

                flags = {
                    fk = 4;
                    scan = 60;
                };
            };
        };

        openFilesLimit = 8192;
    };
}