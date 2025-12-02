{ ... }:

{
    systemd.services = {
        #NetworkManager-wait-online.enable = false;
        #systemd-udev-settle.enable = false;
    };
    
    #services.journald.extraConfig = "Storage=volatile";

    boot = {
        #kernel.sysctl = {
        #    "vm.max_map_count" = 16777216;
        #    "fs.file-max" = 524288;
        #};
        
        kernelParams = [ "fsck.mode=skip" "nvidia_drm.fbdev=1" "nvidia-drm.modeset=1" ]; 

        initrd.checkJournalingFS = false;

        loader = {
            #timeout = 0;
            grub.splashImage = null;
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
    };
}
