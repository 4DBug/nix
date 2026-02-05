{ lib, config, inputs, pkgs, options, device, ... }:

let
    nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");

    nix-alien = import (
        builtins.fetchTarball "https://github.com/thiagokokada/nix-alien/tarball/master"
    ) {};
in
{
    imports = [
        nix-gaming.nixosModules.platformOptimizations
        nix-gaming.nixosModules.pipewireLowLatency
    ];

    nixpkgs = {
        config = {
            allowUnfree = true;

            cudaSupport = (device == "desktop");
            nvidia.acceptLicense = (device == "desktop");
        };

        overlays = [
            
        ];
    };

    environment.sessionVariables = {
        BROWSER = "firefox";
        NIXPKGS_ALLOW_UNFREE = 1;
    };

    users.users.bug.packages = with pkgs; [
        vscode

        (luajit.withPackages (ps: with ps; [
            luasocket
            bit32
        ]))

        go

        #(python3.withPackages (ps: with ps; [
            #unidecode
            #discordpy
            #setuptools

            #pip
            #pynput
            #python-uinput

            #mido

            #pyautogui
            #pygobject3
            #pycairo

            #tkinter

            #numpy
            #scipy
            #imageio

            #evdev
        #]))

        nodejs

        (blender.withPackages (ps: with ps; [
            libGLU
            gcc
            zlib
            xorg.libX11
            fontconfig
            pcre2
            xorg.libXext
            xorg.libxcb
            glib
        ]))

        plasticity
        obsidian
        vesktop
        nicotine-plus
        fastfetch
        tree
        gh
        scanmem
        samrewritten
        impression

        mission-center
        
        authenticator

        steamtinkerlaunch

        obs-studio

        #prismlauncher

        euphonica
        
        kooha

        loupe

        arduino-ide

        geary
    ];

    environment.systemPackages = with pkgs; [
        home-manager
        comma
        nix-index

        git
        wget

        gcc
        gnumake

        nmap
        inetutils

        nix-prefetch
        nix-output-monitor
        nvd

        nixfmt
        nixd
        nil

        nh

        gnome-boxes

        openjdk
        zlib
        glfw
        glew

        wine64
        wineWow64Packages.full

        lug-helper

        appimage-run

        vulkan-tools
        vulkan-validation-layers
        vulkan-loader

        pulseaudioFull

        gamemode

        winetricks

        steam-run

        firmware-updater

        cosmic-applets
        cosmic-edit
        cosmic-ext-calculator
        cosmic-ext-tweaks
        cosmic-screenshot
        quick-webapps

        nix-alien.nix-alien

        file-roller
        unzip

        xdg-desktop-portal-gtk
        xdg-desktop-portal-cosmic

        mangohud
        mesa-demos

        lutris

        gnome-software

        neovim

        micro
        
        inputs.hytale-launcher.packages.${pkgs.system}.default

        baobab
    ] ++ (if (device == "desktop") then [
        #(nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.star-citizen.override {
        #    tricks = [ "arial" "vcrun2019" "win10" "sound=alsa" ];
        #})

        inputs.nix-citizen.packages.${system}.rsi-launcher
        
        libxshmfence

        (appimage-run.override {
            extraPkgs = pkgs: [ pkgs.xorg.libxshmfence pkgs.linuxPackages.nvidia_x11 ];
        })
    ] else [
        bambu-studio

        inputs.nix-citizen.packages.${system}.rsi-launcher
    ]);

    services = {
        flatpak = {
            enable = true;

            remotes = lib.mkOptionDefault [{
                name = "flathub-beta";
                location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
            }];

            update.auto.enable = true;
            uninstallUnmanaged = true;

            packages = [
                "org.vinegarhq.Sober"
                "org.vinegarhq.Vinegar"
                "org.gnome.Decibels"
                "org.pipewire.Helvum"
                "community.pathofbuilding.PathOfBuilding"

                {
                    appId = "com.hytale.Launcher";
                    sha256 = "sha256-SUxfyovC2umZmsOj5bOTZ8WfGCpnWcz7svOESwNekV0=";
                    bundle = "${pkgs.fetchurl {
                        url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-latest.flatpak";
                        sha256 = "sha256-SUxfyovC2umZmsOj5bOTZ8WfGCpnWcz7svOESwNekV0=";
                    }}";
                }

                # add Polytoria client
                # https://cdn.polytoria.com/releases/installer/linux/Polytoria%20Setup%204.12.0.flatpak

                {
                    appId = "com.polytoria.launcher";
                    sha256 = "sha256-VjhNiJfSdCtlH2SuP3Mn8jjOrx5xcOqhtDKaWYIwxYg=";
                    bundle = "${pkgs.fetchurl {
                        url = "https://github.com/4DBug/poly/releases/download/poly/poly.flatpak";
                        sha256 = "sha256-VjhNiJfSdCtlH2SuP3Mn8jjOrx5xcOqhtDKaWYIwxYg=";
                    }}";
                }
            ];

            overrides = {
                global = {
                    Context.sockets = ["wayland" "!x11" "!fallback-x11"];
                };
            };
        };

        ollama = {
            enable = false;

            loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b" "deepseek-r1:8b"];
        };
    };

    fonts = {
        fontDir.enable = true;
        enableDefaultPackages = true;

        packages = with pkgs; [
            twitter-color-emoji
            nerd-fonts.fira-code
            nerd-fonts.droid-sans-mono
        ];

        fontconfig = {
            enable = true;
            useEmbeddedBitmaps = true;

            defaultFonts = {
                emoji = [ "Twitter Color Emoji" ];
            };
        };
    };

    programs = {
        appimage = {
            enable = true;
            binfmt = true;
        };

        firefox = {
            enable = true;

            package = pkgs.firefox-bin;
        };

        steam = {
            enable = true;

            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = false;

            localNetworkGameTransfers.openFirewall = true;

            gamescopeSession.enable = true;

            extraCompatPackages = with pkgs; [
                proton-ge-bin
            ];

            platformOptimizations.enable = true;
        };

        ydotool.enable = true;

        gamescope = {
            enable = true;
            capSysNice = true;
            args = [
                "--rt"
                "--expose-wayland"
            ];
        };

        virt-manager.enable = true;

        nix-ld = {
            enable = true;

            libraries = options.programs.nix-ld.libraries.default ++ (with pkgs; [
                libxml2
                udev
                gcc
                egl-wayland
                mesa
                libglvnd
                wayland
                xorg.libX11
                xorg.libXcursor
                xorg.libXrandr
                xorg.libXi
            ]);
        };
    };
}