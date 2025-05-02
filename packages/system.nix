{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        home-manager
        comma
        nix-index

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
