{ ... }:

{
    users.users.bug = {
        isNormalUser = true;
        description = "Bug";
        extraGroups = [ "networkmanager" "wheel" ];
    };
}
