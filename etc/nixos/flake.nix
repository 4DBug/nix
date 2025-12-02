
{
    inputs = {
        nixpkgs.follows = "nixos-cosmic/nixpkgs";
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

        flatpaks.url = "github:gmodena/nix-flatpak/?ref=latest";

        nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

        nix-citizen.url = "github:LovingMelody/nix-citizen";
        
        nix-gaming.url = "github:fufexan/nix-gaming";
        nix-citizen.inputs.nix-gaming.follows = "nix-gaming";
    };

    outputs = inputs@{ self, nixpkgs, home-manager, flatpaks, ... }:
    let
        system = "x86_64-linux";
    in
    {
        nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
            inherit system;

            specialArgs = { inherit inputs; };

            modules = [
                {
                    nix.settings = {
                        substituters = [ "https://cosmic.cachix.org/" ];
                        trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                    };
                }

                #nixos-cosmic.nixosModules.default

                flatpaks.nixosModules.nix-flatpak
                
                nix-citizen.nixosModules.default

                ./configuration.nix
            ];
        };
    };
}
