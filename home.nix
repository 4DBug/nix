{inputs, config, pkgs, device, ... }:

{
    imports = [
        ./modules/syncthing.nix
    ] ++ (if device == "server" then [

    ] else [
        ./modules/stylix.nix
        #./modules/firefox.nix
    ]);

    home = {
        username = "bug";
        homeDirectory = "/home/bug";

        stateVersion = "25.11";

        packages = with pkgs; [
            
        ] ++ (if device == "server" then [
            gh
            luajit
            nodejs
            node2nix
        ] else []);

        file = {};
        
        sessionVariables = {
            EDITOR = "micro";
            MICRO_TRUECOLOR = 1;
        };
    };

    nixpkgs.config.allowUnfree = true;
    
    programs.home-manager.enable = true;
}