{
    inputs = {
        # nixpkgs.follows = "nixos-cosmic/nixpkgs";
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        flatpaks.url = "github:gmodena/nix-flatpak/?ref=latest";

        nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
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

                flatpaks.nixosModules.nix-flatpak
                
                ./configuration.nix
            ];
        };
    };
}
