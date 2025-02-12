{ config, lib, pkgs, ... }:

{
  services = {
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

    # x11
    xserver = {
      enable = true;

      # enable nvidia drivers
      videoDrivers = ["nvidia"];

      # touchpad
      libinput.enable = true;

      # x11 keymap
      xkb = {
        layout = "us";
        variant = "";
      };

      displayManager = {
        # gnome de
        gdm.enable = true;
        gnome.enable = true;

        # auto login
        autoLogin = {
          enable = true;
          user = "bug";
        }
      };
    };

    # flatpak
    flatpak.enable = true;
  };
}