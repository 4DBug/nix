{ config, pkgs, device, ... }:

{
    boot = {
        kernelModules = if (device == "desktop") then ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" "uinput"] else [];
        kernelParams = if (device == "desktop") then ["nvidia-drm.modeset=1" "nvidia_drm.fbdev=1"] else [];

        kernelPackages = pkgs.linuxPackages_zen;

        kernel.sysctl = {
            "fs.file-max" = 524288;
        };
        
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
            
    swapDevices = [{
        device = "/var/lib/swapfile";
        size = 8 * 1024;
    }];
    
    zramSwap = {
        enable = true;
        memoryMax = 64 * 1024 * 1024 * 1024;
    };
}