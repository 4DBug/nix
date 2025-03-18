
{ config, lib, pkgs, ... }:

{
    users.users.bug = {
        isNormalUser = true;
        description = "Bug";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
            vscode

            go
            python3
            luau
            luajit
            nodejs

            blender
            plasticity

            neofetch
            tree
            gnome-tweaks
            wine

            obsidian

            vesktop
            nicotine-plus
            furnace

            pulseaudio

            # rpi-imager
            rpiboot

            mapscii

            cloudflared
        ];
    };

    programs = {
        bash.shellAliases = {
            rebuild = "sudo nixos-rebuild switch --impure";
            pi = "ssh $(nmap -sn 192.168.1.0/24 | grep \"pi.home\" | grep -oE '([0-9]{1,3}\\.){3}[0-9]{1,3}')";
            pico = "ssh pico.sh";
            # tuns name port
            tuns = "bash -c '\''if [ \"$#\" -ne 2 ]; then echo \"Usage: tun name port\"; exit 1; fi; 
if [[ \"$1\" =~ ^[0-9]+$ ]]; then port=\"$1\"; name=\"$2\"; 
elif [[ \"$2\" =~ ^[0-9]+$ ]]; then port=\"$2\"; name=\"$1\"; 
else echo \"Error: One argument must be a number (port)\"; exit 1; fi; 
ssh -R \"$\{name}:80:localhost:$\{port}\" tuns.sh'\'' _";
            # pgs name directory
            pgs = "bash -c '\''if [ \"$#\" -ne 2 ]; then echo \"Usage: pgs NAME DIRECTORY\"; exit 1; fi; rsync -rv \"$2\" pgs.sh:/\"$1\"'\'' _";
        };

        firefox.enable = true;

        steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
        };
    };

    # virtualisation.waydroid.enable = true;

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        git
        wget
        gcc
        nmap
        inetutils
        sshs
    ];

    services = {
        flatpak = {
            enable = true;

            remotes = lib.mkOptionDefault [{
                name = "flathub-beta";
                location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
            }];

            update.auto.enable = false;
            uninstallUnmanaged = false;

            packages = [
                { appId = "com.github.tchx84.Flatseal"; origin = "flathub";  }
                { flatpakref = "https://sober.vinegarhq.org/sober.flatpakref"; sha256 = "1pj8y1xhiwgbnhrr3yr3ybpfis9slrl73i0b1lc9q89vhip6ym2l"; }
                "dev.qwery.AddWater"
                "io.github.Foldex.AdwSteamGtk"
                "com.jeffser.Alpaca"
                "org.vinegarhq.Vinegar"
                "com.bambulab.BambuStudio"
                # "com.boxy_svg.BoxySVG"
                "org.gabmus.gfeeds"
                "org.gnome.Decibels"
                "org.pipewire.Helvum"
                "io.github.giantpinkrobots.flatsweep"
            ];
        };

        displayManager = {
            autoLogin = {
                enable = true;
                user = "bug";
            };
        };

        xserver = {
            enable = true;

            videoDrivers = ["nvidia"];

            displayManager.gdm.enable = true;
            desktopManager.gnome.enable = true;

            xkb = {
                layout = "us";
                variant = "";
            };
        };

        printing.enable = true;

        pipewire = {
            enable = true;

            alsa.enable = true;
            alsa.support32Bit = true;

            pulse.enable = true;

            jack.enable = true;
        };

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

    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    networking = {
        hostName = "nix"; 
        networkmanager.enable = true;
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

    hardware = {
        pulseaudio.enable = false;

        graphics = {
            enable = true;
        };

        nvidia = {
            modesetting.enable = true;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
    };

    security = {
        rtkit.enable = true;

        sudo = {
            enable = true;
            wheelNeedsPassword = false;
        };
    };

    systemd = {
        services."getty@tty1".enable = false;
        services."autovt@tty1".enable = false;
    };
}