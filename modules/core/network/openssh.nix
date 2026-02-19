{
  den.aspects.openssh = {
    nixos = {
      services.openssh = {
        enable = true;

        settings = {
          PrintMotd = true;
          X11Forwarding = true;
          AllowTcpForwarding = true;
        };
      };
    };
  };
}
