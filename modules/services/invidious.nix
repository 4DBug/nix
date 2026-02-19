{
  den.aspects.invidious = {
    nixos = { pkgs, lib, ... }: let
      companionPort = 8282;
      companionPath = "/companion";
      companionKey  = "kKg3RKeZjE7frmvw";
    in {
      virtualisation.podman.enable = true;
      virtualisation.oci-containers.backend = lib.mkDefault "podman";

      virtualisation.oci-containers.containers.invidious-companion = {
      image = "quay.io/invidious/invidious-companion:latest";
        extraOptions = [ "--network=host" "--pull=always" ];

        environment = {
          SERVER_SECRET_KEY = companionKey;
          HOST              = "127.0.0.1";
          PORT              = toString companionPort;
          SERVER_BASE_URL   = "http://127.0.0.1:${toString companionPort}";

          # HTTP_PROXY  = "http://proxy.example:3128";
          # HTTPS_PROXY = "http://proxy.example:3128";
          # NO_PROXY    = "127.0.0.1,localhost";
        };
      };

      services.invidious = {
        enable = true;
        package = pkgs.invidious;

        address = "127.0.0.1";
        port = 3030;

        nginx.enable = false;
        sig-helper.enable = false;

        settings = {
          domain = "tube.bug.tools";
          https_only = true;
          external_port = 443;

          use_pubsub_feeds = true;
          use_innertube_for_captions = true;

          visitor_data = "Cgt6ZmQ4UEtOUkJJNCjwtcPMBjIKCgJVUxIEGgAgXA%3D%3D";
          po_token = "Mni77CY6tviRIrvQXWaz6OfDryNNzAlKeIj4m0N1SHIITM94AZ8R0fK2dfuYke5tjZJjD33c4jB94p1Wy_XKCJPNbSkE2dgzRPdP502Q8ufofOe6fd4hV-fZFitud_tZO_BcNa18nKgfnupVYgV8huPgaFu-RKyGPIU=";

          invidious_companion = [
            { private_url = "http://127.0.0.1:${toString companionPort}${companionPath}"; }
          ];

          popular_enabled = true;

          invidious_companion_key = companionKey;
        };
      };

      systemd.services.invidious = let dep = "podman-invidious-companion.service"; in {
        wants    = [ dep ];
        after    = [ dep ];
        requires = [ dep ];
      };
    };
  };
}
