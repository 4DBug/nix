{ pkgs, ... }:

{
    environment.systemPackages = with pkgs.gnomeExtensions; [
        arcmenu
        rounded-window-corners-reborn
        just-perfection
        clipboard-history
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

        targets = {
            sleep.enable = false;
            suspend.enable = false;
            hibernate.enable = false;
            hybrid-sleep.enable = false;
        };
    };
}
