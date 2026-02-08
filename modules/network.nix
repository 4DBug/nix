{ config, pkgs, device, ... }:

{
    networking = {
        hostName = if (device == "server") then "box" else "nix";

        networkmanager.enable = true;

        nameservers = [ "1.1.1.1" "1.0.0.1" ];
    };

    services = {
        cloudflare-warp.enable = (device == "laptop");
        
        openssh = {
            enable = true;

            settings = {
                PrintMotd = true;
                X11Forwarding = true;
                AllowTcpForwarding = true;
            };
        };
    };
}