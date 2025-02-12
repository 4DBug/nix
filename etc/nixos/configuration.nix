
{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../home/bug/.config/nixos/main.nix
  ];

  # nix os release version
  system.stateVersion = "24.11";
}
