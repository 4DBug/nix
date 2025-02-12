{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "nix";
    networkmanager.enable = true;

    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };
}