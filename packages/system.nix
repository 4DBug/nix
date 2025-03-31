{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        home-manager

        git
        wget

        # compiling
        gcc
        gnumake

        # network
        nmap
        inetutils
        sshs

        # input testing
        evtest

        # nix language server
        nixd
        nil
    ];
}
