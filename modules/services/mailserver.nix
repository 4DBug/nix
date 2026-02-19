{
  den.aspects.mailserver = {
    nixos = {
      imports = [
        (builtins.fetchTarball {
          url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/master.tar.gz";
          sha256 = "0rm5f749xakmkqrpkl5ay1pydbnlinr50pvwg1vm795js2infmj5";
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
              "apple@bug.tools"
              "roblox@bug.tools"
              "twitch@bug.tools"
              "discord@bug.tools"
              "github@bug.tools"
              "matrix@bug.tools"
            ];
          };

          "pare@bug.tools" = {
            hashedPasswordFile = "/home/bug/mailserver/pare.passwd";
          };
        };
      };
    };
  };
}
