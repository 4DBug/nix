{ ... }:

{
    networking = {
        hostName = "nix";
        useNetworkd = true;
        networkmanager.enable = false;
    };
}
