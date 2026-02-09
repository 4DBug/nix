{ config, pkgs, ... }:

let
    TUNNEL_UUID = "4118935e-359b-4dd2-95bd-eb27f7b0c5bb"; 
in
{
    environment.systemPackages = [ pkgs.cloudflared ];

    services.cloudflared = {
        enable = true;

        tunnels."${TUNNEL_UUID}" = {
            credentialsFile = "/home/bug/.cloudflared/${TUNNEL_UUID}.json";
            default = "http_status:404";

            ingress = {
                #"tv.bug.tools"     = "http://127.0.0.1:8080";
                #"search.bug.tools" = "http://127.0.0.1:3000";
                "files2.bug.tools"  = "http://127.0.0.1:3210";
            };
        };
    };
}
