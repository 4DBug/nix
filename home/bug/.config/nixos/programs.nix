{ config, lib, pkgs, ... }:

{
  programs = {
    # firefox
    firefox.enable = true;

    # steam
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    # hyprland
    hyprland = {
      enable = true;
      # nvidiaPatches = true;
      xwayland.enable = true;
    };
  };
}