{ config, pkgs, device, ... }:

{
    fileSystems."/mnt/box" = {
        device = "bug@box.bug.tools:/";
        fsType = "fuse.sshfs";
        options = [
            "identityfile=/home/bug/.ssh/id_ed25519"
            "idmap=user"
            "x-systemd.automount"
            "allow_other"
            "user"
            "_netdev"
        ];
    };

    boot.supportedFilesystems."fuse.sshfs" = true;
}