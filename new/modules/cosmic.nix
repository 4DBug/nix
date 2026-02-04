{ config, pkgs, device, ... }:

{
    services = {
        greetd.enable = true;

        system76-scheduler.enable = true;

        displayManager = {
            cosmic-greeter.enable = true;

            autoLogin = {
                enable = (device == "desktop");
                user = "bug";
            };
        };

        desktopManager.cosmic.enable = true;
    };

    environment.sessionVariables = {
        COSMIC_DATA_CONTROL_ENABLED = 1;
    };

    xdg = {
        portal = {
            enable = true;
            xdgOpenUsePortal = true;

            config.common.default = ["gtk"];

            extraPortals = [pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-cosmic];
        };

        mime = {
            enable = true;

            defaultApplications = {
                "text/html" = "firefox.desktop";
                "x-scheme-handler/http" = "firefox.desktop";
                "x-scheme-handler/https" = "firefox.desktop";
                "x-scheme-handler/about" = "firefox.desktop";
                "x-scheme-handler/unknown" = "firefox.desktop";
                "application/pdf" = "firefox.desktop";

                "inode/directory" = "com.system76.CosmicFiles.desktop";

                "text/plain" = "com.system76.CosmicEdit.desktop";
                "text/markdown" = "com.system76.CosmicEdit.desktop";

                "application/zip"                   = "org.gnome.FileRoller.desktop";
                "application/x-7z-compressed"       = "org.gnome.FileRoller.desktop";
                "application/x-tar"                 = "org.gnome.FileRoller.desktop";
                "application/gzip"                  = "org.gnome.FileRoller.desktop";
                "application/x-xz"                  = "org.gnome.FileRoller.desktop";
                "application/x-zip-compressed"      = "org.gnome.FileRoller.desktop";

                "application/x-ms-dos-executable"   = "wine.desktop";
            };
        };
    };
}