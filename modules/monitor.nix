{ config, pkgs, device, ... }:

{
    services.netdata = {
        enable = true;

        config = {
            global = {
            "memory mode" = "ram";
            "debug log" = "none";
            "access log" = "none";
            "error log" = "syslog";
            };
        };
    };
}