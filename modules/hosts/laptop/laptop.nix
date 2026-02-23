
{ den, ... }: {
  den.aspects.laptop = {
    includes = [
      den.default
      <amdgpu>
      <cosmic>
      <firefox>
      <audio>

      den.provides.home-manager
      <stylix>
      <syncthing>
      <swap>
      <cloudflare-warp>
      <packages>
      <development>
      <cad>
      <mpd>
      <virtualisation>
      <flatpak>
      <fish>
      <dns>
      <openssh>
      <beets>
    ];

    nixos = {
      networking.hostName = "nix";

      services.logind.settings.Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchDocked = "ignore";
      };
    };
  };
}
