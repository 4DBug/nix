{ ... }:

{
    services.flatpak.packages = [
        { appId = "com.github.tchx84.Flatseal"; origin = "flathub";  }
        { flatpakref = "https://sober.vinegarhq.org/sober.flatpakref"; sha256 = "1pj8y1xhiwgbnhrr3yr3ybpfis9slrl73i0b1lc9q89vhip6ym2l"; }
        { flatpakref = "https://dl.flathub.org/repo/appstream/org.gimp.GIMP.flatpakref"; sha256 = "1xw8vwpgmyjf5xhh101gqffpwa8x41pysfdl3glx2xv7ydhpc3bj"; }
        "dev.qwery.AddWater"
        "io.github.Foldex.AdwSteamGtk"
        "com.jeffser.Alpaca"
        "org.vinegarhq.Vinegar"
        "com.bambulab.BambuStudio"
        "org.gabmus.gfeeds"
        "org.gnome.Decibels"
        "org.pipewire.Helvum"
        "io.github.giantpinkrobots.flatsweep"
    ];
}
