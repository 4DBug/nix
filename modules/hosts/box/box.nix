
{ den, ... }: {
  den.aspects.box = {
    includes = with den.aspects; [
      den.default
      den.provides.home-manager
      syncthing
      fish

      cloudflared
      searxng
      copyparty
      glances
      # invidious
      mailserver
      #matrix
      redlib
      #sish
      vscode-server
      dns
      openssh
      gitea
    ];

    nixos = {
      networking.hostName = "box";

      users.users.levi = {
        isNormalUser = true;
        description = "levi";
        extraGroups = [];

        hashedPasswordFile = "/home/bug/users/levi.passwd";
      };
    };
  };
}
