{
  den.aspects.virtualisation = {
    nixos = {
      virtualisation = {
        libvirtd.enable = true;

        spiceUSBRedirection.enable = true;
      };
    };
  };
}
