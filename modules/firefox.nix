{ config, pkgs, device, ... }:

{
    programs.firefox = {
        enable = true;
        package = pkgs.librewolf;

        policies = {
            DisableTelemetry = true;
            DisableFirefoxStudies = true;

            Preferences = {
                "cookiebanners.service.mode" = 2;
                "cookiebanners.service.mode.privateBrowsing" = 2;
                "network.cookie.lifetimePolicy" = 0;
                "privacy.clearonShutdown.cookies" = false;
                "privacy.claerOnShutdown.history" = false;
                "privacy.donottrackheader.enabled" = true;
                "privacy.fingerprintingProtection.enabled" = true;
                "privacy.resistFingerprinting" = false;
                "privacy.trackingprotection.enabled" = true;
                "privacy.trackingprotection.socialtracking.enabled" = true;
                "privacy.trackingprotection.fingerprinting.enabled" = true;
                "privacy.trackingprotection.emailtracking.enabled" = true;
                "webgl.disabled" = false;
            };

            ExtensionSettings = {
                # catppuccin no borders https://addons.mozilla.org/en-US/firefox/addon/catppuccin-mocha-no-borders/
                "catppuccin-mocha-no-borders@skyrpex" = {
                    installation_mode = "force_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-mocha-no-borders/latest.xpi";
                };
                
                # DeArrow
                "dearrow@jetpack" = {
                    installation_mode = "force_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/dearrow-jetpack/latest.xpi";
                };

                # Return Youtube Dislike
                "return-youtube-dislike@0.4.11" = {
                    installation_mode = "force_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislike/latest.xpi";
                };

                # SponsorBlock for YouTube
                "sponsorblock@sponsorblock.com" = {
                    installation_mode = "force_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock-for-youtube/latest.xpi";
                };

                # Stylus
                "stylus@stylus" = {
                    installation_mode = "force_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/stylus/latest.xpi";
                };

                # Tampermonkey
                "tampermonkey.net" = {
                    installation_mode = "force_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/tampermonkey/latest.xpi";
                };

                # uBlock Origin
                "ublockorigin@raymondhill.net" = {
                    installation_mode = "force_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                };

                # BTRoblox
                "btroblox@btroblox" = {
                    installation_mode = "force_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/btroblox/latest.xpi";
                };
            };
        };
    };
}