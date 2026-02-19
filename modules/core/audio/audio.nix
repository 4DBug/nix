{
  den.aspects.audio = {
    nixos = {
      security.rtkit.enable = true;

      services = {
        pulseaudio.enable = false;

        pipewire = {
          enable = true;

          wireplumber.enable = true;

          alsa = {
            enable = true;
            support32Bit = true;
          };

          pulse.enable = true;

          #lowLatency.enable = false;

          jack.enable = true;
        };
      };
    };
  };
}
