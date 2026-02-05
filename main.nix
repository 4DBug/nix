{ lib, config, inputs, pkgs, options, device, ... }:

{
    imports = [
        /etc/nixos/hardware-configuration.nix

        ./modules/users.nix
        ./modules/boot.nix
        ./modules/network.nix
        ./modules/locale.nix
        ./modules/security.nix
    ] ++ (if device == "server" then [
        ./modules/mailserver.nix
        ./modules/vscode-server.nix

        ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
                nh comma nix-index home-manager micro wget git fastfetch
            ];
        })
    ] else [
        ./modules/packages.nix
        ./modules/cosmic.nix
        ./modules/graphics.nix
        ./modules/audio.nix
        ./modules/home-manager.nix
        ./modules/swap.nix
        ./modules/virtualisation.nix
    ]) ++ (if device == "laptop" then [
        ./modules/mpd.nix
    ] else []);

    system = {
        stateVersion = "25.11";

        autoUpgrade = {
            enable = true;
            allowReboot = true;
        };
    };

    nix = {
        optimise.automatic = true;
        settings.experimental-features = [ "nix-command" "flakes" ];
    };

    nixpkgs = {
        config = {
            allowUnfree = true;

            cudaSupport = (device == "desktop");
            nvidia.acceptLicense = (device == "desktop");
        };

        overlays = [
            
        ];
    };

    environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;

    systemd = {
        user.extraConfig = ''
            DefaultEnvironment="PATH=/run/current-system/sw/bin"
        '';

        services.monitord.wantedBy = [ "multi-user.target" ];
    };

    services.fstrim.enable = true;

    programs = {
        bash.shellAliases = {
            fetch = "fastfetch --file ~/nix/nix.ans";

            rebuild = "ns os switch ~/nix"; #"sudo nixos-rebuild switch --impure"; # home-manager switch --impure

            #pissh = "ssh -t $(avahi-resolve-host-name -4 pi.home | awk '{print $2}')";
            #pi = "pissh \"cd $(pwd) && bash\"";
            #pi = "ssh pi.bug.tools";
            box = "ssh box.bug.tools";

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
    };
}
