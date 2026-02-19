{
  den.aspects.amdgpu = {
    nixos = {
      services.xserver = {
        enable = true;
        videoDrivers = ["amdgpu"];
      };
    };
  };
}
