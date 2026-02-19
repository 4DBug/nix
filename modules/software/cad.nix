{
  den.aspects.cad = {
    nixos = { pkgs, ... }: {
      users.users.bug.packages = with pkgs; [
        blender
        plasticity
        orca-slicer
      ];
    };
  };
}
