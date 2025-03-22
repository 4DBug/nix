{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        gnomeExtensions.arcmenu
        gnomeExtensions.rounded-window-corners-reborn
        gnomeExtensions.just-perfection
        gnomeExtensions.clipboard-history
    ];

    services = {
        displayManager = {
            autoLogin = {
                enable = true;
                user = "bug";
            };
        };

        xserver = {
            enable = true;

            displayManager.gdm.enable = true;
            desktopManager.gnome.enable = true;

            xkb = {
                layout = "us";
                variant = "";
            };
        };
    };

    systemd = {
        services."getty@tty1".enable = false;
        services."autovt@tty1".enable = false;
    };
}