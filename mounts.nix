{ ... }:
{
  fileSystems."/home/sky/mnt/ssd" = {
    device = "/dev/nvme0n1p1";
    fsType = "ext4";
    options = ["defaults"];
  };
}
