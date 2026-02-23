{ den, ... }:
{
  den.aspects.nix = {
    includes = with den.aspects; [
      den.default
      #amdgpu
      cosmic
      firefox
      audio

      den.provides.home-manager
      stylix
      nvidia
      syncthing
      swap
      #cloudflare-warp
      packages
      development
      #cad
      mpd
      virtualisation
      flatpak
      fish
      dns
      openssh
      beets
    ];

    nixos = {
      networking.hostName = "nix";
    };
  };
}
