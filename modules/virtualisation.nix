{ config, pkgs, device, ... }:

{  
    virtualisation = {
        libvirtd.enable = true;

        spiceUSBRedirection.enable = true;
    };
}