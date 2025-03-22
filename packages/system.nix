
{ config, lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        home-manager
        git
        wget
        gcc
        nmap
        inetutils
        sshs
        gnumake
        evtest
    ];
}