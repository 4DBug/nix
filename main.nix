{ lib, config, pkgs, inputs, ... }:

let
  nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
in
{
    imports = [
        /etc/nixos/hardware-configuration.nix
        inputs.nix-gaming.nixosModules.platformOptimizations
        inputs.nix-gaming.nixosModules.pipewireLowLatency
    ];

    system = {
        stateVersion = "25.11";

        autoUpgrade = {
            enable = true;
            allowReboot = true;
        };
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    users.users.bug = {
        isNormalUser = true;
        description = "Bug";
        extraGroups = [ "networkmanager" "wheel" "audio" "video" "libvirtd" ];
    };

    hardware = {
        graphics = {
            enable = true;
            enable32Bit = true;

            extraPackages = with pkgs; [
                libva-vdpau-driver
                libvdpau
                libvdpau-va-gl
                nvidia-vaapi-driver
                vdpauinfo
                libva
                libva-utils
            ];
        };

        nvidia = {
            modesetting.enable = true;

            powerManagement.enable = false;
            powerManagement.finegrained = false;

            open = false;

            nvidiaSettings = true;

            package = config.boot.kernelPackages.nvidiaPackages.stable;

            nvidiaPersistenced = false;
        };

        enableRedistributableFirmware = true;
    };

    systemd.user.extraConfig = "DefaultTimeoutStopSec=10s";

    boot = {
        kernelPackages = pkgs.linuxPackages_zen;

        kernel.sysctl = {
            "fs.file-max" = 524288;
        };
        
        initrd.checkJournalingFS = false;

        loader = {
            grub.splashImage = null;

            systemd-boot.enable = true;
            systemd-boot.configurationLimit = 10;
            
            efi.canTouchEfiVariables = true;
        };
    };
            
    swapDevices = [{
        device = "/var/lib/swapfile";
        size = 8 * 1024;
    }];
    
    zramSwap = {
        enable = true;
        memoryMax = 16 * 1024 * 1024 * 1024;
    };

    time.timeZone = "America/Chicago";

    i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
            LC_ADDRESS = "en_US.UTF-8";
            LC_IDENTIFICATION = "en_US.UTF-8";
            LC_MEASUREMENT = "en_US.UTF-8";
            LC_MONETARY = "en_US.UTF-8";
            LC_NAME = "en_US.UTF-8";
            LC_NUMERIC = "en_US.UTF-8";
            LC_PAPER = "en_US.UTF-8";
            LC_TELEPHONE = "en_US.UTF-8";
            LC_TIME = "en_US.UTF-8";
        };
    };

    networking = {
        hostName = "nix";

        networkmanager.enable = true;
        nameservers = ["1.1.1.1" "1.0.0.1"];
        
        enableIPv6 = false;
    };

    security = {
        rtkit.enable = true;

        sudo = {
            enable = true;
            wheelNeedsPassword = false;
        };
    };

    xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        config = {
            common.default = ["gtk"];
        };

        extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };

    services = {
        greetd.enable = true;

        system76-scheduler.enable = true;

        displayManager = {
            cosmic-greeter.enable = true;

            autoLogin = {
                enable = true;
                user = "bug";
            };
        };

        desktopManager.cosmic.enable = true;

        xserver = {
            enable = true;
            videoDrivers = ["nvidia"];
            excludePackages = [pkgs.xterm];

            xkb = {
                layout = "us";
                variant = "";
            };
        };

        openssh.enable = true;

        pulseaudio.enable = false;
        
        pipewire = {
            enable = true;

            alsa.enable = true;
            alsa.support32Bit = true;

            pulse.enable = true;

            lowLatency.enable = false;

            jack.enable = true;
        };

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
                #"com.bambulab.BambuStudio"
                "org.gnome.Decibels"
                "org.pipewire.Helvum"
            ];

            overrides = {
                global = {
                    Context.sockets = ["wayland" "!x11" "!fallback-x11"];
                };
            };
        };
    };

    fonts = {
        fontDir.enable = true;
        enableDefaultPackages = true;

        packages = with pkgs; [
            twitter-color-emoji
        ];

        fontconfig = {
            enable = true;
            useEmbeddedBitmaps = true;

            defaultFonts = {
                emoji = [ "Twitter Color Emoji" ];
            };
        };
    };

    users.users.bug.packages = with pkgs; [
        vscode

        (luajit.withPackages (ps: with ps; [
            luasocket
            bit32
        ]))

        go

        (python3.withPackages (ps: with ps; [
            unidecode
            discordpy
            setuptools

            pip
            pynput
            python-uinput

            mido



            pyautogui
            pygobject3
            pycairo

            tkinter
            pyautogui
        
            numpy
            scipy
            imageio

            evdev
        ]))

        nodejs

        (blender.withPackages (ps: with ps; [
            libGLU
            gcc
            zlib
            xorg.libX11
            fontconfig
            pcre2
            xorg.libXext
            gcc
            xorg.libxcb
            glib
        ]))

        plasticity
        obsidian
        vesktop
        nicotine-plus
        ptyxis
        fastfetch
        tree
        gh
        scanmem
        samrewritten
        impression
        #bambu-studio
        #orca-slicer
        resources

        authenticator

        steamtinkerlaunch

        obs-studio

        prismlauncher
        gimp
    ];

    environment = {
        variables = {
            GBM_BACKEND = "nvidia-drm";
            LIBVA_DRIVER_NAME = "nvidia";
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        };

        sessionVariables = {
            COSMIC_DATA_CONTROL_ENABLED = 1;
            WEBKIT_DISABLE_COMPOSITING_MODE = "1";
        };

        systemPackages = with pkgs; [
            home-manager
            comma
            nix-index

            git
            wget

            gcc
            gnumake

            nmap
            inetutils

            nix-output-monitor
            nvd

            nixd
            nil

            gnome-boxes

            jdk
            openjdk
            zlib
            glfw
            glew

            wine64
            wineWow64Packages.full

            lug-helper

            #inputs.nix-citizen.packages.${system}.star-citizen-git
            #inputs.nix-citizen.packages.${system}.star-citizen
            #inputs.nix-citizen.packages.${system}.wine-astral

            (nix-gaming.packages.${pkgs.hostPlatform.system}.star-citizen.override {
                tricks = [ "arial" "vcrun2019" "win10" "sound=alsa" ];
            })

            appimage-run

            vulkan-tools
            vulkan-validation-layers
            vulkan-loader

            protonplus

            pulseaudioFull

            gamemode

            winetricks
        ];
    };

    nixpkgs = {
        config = {
            allowUnfree = true;
            cudaSupport = true;

            nvidia.acceptLicense = true;
        };
    };
    
    virtualisation = {
        libvirtd.enable = true;
        spiceUSBRedirection.enable = true;
    };

    programs = {
        appimage = {
            enable = true;
            binfmt = true;
        };

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

        firefox.enable = true;

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

        gamescope = {
            enable = true;
            capSysNice = true;
            args = [
                "--rt"
                "--expose-wayland"
            ];
        };

        nix-ld = {
            enable = true;
            libraries = with pkgs; [

            ];
        };
    };
}
