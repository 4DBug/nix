{ config, pkgs, device, ... }:

{
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
                    devices = ["desktop" "laptop" "server"];
                };

                "Downloads" = {
                    path = "/home/bug/Downloads";
                    devices = ["desktop" "laptop" "server"];
                };

                "Pictures" = {
                    path = "/home/bug/Pictures";
                    devices = ["desktop" "laptop" "server"];
                };

                "Videos" = {
                    path = "/home/bug/Videos";
                    devices = ["desktop" "laptop" "server"];
                };

                "nix" = {
                    path = "/home/bug/nix";
                    devices = ["desktop" "laptop" "server"];

                    ignorePatterns = [
                        "device.nix"
                        "hardware-configuration.nix"
                    ];
                };

                "hytale" = {
                    path = "/home/bug/.local/share/Hytale/UserData/Saves";
                    devices = ["desktop" "laptop"];
                };

                "ssh" = {
                    path = "/home/bug/.ssh";
                    devices = ["desktop" "laptop" "server"];
                };

                "cloudflared" = {
                    path = "/home/bug/.cloudflared";
                    devices = ["desktop" "laptop" "server"];
                };

                "Music" = {
                    path = (if (device == "desktop") then "/home/bug/Music" else "/run/media/bug/Music/");
                    devices = ["desktop" "laptop"];
                };
            };
        };
    };
}