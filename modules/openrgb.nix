{ config, pkgs, ... }:

{
    services.hardware.openrgb = {
        enable = true;

        motherboard = "intel"; # i9-14900K
    };

    users.users.bug.extraGroups = [ "i2c" ];

    hardware.i2c.enable = true;

    boot.kernelModules = [
        "i2c-dev" # I2C device access for motherboard RGB
        "i2c-i801" # Intel I2C controller (Z790 chipset)
        "snd-aloop" # Audio loopback for monitoring
    ];
}