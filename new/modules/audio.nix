{ config, pkgs, device, ... }:

{
    security.rtkit.enable = true;

    services = {
        pulseaudio.enable = false;
        
        pipewire = {
            enable = true;

            wireplumber.enable = true;

            alsa.enable = true;
            alsa.support32Bit = true;

            pulse.enable = true;

            lowLatency.enable = false;

            jack.enable = true;
        };
    }
}