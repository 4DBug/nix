{inputs, config, pkgs, device, ... }:

{
    imports = [
        ./modules/syncthing.nix
    ] ++ (if device == "server" then [

    ] else [
        ./modules/stylix.nix
    ]);

    home = {
        username = "bug";
        homeDirectory = "/home/bug";

        stateVersion = "25.11";

        packages = with pkgs; [
            gh
            luajit
        ];

        file = {};
        
        sessionVariables = {
            EDITOR = "micro";
            MICRO_TRUECOLOR = 1;
        };
    };

    nixpkgs.config.allowUnfree = true;
    
    programs.home-manager.enable = true;
}