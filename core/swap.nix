{ ... }:

{
    swapDevices = [
        {
            device = "/var/lib/swapfile";
            size = 16 * 1024;
        }
    ];

    zramSwap = {
        enable    = true;
        memoryMax = 64 * 1024 * 1024 * 1024;
    };
}
