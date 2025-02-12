{ config, lib, pkgs, ... }:

{
  hardware = {
    # open gl
    opengl.enable = true;
    graphics.enable = true;

    # nvidia drivers
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    # pipewire
    pulseaudio.enable = false;
  };
}