{ config, pkgs, device, ... }:

{
    services = {
        xserver = {
            enable = true;

            videoDrivers = if (device == "desktop") then ["nvidia"] else ["amdgpu"];
            excludePackages = [pkgs.xterm];

            xkb = {
                layout = "us";
                variant = "";
            };
        };
    };

    hardware = {
        graphics = {
            enable = true;
            enable32Bit = true;

            extraPackages = with pkgs; [
                libva-vdpau-driver
                libvdpau
                libvdpau-va-gl
                vdpauinfo
                libva
                libva-utils
                libglvnd
                mesa
            ] ++ (if (device == "desktop") then [
                nvidia-vaapi-driver
            ] else [
                
            ]);
        };

        nvidia = if (device == "desktop") then {
            modesetting.enable = true;

            powerManagement.enable = false;
            powerManagement.finegrained = false;

            open = false;

            nvidiaSettings = true;

            package = config.boot.kernelPackages.nvidiaPackages.beta;

            nvidiaPersistenced = true;
        } else {};

        enableRedistributableFirmware = true;
    };


    environment = {
        variables = {

        } // (if (device == "desktop") then {
            WGPU_BACKEND = "gl";
            GBM_BACKEND = "nvidia-drm";
            LIBVA_DRIVER_NAME = "nvidia";
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
            EGL_PLATFORM = "wayland";
        } else {

        });

        sessionVariables = {
            WEBKIT_DISABLE_COMPOSITING_MODE = "1";
        } // (if (device == "desktop") then {
            WGPU_BACKEND = "gl";
            GBM_BACKEND = "nvidia-drm";
            LIBVA_DRIVER_NAME = "nvidia";
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
            EGL_PLATFORM = "wayland";
        } else {

        });
    };

    services.logind.settings.Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchDocked = "ignore";
    };
}