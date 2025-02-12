{ config, lib, pkgs, ... }:

{
  services = {
    # touchpad
    libinput.enable = true;

    # openssh
    openssh.enable = true;

    # printing
    printing.enable = true;

    # sound
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true;
    };

    # auto login
    displayManager.autoLogin = {
      enable = true;
      user = "bug";
    };

    # x11
    xserver = {
      enable = true;

      # enable nvidia drivers
      videoDrivers = ["nvidia"];

      # x11 keymap
      xkb = {
        layout = "us";
        variant = "";
      };

      # gnome de
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };

    # flatpak
    flatpak.enable = true;
  };
}