{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        home-manager
        comma
        nix-index

        git
        wget

        # compiling
        gcc
        gnumake

        # network
        nmap
        inetutils
        sshs

        # input testing
        evtest

        # nix language server
        nixd
        nil

        gtk3
        gobject-introspection

        libadwaita

        appimage-run

        nimble
        clang
        gnumake
        nim
        pkg-config
        mimalloc

        gnome-boxes

        glib
        libgbinder
        pcre2
        gtk4
        libadwaita
        lxc
        dnsmasq
    ];
}
