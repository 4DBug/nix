{ pkgs, ... }:

{
    fonts = {
        fontDir.enable = true;
        enableDefaultPackages = true;

        packages = with pkgs; [
            twitter-color-emoji
        ];

        fontconfig = {
            enable = true;
            useEmbeddedBitmaps = true;

            defaultFonts = {
                emoji = [ "Twitter Color Emoji" ];
            };
        };
    };
}
