{ config, pkgs, ... }:

let
    TUNNEL_UUID = "4118935e-359b-4dd2-95bd-eb27f7b0c5bb"; 
in
{
    environment.systemPackages = [ pkgs.cloudflared ];

    environment.etc."cloudflared/${TUNNEL_UUID}.json".source = "/home/bug/.cloudflared/${TUNNEL_UUID}.json";

    services.cloudflared = {
        enable = true;

        tunnels."${TUNNEL_UUID}" = {
            credentialsFile = "/etc/cloudflared/${TUNNEL_UUID}.json";
            default = "http_status:404";

            ingress = {
                "tvtun.bug.tools" = "http://127.0.0.1:3001";
                "search.bug.tools" = "http://127.0.0.1:8888";
                "files.bug.tools" = "http://127.0.0.1:3210";
                "tube.bug.tools" = "http://127.0.0.1:3030";
                "monitor.bug.tools" = "http://127.0.0.1:61208";
                "reddit.bug.tools" = "http://127.0.0.1:8975";
            };
        };
    };
}
