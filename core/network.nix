

{ config, ... }:

{  
    networking = {
        hostName = "nix"; 
        networkmanager.enable = true;
    };
}