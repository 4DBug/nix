{
  den.aspects.nvidia = {
    nixos = { pkgs, config, ... }: {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;

        extraPackages = with pkgs; [
          libva-vdpau-driver
          libvdpau
          libvdpau-va-gl
          vdpauinfo
          libva
          libva-utils
          libglvnd
          mesa
          nvidia-vaapi-driver
        ];
      };

      services.xserver = {
        enable = true;
        videoDrivers = ["nvidia"];
      };

      hardware.nvidia = {
        modesetting.enable = true;

        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = false;

        nvidiaSettings = true;

        package = config.boot.kernelPackages.nvidiaPackages.beta;
      };

      nixpkgs.config = {
        cudaSupport = true;
        nvidia.acceptLicense = true;
      };
    };
  };
}
