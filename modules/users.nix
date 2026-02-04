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

            hashedPassword = "$6$AqsDy7oxFOpjKZLM$kD0y3sc1b9xPTveqThhv2EyyhDh0WELrznYwCOQmZzVqEVWs6iG8PmLMstWSfpdloljciEW09u8vTRi1h0EBw1";
        };
    } else {});
}