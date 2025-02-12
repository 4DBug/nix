{ config, lib, pkgs, ... }:

{
  users.users.bug = {
    isNormalUser = true;
    description = "Bug";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
        vscodium
        neofetch
        git
        btop
        nodejs
        luau
        luajit
        luarocks
        nicotine-plus
        discord
        zed-editor
        blender
        plasticity
        obs-studio
        kdenlive
        furnace
        obsidian
    ];
  };
}