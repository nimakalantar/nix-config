{disks ? ["/dev/nvme0n1"], ...}: {
  disk = {
    vdb = {
      type = "disk";
      device = builtins.elemAt disks 0;
      content = {
        type = "table";
        format = "gpt";
        partitions = [
          {
            type = "partition";
            name = "ESP";
            start = "1MiB";
            end = "512MiB";
            bootable = true;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          }
          {
            type = "partition";
            name = "luks";
            start = "512MiB";
            end = "100%";
            content = {
              type = "luks";
              name = "crypted";
              keyFile = "/tmp/secret.key";
              extraArgs = [
                "--hash sha512"
              ];
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          }
        ];
      };
    };
  };
  lvm_vg = {
    pool = {
      type = "lvm_vg";
      lvs = {
        root = {
          type = "lvm_lv";
          size = "465G";
          content = {
            type = "filesystem";
            format = "btrfs";
            mountpoint = "/";
            options = [
              "defaults,noatime,compress=zstd"
            ];
          };
        };
        home = {
          type = "lvm_lv";
          size = "465G";
          content = {
            type = "filesystem";
            format = "btrfs";
            mountpoint = "/home";
          };
        };
      };
    };
  };
}
