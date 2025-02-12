
{ config, lib, pkgs, ... }:

{
  # portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # gnome autologin workaround
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # unfree packages
  nixpkgs.config.allowUnfree = true;

  # pipewire
  security.rtkit.enable = true;
}