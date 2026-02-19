{
  den.aspects.development = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        file-roller
      ];

      users.users.bug.packages = with pkgs; [
        zed-editor

        vscode

        tree
        gh
        scanmem

        arduino-ide
      ];
    };
  };
}
