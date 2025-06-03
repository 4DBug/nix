{ ... }:

{
    system = {
        stateVersion = "25.05";

        autoUpgrade = {
            enable = true;
            allowReboot = true;
        };
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
