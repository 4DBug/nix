{ config, pkgs, device, ... }:

{
    boot = {
        kernelModules = if (device == "desktop") then ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" "uinput"] else [];
        kernelParams = if (device == "desktop") then ["nvidia-drm.modeset=1" "nvidia_drm.fbdev=1"] else [];

        kernelPackages = pkgs.linuxPackages_zen;

        initrd.checkJournalingFS = false;

        loader = {
            grub.splashImage = null;

            systemd-boot = {
                enable = true;
                configurationLimit = 25;
            };

            efi.canTouchEfiVariables = true;
        };
    };
}