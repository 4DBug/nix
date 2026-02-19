{
  den.aspects.glances = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.glances ];

      users.users.glances = {
        isSystemUser = true;
        group = "glances";
        home = "/var/lib/glances";
        createHome = true;
      };

      users.groups.glances = {};

      systemd.services.glances-web = {
        description = "glances web interface";
        after = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          User = "glances";
          Group = "glances";

          ExecStart = ''
          ${pkgs.glances}/bin/glances \
            -w \
            -p 61208 \
            -B 0.0.0.0
          '';

          Restart = "always";
          RestartSec = 5;

          NoNewPrivileges = true;
          PrivateTmp = true;
          ProtectSystem = "strict";
          ProtectHome = true;
          LockPersonality = true;
          MemoryDenyWriteExecute = true;
        };
      };
    };
  };
}
