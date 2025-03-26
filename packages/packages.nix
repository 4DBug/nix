{ lib, ... }:

{
    imports = [
        ./user.nix
        ./system.nix
        ./flatpak.nix
    ];

    nixpkgs.config.allowUnfree = true;

    services.flatpak = {
        enable = true;

        remotes = lib.mkOptionDefault [{
            name = "flathub-beta";
            location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
        }];

        update.auto.enable = true;
        uninstallUnmanaged = false;
    };

    programs = {
        bash.shellAliases = {
            fetch = "fastfetch --file ~/Pictures/Ansi/nix.ans";
            neofetch = "fetch";

            rebuild = "sudo nixos-rebuild switch --impure && home-manager switch --impure";

            pissh = "ssh -t $(avahi-resolve-host-name -4 pi.home | awk '{print $2}')";
            pi = "pissh \"cd $(pwd) && bash\"";

            pico = "ssh pico.sh";

            # tuns name port
            tuns = "bash -c '\''if [ \"$#\" -ne 2 ]; then echo \"Usage: tun name port\"; exit 1; fi;
if [[ \"$1\" =~ ^[0-9]+$ ]]; then port=\"$1\"; name=\"$2\";
elif [[ \"$2\" =~ ^[0-9]+$ ]]; then port=\"$2\"; name=\"$1\";
else echo \"Error: One argument must be a number (port)\"; exit 1; fi;
ssh -R \"$\{name}:80:localhost:$\{port}\" tuns.sh'\'' _";

            # pgs name directory
            pgs = "bash -c '\''if [ \"$#\" -ne 2 ]; then echo \"Usage: pgs NAME DIRECTORY\"; exit 1; fi; rsync -rv \"$2\" pgs.sh:/\"$1\"'\'' _";
        };

        dconf.enable = lib.mkDefault true;

        firefox.enable = true;

        steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
        };
    };

    services = {
        printing.enable = true;

        ollama = {
            enable = true;
            acceleration = "cuda";
        };

        syncthing = {
            enable = true;
            user = "bug";
            group = "wheel";
            dataDir = "/home/bug/";
        };
    };
}
