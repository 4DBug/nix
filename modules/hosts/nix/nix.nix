{ den, ... }:
{
  den.aspects.nix = {
    includes = with den.aspects; [
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
    ];

    nixos = {
      networking.hostName = "nix";
    };
  };
}
