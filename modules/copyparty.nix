{ config, pkgs, inputs, ... }:

{
    nixpkgs.overlays = [ inputs.copyparty.overlays.default ];

    services.copyparty = {
        enable = true;

        user = "bug";

        group = "copyparty";

        settings = {
            i = "0.0.0.0";
            p = [ 3210 3211 ];
            no-reload = true;
            ignored-flag = false;
        };

        accounts = {
            bug = {
                passwordFile = "/home/bug/mailserver/bug.passwd";
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