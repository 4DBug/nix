{ config, pkgs, ... }:

{
    imports = [ 
        ../modules/vscode-server.nix
        ../modules/mailserver.nix
    ];

    environment.systemPackages = with pkgs; [
        nh
        comma
        nix-index

        home-manager

        micro
        wget
        git

        fastfetch
    ];
}