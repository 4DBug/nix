
{ config, lib, pkgs, ... }:

{
    imports = [
        ./core/core.nix
        ./packages/packages.nix
        ./gnome.nix
        ./theming.nix
    ];

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
}