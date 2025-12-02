{ ... }:

{
    services.flatpak.packages = [
        { appId = "com.github.tchx84.Flatseal"; origin = "flathub";  }
        "org.vinegarhq.Sober"
        "org.vinegarhq.Vinegar" 
        { flatpakref = "https://dl.flathub.org/repo/appstream/org.gimp.GIMP.flatpakref"; sha256 = "1xw8vwpgmyjf5xhh101gqffpwa8x41pysfdl3glx2xv7ydhpc3bj"; }
        #"com.bambulab.BambuStudio"
        "org.gnome.Decibels"
        "org.pipewire.Helvum"
        #"io.github.giantpinkrobots.flatsweep"
        "net.codelogistics.clicker"
    ];
}
