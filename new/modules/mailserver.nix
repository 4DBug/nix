{ config, pkgs, device, ... }:

{
    imports = [
        (builtins.fetchTarball {
            url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/master.tar.gz";

            sha256 = "0xlhl8zhcz5c6hvmpkfw9ay2lfnk6nhax8pphvbv3vzxf1p9dhw9";
        })
    ];
    
    security.acme = {
        acceptTerms = true;
        defaults.email = "security@bug.tools";

        certs."mail.bug.tools" = {
            listenHTTP = "1360";
        };
    };

    mailserver = {
        enable = true;

        stateVersion = 3;

        fqdn = "mail.bug.tools";
        domains = [ "bug.tools" ];

        x509.useACMEHost = "mail.bug.tools";

        loginAccounts = {
            "bug@bug.tools" = {
                hashedPasswordFile = "/home/bug/mailserver/bug.passwd";
                aliases = [
                    "admin@bug.tools"
                    "google@bug.tools"
                ];
            };

            "pare@bug.tools" = {
                hashedPasswordFile = "/home/bug/mailserver/pare.passwd";
            };
        };
    };
}