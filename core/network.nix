{ ... }:

{
    services.openssh.enable = true;
    
    networking.firewall.enable = true;
    
    networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

    services.dnscrypt-proxy2 = {
        enable = true;
        
        settings = {
            ipv6_servers = true;
            require_dnssec = true;
            
            sources.public-resolvers = {
                urls = [
                    "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
                    "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
                ];
                
                cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
                minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
            };
        };
    };
    
    networking = {
        hostName = "nix";
        useNetworkd = true;
        networkmanager.enable = false;
    };
}
