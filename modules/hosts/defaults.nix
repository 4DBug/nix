{
  den.default = {
    nixos = { pkgs, ... }: {
      imports = [
        /etc/nixos/hardware-configuration.nix
      ];

      system = {
        stateVersion = "26.05";

        autoUpgrade = {
          enable = true;
          allowReboot = false;
        };
      };

      nixpkgs = {
        config = {
          allowUnfree = true;
        };
      };

      nix = {
        optimise.automatic = true;
        settings.experimental-features = [ "nix-command" "flakes" ];
      };

      security = {
        sudo = {
          enable = true;
          wheelNeedsPassword = false;
        };
      };

      boot = {
        kernelPackages = pkgs.linuxPackages_zen;

        initrd.checkJournalingFS = false;

        loader = {
          grub.splashImage = null;

          systemd-boot = {
            enable = true;
            configurationLimit = 25;
          };

          efi.canTouchEfiVariables = true;
        };
      };

      environment.systemPackages = with pkgs; [
        comma
        fastfetch
        git
        home-manager
        inetutils
        micro
        nh
        nil
        nixd
        nixfmt
        nix-index
        nix-output-monitor
        nix-prefetch
        nvd
        psmisc
        tree
        unzip
        wget
      ];

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
    };

    homeManager = {
      home = {
        stateVersion = "26.05";
      };
    };
  };
}
