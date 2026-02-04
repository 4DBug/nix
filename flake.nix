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

        vscode-server.url = "github:nix-community/nixos-vscode-server";

        home-manager.url = "github:nix-community/home-manager";
    };

    outputs = inputs@{ self, nixpkgs, stylix, home-manager, flatpaks, hytale-launcher, vscode-server, ... }:
    let
    	deviceType = import ./device.nix;
        system = "x86_64-linux";
    in
    {
        nixosConfigurations = {
            nix = nixpkgs.lib.nixosSystem {
                inherit system;

                specialArgs = { inherit inputs; inherit (deviceType) device; };

                modules = [
                    {
                        nix.settings = {
                            substituters = [ "https://cosmic.cachix.org/" ];
                            trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                        };
                    }

                    flatpaks.nixosModules.nix-flatpak

                    ./main.nix
                ];
            };

            box = nixpkgs.lib.nixosSystem {
                inherit system;

                specialArgs = { inherit inputs; inherit (deviceType) device; };

                modules = [
                	./main.nix

                	vscode-server.nixosModules.default
                ];
            };
        };

        homeConfigurations = {
            bug = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.x86_64-linux;

                extraSpecialArgs = {
                    inherit inputs;
                    inherit (deviceType) device;
                };
                
                modules = [
                    stylix.homeModules.stylix
                    
                    ./home.nix
                ];
            };
        };
    };
}
