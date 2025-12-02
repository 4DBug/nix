{ ... }:

{
    imports = [
        /etc/nixos/hardware-configuration.nix
        ./nix.nix
        ./user.nix
        ./audio.nix
        ./graphics.nix
        ./locale.nix
        ./network.nix
        ./boot.nix
        ./security.nix
        # ./swap.nix
    ];
}
