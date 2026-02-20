{
  den.aspects.beets = {
    homeManager = { pkgs, ... }: {
      home = {
        packages = with pkgs; [
          beets
          ffmpeg
          chromaprint
        ];

        file.".config/beets/config.yaml".text = ''
          library: ~/.local/share/beets/library.db
          directory: ~/Music

          import:
            write: true
            copy: true

          plugins:
            - convert
            - fetchart
            - embedart
            - fromfilename
            - chroma
            - smartplaylist

          paths:
            default: $artist/$album/$track - $title

          convert:
            auto: true
            format: opus
            formats:
              opus: ffmpeg -i $source -y -vn -c:a libopus -b:a 160k $dest
            dest: /home/bug/Music

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
    };
  };
}
