{ config, pkgs, ... }:

{
  boot.supportedFilesystems = [ "fuse.sshfs" ];
  environment.systemPackages = [ pkgs.sshfs ];

  systemd.tmpfiles.rules = [
    "d /mnt/box 0755 root root -"
  ];

  fileSystems."/mnt/box" = {
    device = "bug@box.bug.tools:/";
    fsType = "fuse.sshfs";
    options = [
      "identityfile=/home/bug/.ssh/id_ed25519"
      "allow_other"
      "x-systemd.automount" 
      "noauto"
      "reconnect"
      "ServerAliveInterval=15"
    ];
  };
}