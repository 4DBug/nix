{ config, lib, pkgs, ... }:

{
  environment = {
    # env
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    # packages
    systemPackages = with pkgs; [
      rofi-wayland
      waybar
      swww
      kitty
      ags
      gammastep
      fcitx5
      hypridle
      easyeffects
      wl-clipboard
      foot
      cliphist
      slurp
      grim
      swappy
      tesseract
      hyprpicker
      libnotify
    ];
  };
}