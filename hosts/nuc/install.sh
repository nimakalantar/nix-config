
#!/usr/bin/env bash

# The name of the install drive
DISK=/dev/disk/by-id/nvme-Samsung_SSD_980_1TB_S649NL0T815408K
# Disk encryption password
PASSWORD="dummy"

# Partition using gpt as required by UEFI.
sudo -i parted $DISK -- mklabel gpt
# Boot partition
sudo -i parted $DISK -- mkpart ESP vfat 1MiB 512MiB
sudo -i parted $DISK -- set 1 boot on
# Primary partition
sudo -i parted $DISK -- mkpart primary 8.5GiB 100%

# Setup encryption on the primary partition.
sudo sh -c "echo $PASSWORD | cryptsetup luksFormat /dev/disk/by-partlabel/primary"
# Mount a decrypted version of the encrypted primary partition.
sudo sh -c "echo $PASSWORD | cryptsetup luksOpen /dev/disk/by-partlabel/primary nixos-decrypted"

# Swap partition
sudo -i parted $DISK -- mkpart primary linux-swap 512MiB 8.5GiB

# Format the boot partition.
sudo -i mkfs.vfat -n boot /dev/disk/by-partlabel/ESP
# Format the swap partition
sudo -i mkswap /dev/disk/by-partlabel/swap
# Format the decrypted version of the primary partition.
sudo -i mkfs.btrfs -L nixos /dev/mapper/nixos-decrypted

# Wait for disk labels to be ready.
sleep 4

# Mount your root file system
sudo -i mount -t tmpfs none /mnt
sudo -i mkdir -p /mnt/{boot,nix,etc/nixos,var/log}
sudo -i mount -o noatime /dev/disk/by-label/boot /mnt/boot
sudo -i swapon /dev/disk/by-partlabel/swap
sudo -i mount -o noatime /dev/disk/by-label/nixos /mnt

# Create a directory for persistent directories
sudo -i mkdir -p /mnt/nix/persist/{etc/nixos,var/log,home}

# Bind mount the persistent configuration / logs
sudo -i mount -o bind /mnt/nix/persist/etc/nixos /mnt/etc/nixos
sudo -i mount -o bind /mnt/nix/persist/var/log /mnt/var/log
sudo -i mount -o bind /mnt/nix/persist/home /mnt/home
