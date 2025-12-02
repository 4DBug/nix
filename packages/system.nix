{ pkgs, inputs, ... }:

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

        #gtk3
        #gobject-introspection

        #libadwaita

        #appimage-run

        #nimble
        #clang
        #gnumake
        #nim
        #pkg-config
        #mimalloc

        gnome-boxes

        #glib
        #libgbinder
        #pcre2
        #gtk4
        #libadwaita
        #lxc
        #dnsmasq

        #cmake
        #clang
        #zulu
        jdk
        openjdk
        #mesa
        #libGLU
        zlib
        glfw
        #gtkmm4
        #pangomm_2_48
        #glibmm_2_68 
        #cairomm
        #libsigcxx
        #gtk4
        #pango
        #gdk-pixbuf
        #cairo
        #harfbuzz
        #graphene
        #glib
        #vulkan-loader
        glew
        #freeglut
        #gcc

        #gparted
        #polkit

        #dxvk
        #vkd3d
        #wine
        wine64
        wineWow64Packages.full

        #lug-helper

        #inputs.nix-citizen.packages.${system}.star-citizen-git
        #nix-citizen.packages.${system}.star-citizen
        #nix-citizen.packages.${system}.wine-astral

        docker
        freerdp
        appimage-run
        gamemode
    ];
}
