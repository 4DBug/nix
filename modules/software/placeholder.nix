{
  den.aspects.packages = {
    nixos = { pkgs, options, ... }: {
      environment.systemPackages = with pkgs; [
        gnome-boxes

        wine64
        wineWow64Packages.full

        appimage-run

        pulseaudioFull

        lug-helper
        gamemode
        steam-run

        firmware-updater

        file-roller

        baobab

        firefox-bin
      ];

      users.users.bug.packages = with pkgs; [
        obsidian
        vesktop
        nicotine-plus
        fastfetch
        gh
        scanmem
        samrewritten
        impression

        mission-center

        authenticator

        steamtinkerlaunch

        #prismlauncher

        euphonica

        kooha

        loupe

        arduino-ide

        geary

        fractal

        gnome-calendar
      ];


      services = {
          /*
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
                  "io.github.gaheldev.Millisecond"

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
          */

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

          steam = {
              enable = true;

              remotePlay.openFirewall = true;
              dedicatedServer.openFirewall = false;

              localNetworkGameTransfers.openFirewall = true;

              gamescopeSession.enable = true;

              extraCompatPackages = with pkgs; [
                  proton-ge-bin
              ];

              #platformOptimizations.enable = true;
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
                  libX11
                  libXcursor
                  libXrandr
                  libXi
              ]);
          };
      };
    };
  };
}
