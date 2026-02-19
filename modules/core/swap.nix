{
  den.aspects.swap = {
    nixos = {
      boot.kernel.sysctl = {
        "fs.file-max" = 524288;
      };

      swapDevices = [{
        device = "/var/lib/swapfile";
        size = 8 * 1024;
      }];

      zramSwap = {
        enable = true;
        memoryMax = 64 * 1024 * 1024 * 1024;
      };
    };
  };
}
