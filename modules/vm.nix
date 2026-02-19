# nix run .#vm

{ inputs, den, ... }: {
    den.aspects.nix.includes = [ (den.provides.tty-autologin "bug") ];

    perSystem = { pkgs, ... }: {
        packages.vm = pkgs.writeShellApplication {
            name = "vm";
            text = let
                host = inputs.self.nixosConfigurations.nix.config;
            in ''
                ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
            '';
        };
    };
}
