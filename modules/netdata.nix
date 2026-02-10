{ config, pkgs, ... }:

{
  # open the netdata port
  networking.firewall.allowedTCPPorts = [ 19999 ];

  services.netdata = {
    enable = true;

    # small example config mapped to netdata.conf sections
    config = {
      global = {
        "memory mode" = "ram";  # keep in memory for speed
        "debug log" = "none";
      };

      web = {
        # bind the dashboard to all interfaces (or set to "127.0.0.1:19999" for local-only)
        "bind to" = "0.0.0.0:19999";
      };

      # enable go.d nvidia_smi collector (Netdata reads go.d configs)
      "go.d" = {
        nvidia_smi = {
          enabled = "yes";    # note: Netdata expects string values matching netdata.conf keys
        };
      };
    };
  };
}
