{ config, pkgs, device, ... }:

{
    services = {
        mpd = {
            enable = true;

            settings = {
                music_directory = "/run/media/bug/Music/";

                decoder = [
                    {
                        plugin = "ffmpeg";
                        enabled = "yes";
                    }
                    {
                        plugin = "opus";
                        enabled = "no"; 
                    }
                ];

                audio_output = [{
                    type = "pipewire";
                    name = "PipeWire Sound Server";
                }];
            };

            user = "bug";
        };
    };

    systemd.services = {
        mpd.environment = {
            XDG_RUNTIME_DIR = "/run/user/1000";
        };
    };
}