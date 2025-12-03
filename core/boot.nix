{ ... }:

{
    boot = {
        kernelParams = [ "fsck.mode=skip" "nvidia_drm.fbdev=1" "nvidia-drm.modeset=1" ]; 

        initrd.checkJournalingFS = false;

        loader = {
            grub.splashImage = null;
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
    };
}
