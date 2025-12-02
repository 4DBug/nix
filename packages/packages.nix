{ lib, pkgs, config, ... }:

{
    imports = [
        ./user.nix
        ./system.nix
        ./flatpak.nix
    ];

    nixpkgs = {
        config = {
            allowUnfree = true;
            #cudaSupport = true;
        };

        overlays = [
            (self: super: {
                plasticity-beta = self.callPackage ./plasticity.nix { };
            })
        ];
    };
    
    services.flatpak = {
        enable = true;

        remotes = lib.mkOptionDefault [{
            name = "flathub-beta";
            location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
        }];

        update.auto.enable = true;
        uninstallUnmanaged = true;
    };

    environment.sessionVariables = {
        WEBKIT_DISABLE_COMPOSITING_MODE = "1";
    };

    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = ["bug"];

    virtualisation.libvirtd.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;

    virtualisation.docker.enable = true;
    
    programs.appimage.enable = true;
    programs.appimage.binfmt = true;

    programs = {
        bash.shellAliases = {
            fetch = "fastfetch --file ~/Pictures/Ansi/nix.ans";
            neofetch = "fetch";

            rebuild = "sudo nixos-rebuild switch --impure"; # home-manager switch --impure

            #pissh = "ssh -t $(avahi-resolve-host-name -4 pi.home | awk '{print $2}')";
            #pi = "pissh \"cd $(pwd) && bash\"";
            pi = "ssh pi.bug.tools";

            pico = "ssh pico.sh";

            # tuns name port
            tuns = "bash -c '\''if [ \"$#\" -ne 2 ]; then echo \"Usage: tun name port\"; exit 1; fi;
if [[ \"$1\" =~ ^[0-9]+$ ]]; then port=\"$1\"; name=\"$2\";
elif [[ \"$2\" =~ ^[0-9]+$ ]]; then port=\"$2\"; name=\"$1\";
else echo \"Error: One argument must be a number (port)\"; exit 1; fi;
ssh -R \"$\{name}:80:localhost:$\{port}\" tuns.sh'\'' _";

            # pgs name directory
            pgs = "bash -c '\''if [ \"$#\" -ne 2 ]; then echo \"Usage: pgs NAME DIRECTORY\"; exit 1; fi; rsync -rv \"$2\" pgs.sh:/\"$1\"'\'' _";
        
            bambu = "env -u WAYLAND_DISPLAY XDG_SESSION_TYPE=x11 WEBKIT_FORCE_COMPOSITING_MODE=1 WEBKIT_DISABLE_COMPOSITING_MODE=1 GBM_BACKEND=dri bambu-studio";
        };

        dconf.enable = lib.mkDefault true;

        firefox.enable = true;

        steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
        };

        nix-ld = {
            enable = true;
            libraries = with pkgs; [
                gtk3
                xorg.libX11
                #glib
                #libgbinder
                #pcre2
                #gtk4
                #libadwaita
                #lxc
                #dnsmasq
                #alsa-lib
                #libGL

                #libGLU
                mesa
                #gcc
                zlib
                #xorg.libX11
                #fontconfig
                #pcre2
                #xorg.libXext
                #gcc
                #xorg.libxcb
                #pkgs.qt5.full pkgs.freetype pkgs.fontconfig
                #pkgs.xorg.libX11 pkgs.xorg.libxcb pkgs.xorg.libXext
                #pkgs.xorg.libXrender

                
                cmake
                clang
                zulu
                jdk
                openjdk
                mesa
                libGL
                libGLU
                zlib
                glfw
                gtkmm4
                pangomm_2_48
                #glibmm_2_68 
                cairomm_1_16
                libsigcxx30
                gtk4
                pango
                gdk-pixbuf
                cairo
                harfbuzz
                graphene
                glib
                vulkan-loader
                glew
                freeglut
                gcc

                brotli
                libpng

                libunwind

                jdk17_headless
                libunwind
                gcc
                mesa
                glew
                glfw
                zlib
            ];
        };
    };
    
    services = {
        printing.enable = true;

        ollama = {
            enable = true;
            acceleration = "cuda";
        };

        syncthing = {
            enable = true;
            user = "bug";
            group = "wheel";
            dataDir = "/home/bug/";
        };
    };
}
