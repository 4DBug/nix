{ config, pkgs, device, ... }:

{
    security = {
        polkit.enable = true;

        sudo = {
            enable = true;
            wheelNeedsPassword = false;
        };
    };
}