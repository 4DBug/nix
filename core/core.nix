
{ config, ... }:

{
    imports = [
        ./user.nix
        ./audio.nix
        ./graphics.nix
        ./locale.nix
        ./network.nix
        ./boot.nix
        ./security.nix
    ];
}