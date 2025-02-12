
{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./environment.nix
    ./hardware.nix
    ./locale.nix
    ./misc.nix
    ./networking.nix
    ./programs.nix
    ./services.nix
    ./users.nix
  ];
}
