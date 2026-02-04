{ config, pkgs, device, ... }:

{
    services.logind.settings.Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchDocked = "ignore";
    };
}