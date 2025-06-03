{ pkgs, ... }:

{
    users.users.bug.packages = with pkgs; [
        # ide
        vscode
        zed-editor

        # languages
        luau

        (luajit.withPackages (ps: with ps; [
            luasocket
            bit32
            luautf8
            jsregexp
            lgi
            gtk3
            gobject-introspection
        ]))

        go

        (python3.withPackages (ps: with ps; [
            unidecode
            discordpy
            setuptools

            pip
            pynput
            python-uinput

        #    ninja
        #    pybind11

        #    diffusers
        #    einops
        #    opencv-python
        #    numpy
            #torch-bin
            #torchWithCuda
        #    transformers
        #    torchvision
            #taming-transformers-rom1504
            #ConfigArgParse
            #ipdb
        #    omegaconf

            #sentencepiece
        #    tqdm

            # Mesh Processing
        #    trimesh
        #    pymeshlab
        #    pygltflib
            
            #kornia
            #facexlib

            # Training
        #    accelerate
            #pytorch_lightning
            #scikit-learn
            #scikit-image

            # Demo only
        #    gradio
        #    fastapi
        #    uvicorn
        #    onnxruntime
            #gevent
            #geventhttpclient
        #    pymatting
        #    pooch
        #    jsonschema
        #    scikit-image

            pyautogui
            pygobject3
            pycairo

            tkinter
            pyautogui
        
            numpy
            scipy
            imageio
        ]))

        nodejs

        # 3D
        (blender.withPackages (ps: with ps; [
            libGLU
            gcc
            zlib
            xorg.libX11
            fontconfig
            pcre2
            xorg.libXext
            gcc
            xorg.libxcb
            glib
        ]))

        #plasticity

        # video
        # kdenlive

        # markdown / notes
        obsidian

        # social
        vesktop

        # music
        nicotine-plus
        furnace
        pulseaudio

        # utilties
        #mapscii
        cloudflared
        base16-schemes
        ptyxis
        rpi-imager
        fastfetch
        tree
        gnome-tweaks
        wine
        wine64
        xclicker
        gh
        scanmem
        #openrgb
        samrewritten
        #testdisk
        impression
        bambu-studio
        sushi
        #lutris
        resources
        #discord
        authenticator
        eyedropper
        #turtle
        #xonotic
        buffer
    ];
}
