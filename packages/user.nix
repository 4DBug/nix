
{ config, lib, pkgs, ... }:

{
    users.users.bug.packages = with pkgs; [
        vscode

        go

        (python3.withPackages (ps: with ps; [
            pip
            pynput
            python-uinput
        ]))

        luau

        (luajit.withPackages (ps: with ps; [
            luasocket
            bit32
            luautf8
            jsregexp
        ]))

        nodejs

        blender
        plasticity

        kdenlive

        neofetch
        fastfetch

        tree
        gnome-tweaks
        wine

        obsidian

        vesktop
        nicotine-plus
        furnace

        pulseaudio

        # rpi-imager

        mapscii

        cloudflared

        base16-schemes

        ptyxis
    ];
}