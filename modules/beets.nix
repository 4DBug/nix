{ config, lib, pkgs, ... }:

{
    home = {
        packages = with pkgs; [
            beets
        ];

        file.".config/beets/config.yaml".text = ''
            library: ~/.local/share/beets/library.db
            directory: ~/Music

            import:
                write: true
                copy: true

            plugins: [convert fetchart embedart fromfilename chroma smartplaylist]

            paths:
                default: $artist/$album/$track

            convert:
                auto: true
                format: opus
                formats:
                    opus:
                    command: ffmpeg -i $source -y -vn -c:a libopus -b:a 160k $dest
                    extension: opus
                dest: ~/Music

            fetchart:
                auto: yes
                ifempty: yes
                art_filename: folder

            embedart:
                auto: yes

            smartplaylist:
                playlist_dir: ~/Music/playlists
                relative_to: library
                output: extm3u
        '';
    };
}