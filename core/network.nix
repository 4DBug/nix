{ ... }:

{
    services.openssh.enable = true;
    
    networking = {
        hostName = "nix";
        useNetworkd = true;
        networkmanager.enable = false;
    };
}
