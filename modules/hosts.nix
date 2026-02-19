let
  bug = {
    isNormalUser = true;
    description = "bug";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "libvirtd" "ydotool" "dialout" ];
  };
in {
  den.hosts.x86_64-linux = {
    nix.users.bug = bug;
    laptop.users.bug = bug;
    box.users.bug = bug;
  };

  den.homes.x86_64-linux.bug = { aspect = "bug"; };
}
