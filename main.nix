{ lib, config, inputs, pkgs, options, desktop, ... }:

let
    nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");

    nix-alien = import (
        builtins.fetchTarball "https://github.com/thiagokokada/nix-alien/tarball/master"
    ) {};
in
{
    imports = [
        /etc/nixos/hardware-configuration.nix
        nix-gaming.nixosModules.platformOptimizations
        nix-gaming.nixosModules.pipewireLowLatency
    ];

    system = {
        stateVersion = "25.11";

        autoUpgrade = {
            enable = true;
            allowReboot = true;
        };
    };

    nix.optimise.automatic = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    users.users.bug = {
        isNormalUser = true;
        description = "Bug";
        extraGroups = [ "networkmanager" "wheel" "audio" "video" "libvirtd" "ydotool" ];
    };

    hardware = {
        graphics = {
            enable = true;
            enable32Bit = true;

            extraPackages = with pkgs; [
                libva-vdpau-driver
                libvdpau
                libvdpau-va-gl
                vdpauinfo
                libva
                libva-utils
                libglvnd
                mesa
            ] ++ (if desktop then [
                nvidia-vaapi-driver
            ] else [
                
            ]);
        };

        nvidia = if desktop then {
            modesetting.enable = true;

            powerManagement.enable = false;
            powerManagement.finegrained = false;

            open = false;

            nvidiaSettings = true;

            package = config.boot.kernelPackages.nvidiaPackages.beta;

            nvidiaPersistenced = true;
        } else {};

        enableRedistributableFirmware = true;
    };

    systemd.user.extraConfig = ''
        DefaultEnvironment="PATH=/run/current-system/sw/bin"
    '';

    systemd.services.monitord.wantedBy = [ "multi-user.target" ];

    systemd.services.mpd.environment = {
        XDG_RUNTIME_DIR = "/run/user/1000";
    };

    boot = {
        kernelModules = if desktop then ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" "uinput"] else [];
        kernelParams = if desktop then ["nvidia-drm.modeset=1" "nvidia_drm.fbdev=1"] else [];

        kernelPackages = pkgs.linuxPackages_zen;

        kernel.sysctl = {
            "fs.file-max" = 524288;
        };
        
        initrd.checkJournalingFS = false;

        loader = {
            grub.splashImage = null;

            systemd-boot.enable = true;
            systemd-boot.configurationLimit = 25;
            
            efi.canTouchEfiVariables = true;
        };
    };
            
    swapDevices = [{
        device = "/var/lib/swapfile";
        size = 8 * 1024;
    }];
    
    zramSwap = {
        enable = true;
        memoryMax = 64 * 1024 * 1024 * 1024;
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
    };

    services.cloudflare-warp.enable = !desktop;
    

    security = {
        rtkit.enable = true;
        polkit.enable = true;

        sudo = {
            enable = true;
            wheelNeedsPassword = false;
        };
    };

    xdg = {
        portal = {
            enable = true;
            xdgOpenUsePortal = true;

            config = {
                common.default = ["gtk"];
            };

            extraPortals = [pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-cosmic];
        };

        mime = {
            enable = true;

            defaultApplications = {
                "text/html" = "firefox.desktop";
                "x-scheme-handler/http" = "firefox.desktop";
                "x-scheme-handler/https" = "firefox.desktop";
                "x-scheme-handler/about" = "firefox.desktop";
                "x-scheme-handler/unknown" = "firefox.desktop";
                "application/pdf" = "firefox.desktop";

                "inode/directory" = "com.system76.CosmicFiles.desktop";

                "text/plain" = "com.system76.CosmicEdit.desktop";
                "text/markdown" = "com.system76.CosmicEdit.desktop";

                "application/zip"                   = "org.gnome.FileRoller.desktop";
                "application/x-7z-compressed"       = "org.gnome.FileRoller.desktop";
                "application/x-tar"                 = "org.gnome.FileRoller.desktop";
                "application/gzip"                  = "org.gnome.FileRoller.desktop";
                "application/x-xz"                  = "org.gnome.FileRoller.desktop";
                "application/x-zip-compressed"      = "org.gnome.FileRoller.desktop";

                "application/x-ms-dos-executable"   = "wine.desktop";
            };
        };
    };

    services = {
        greetd.enable = true;
        
        logind.settings.Login = {
            HandleLidSwitch = "ignore";
            HandleLidSwitchDocked = "ignore";
        };

        system76-scheduler.enable = true;

        displayManager = {
            cosmic-greeter.enable = true;

            autoLogin = {
                enable = desktop;
                user = "bug";
            };
        };

        desktopManager = {
            cosmic.enable = true;
        };

        xserver = {
            enable = true;

            videoDrivers = if desktop then ["nvidia"] else ["amdgpu"];
            excludePackages = [pkgs.xterm];

            xkb = {
                layout = "us";
                variant = "";
            };
        };

        fstrim.enable = true;
        
        openssh.enable = true;

        pulseaudio.enable = false;
        
        pipewire = {
            enable = true;

            wireplumber.enable = true;

            alsa.enable = true;
            alsa.support32Bit = true;

            pulse.enable = true;

            lowLatency.enable = false;

            jack.enable = true;
        };

        mpd = {
            enable = !desktop;

            settings = {
                music_directory = "/run/media/bug/Music/";

                decoder = [
                    {
                        plugin = "ffmpeg";
                        enabled = "yes";
                    }
                    {
                        plugin = "opus";
                        enabled = "no"; 
                    }
                ];

                audio_output = [{
                    type = "pipewire";
                    name = "PipeWire Sound Server";
                }];
            };

            user = "bug";
        };

        ollama = {
            enable = false;

            loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b" "deepseek-r1:8b"];
        };

        syncthing = {
            enable = true;
 
            key = "~/.syncthing/key.pem";
            cert = "~/.syncthing/cert.pem";

            extraFlags = [ "--no-default-folder" ];
 
            settings = {
                devices = if desktop then {
                    "laptop" = { id = "C33XSW3-CUN7QOD-PK2SM37-MJCXNGA-K3UGTDR-TW53FZ7-BE7EWDC-QWVUXQ5"; };
                } else {
                    "desktop" = { id = "I664COC-GCOH2HX-KCVLP3R-R62LVPV-3W32DVQ-UMMBMDB-55MMIPH-OV54AAP"; };
                };

                folders = {
                    "nix" = {
                        path = "~/nix";
                        devices = if desktop then [ "laptop" ] else [ "desktop" ];
                    };

                    "Documents" = {
                        path = "~/Documents";
                        devices = if desktop then [ "laptop" ] else [ "desktop" ];
                    };

                    "Downloads" = {
                        path = "~/Downloads";
                        devices = if desktop then [ "laptop" ] else [ "desktop" ];
                    };
                };
            };
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

        # resources
        mission-center
        
        authenticator

        steamtinkerlaunch

        obs-studio

        #prismlauncher

        euphonica
        
        kooha
    ];

    environment = {
        variables = {
            MICRO_TRUECOLOR = 1;
        } // (if desktop then {
            WGPU_BACKEND = "gl";
            GBM_BACKEND = "nvidia-drm";
            LIBVA_DRIVER_NAME = "nvidia";
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
            EGL_PLATFORM = "wayland";
        } else {

        });

        sessionVariables = {
            BROWSER = "firefox";
            COSMIC_DATA_CONTROL_ENABLED = 1;
            WEBKIT_DISABLE_COMPOSITING_MODE = "1";
            NIXPKGS_ALLOW_UNFREE = 1;
        } // (if desktop then {
            WGPU_BACKEND = "gl";
            GBM_BACKEND = "nvidia-drm";
            LIBVA_DRIVER_NAME = "nvidia";
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
            EGL_PLATFORM = "wayland";
        } else {

        });

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
        ] ++ (if desktop then [
            (nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.star-citizen.override {
                tricks = [ "arial" "vcrun2019" "win10" "sound=alsa" ];
            })

            libxshmfence

            (appimage-run.override {
                extraPkgs = pkgs: [ pkgs.xorg.libxshmfence pkgs.linuxPackages.nvidia_x11 ];
            })
        ] else [
            bambu-studio
        ]);
    };

    nixpkgs = {
        config = {
            allowUnfree = true;

            cudaSupport = desktop;
            nvidia.acceptLicense = desktop;
        };

        overlays = [
            
        ];
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
            fetch = "fastfetch --file ~/nix/nix.ans";
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

            scale = "env GDK_BACKEND=x11 GDK_SCALE=1 GDK_DPI_SCALE=1";
            
            hytale = "env -u WAYLAND_DISPLAY -u EGL_PLATFORM -u ELECTRON_ENABLE_WAYLAND DISPLAY=:0 XDG_SESSION_TYPE=x11 __GLX_VENDOR_LIBRARY_NAME=nvidia LD_LIBRARY_PATH=/run/opengl-driver/lib hytale-launcher";
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
