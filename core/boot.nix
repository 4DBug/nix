{ ... }:

{
    systemd.services = {
        #NetworkManager-wait-online.enable = false;
        #systemd-udev-settle.enable = false;
    };
    
    #services.journald.extraConfig = "Storage=volatile";

    boot = {
        kernelParams = [ "fsck.mode=skip" ]; 

        initrd.checkJournalingFS = false;

        loader = {
            #timeout = 0;
            grub.splashImage = null;
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
    };
}
