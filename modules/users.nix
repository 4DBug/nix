{ config, pkgs, device, ... }:

{
    users.users = {
        bug = {
            isNormalUser = true;
            description = "bug";
            extraGroups = [ "networkmanager" "wheel" "audio" "video" "libvirtd" "ydotool" "dialout" ];
        };
    } // (if (device == "server") then {
        levi = {
            isNormalUser = true;
            description = "levi";
            extraGroups = [ "wheel"];

            hashedPasswordFile = "/home/bug/users/levi.passwd";
        };
    } else {});
}