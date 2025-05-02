{ ... }:

{
    systemd.services = {
        NetworkManager-wait-online.enable = false;
        systemd-udev-settle.enable = false;
    };
    
    services.journald.extraConfig = "Storage=volatile";

    boot = {
        kernelModules = [ "ext4" "ahci" "nvme" ];
        kernelParams = [ "elevator=deadline" "quiet" ];

        loader = {
            timeout = 0;
            grub.splashImage = null;
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
    };
}
