{inputs, config, pkgs, device, ... }:

{
    home = {
        username = "bug";
        homeDirectory = "/home/bug";
        stateVersion = "25.11";
        packages = [];
        file = {};
        sessionVariables = {
            EDITOR = "micro";
            MICRO_TRUECOLOR = 1;
        };
    };

    nixpkgs.config.allowUnfree = true;
    
    programs.home-manager.enable = true;

    services.syncthing = {
        enable = true;

        overrideDevices = true;
        overrideFolders = true;

        key = "/home/bug/.syncthing/key.pem";
        cert = "/home/bug/.syncthing/cert.pem";

        settings = {
            devices = {
                desktop.id = "VEZXY3W-U6UXWTP-6BHANIG-O5EKNZY-XNV5YOX-4V4O3HB-ETECIUX-T2DK7AV";
                laptop.id = "I6NW53P-IJMMT73-7O53TXY-3GAHS2U-4EAADM7-ZNB5ZPB-62QHKVW-H7DYXQ2";
                server.id = "KJECAIP-Y2Y3FHV-NOJKIQV-LWIDMMZ-5ITEAZ4-LQCQL72-3BGW6T7-BFPFJQA";
            };

            folders = {
                "Documents" = {
                    path = "/home/bug/Documents";
                    devices = ["desktop" "laptop"];
                };

                "Downloads" = {
                    path = "/home/bug/Downloads";
                    devices = ["desktop" "laptop"];
                };

                "Pictures" = {
                    path = "/home/bug/Pictures";
                    devices = ["desktop" "laptop"];
                };

                "Videos" = {
                    path = "/home/bug/Videos";
                    devices = ["desktop" "laptop"];
                };

                "nix" = {
                    path = "/home/bug/nix";
                    devices = ["desktop" "laptop" "server"];

                    ignorePatterns = [
                        "device.nix"
                        "hardware-configuration.nix"
                    ];
                };

                "home-manager" = {
                    path = "/home/bug/.config/home-manager";
                    devices = ["desktop" "laptop"];
                };

                "hytale" = {
                    path = "/home/bug/.local/share/Hytale/UserData/Saves";
                    devices = ["desktop" "laptop"];
                };

                "ssh" = {
                    path = "/home/bug/.ssh";
                    devices = ["desktop" "laptop"];
                };
            };
        };
    };

    stylix = {
        enable = (device != "server");
        autoEnable = true;
        polarity = "dark";

        # catppuccin mocha
        base16Scheme = {
            base00 = "1E1E2E";
            base01 = "181825";
            base02 = "313244";
            base03 = "45475A";
            base04 = "585B70";
            base05 = "CDD6F4";
            base06 = "F5E0DC";
            base07 = "B4BEFE";
            base08 = "F38BA8";
            base09 = "FAB387";
            base0A = "F9E2AF";
            base0B = "A6E3A1";
            base0C = "94E2D5";
            base0D = "89B4FA";
            base0E = "CBA6F7";
            base0F = "F2CDCD";
        };

        fonts.emoji = {
            name = "Twitter Color Emoji";
            package = pkgs.twitter-color-emoji;
        };

        targets = {
            vesktop.enable = true;
            gnome.enable = true;
            gtk.enable = true;
            firefox.enable = true;
        };
    };
}