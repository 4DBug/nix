{ inputs, lib, ... }: {
  den.aspects.flatpak = {
    nixos = { pkgs, ... }: {
      imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

      services.flatpak = {
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
    };
  };
}
