{
    inputs = {
        # nixpkgs.follows = "nixos-cosmic/nixpkgs";
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        flatpaks.url = "github:gmodena/nix-flatpak/?ref=latest";

        nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
        
        hytale-launcher.url = "github:JPyke3/hytale-launcher-nix";

        stylix = {
            url = "github:nix-community/stylix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, stylix, home-manager, flatpaks, hytale-launcher, ... }:
    let
    	deviceType = import /etc/nixos/device.nix;
        system = "x86_64-linux";
    in
    {
        nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
            inherit system;

            specialArgs = { inherit inputs; inherit (deviceType) desktop; };

            modules = [
                {
                    nix.settings = {
                        substituters = [ "https://cosmic.cachix.org/" ];
                        trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                    };
                }

                flatpaks.nixosModules.nix-flatpak
                
                stylix.nixosModules.stylix
                
                ./configuration.nix
            ];
        };
    };
}
