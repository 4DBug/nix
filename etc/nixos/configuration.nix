{ config, lib, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        /home/bug/nix/main.nix
    ];

    # nix os release version
    system.stateVersion = "24.11";
}