{ pkgs, ... }:

{
    users.users.bug.packages = with pkgs; [
        # ide
        vscode
        zed-editor

        # languages

        luau

        (luajit.withPackages (ps: with ps; [
            luasocket
            bit32
            luautf8
            jsregexp
        ]))

        go

        (python3.withPackages (ps: with ps; [
            pip
            pynput
            python-uinput
        ]))

        nodejs

        # 3D
        blender
        plasticity

        # video
        kdenlive

        # markdown / notes
        obsidian

        # social
        vesktop

        # music
        nicotine-plus
        furnace
        pulseaudio

        # utilties
        mapscii
        cloudflared
        base16-schemes
        ptyxis
        ## rpi-imager
        neofetch
        fastfetch
        tree
        gnome-tweaks
        wine
    ];
}
