{ lib, config, inputs, pkgs, options, desktop, ... }:

{
    imports = [
        ../modules/cosmic.nix
        ../modules/graphics.nix
    ]
}