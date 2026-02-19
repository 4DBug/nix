{
  den.aspects.firefox = {
    nixos = { pkgs, ... }: {
      programs.firefox = {
        enable = true;

        package = pkgs.firefox-bin;
      };
    };
  };
}
