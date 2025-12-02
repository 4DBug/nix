{ pkgs, ... }:

{
    environment.systemPackages = with pkgs.gnomeExtensions; [
        #arcmenu
        #rounded-window-corners-reborn
        #just-perfection
        #clipboard-history
        #pano
    ];

    services = {
        displayManager = {
            cosmic-greeter.enable = true;

            autoLogin = {
                enable = true;
                user = "bug";
            };
        };

        desktopManager.cosmic.enable = true;

        #desktopManager.plasma6.enable = true;

        displayManager.sddm.enable = true;

        displayManager.sddm.wayland.enable = true;
        
        #displayManager.gdm.enable = true;
        #desktopManager.gnome.enable = true;

        xserver = {
            enable = true;

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




