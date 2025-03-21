
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flatpaks.url = "github:gmodena/nix-flatpak/?ref=latest";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, flatpaks, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          flatpaks.nixosModules.nix-flatpak
          ./configuration.nix
        ];
      };
    };
}
