
#!/usr/bin/env bash

# The name of the install drive
DISK=/dev/nvme0n1
# Disk encryption password
PASSWORD="dummy"

# Partition using gpt as required by UEFI.
sudo -i parted $DISK -- mklabel gpt
# Boot partition
sudo -i parted $DISK -- mkpart ESP vfat 1MiB 512MiB
sudo -i parted $DISK -- set 1 boot on
# Swap partition
sudo -i parted $DISK -- mkpart primary linux-swap 512MiB 8.5GiB
# Primary partition
sudo -i parted $DISK -- mkpart primary 8.5GiB 100%

# Setup encryption on the primary partition.
sudo sh -c "echo $PASSWORD | cryptsetup luksFormat ${DISK}p3"
# Mount a decrypted version of the encrypted primary partition.
sudo sh -c "echo $PASSWORD | cryptsetup luksOpen ${DISK}p3 nixos-decrypted"


# Format the boot partition.
sudo -i mkfs.vfat -n boot /dev/disk/by-partlabel/ESP
# Format the swap partition
sudo -i mkswap /dev/disk/by-partlabel/swap
sudo -i swapon /dev/disk/by-partlabel/swap
# Format the decrypted version of the primary partition.
sudo -i mkfs.btrfs -L nixos /dev/mapper/nixos-decrypted

# Wait for disk labels to be ready.
sleep 4

# Mount your root file system
sudo -i mount -t btrfs /dev/mapper/nixos-decrypted /mnt
# We first create the subvolumes outlined above:
sudo -i btrfs subvolume create /mnt/root
sudo -i btrfs subvolume create /mnt/home
sudo -i btrfs subvolume create /mnt/nix
sudo -i btrfs subvolume create /mnt/persist
sudo -i btrfs subvolume create /mnt/log
# We then take an empty *readonly* snapshot of the root subvolume,
# which we'll eventually rollback to on every boot.
sudo -i btrfs subvolume snapshot -r /mnt/root /mnt/root-blank
sudo -i umount /mnt

# Mount root subvolume
mount -o subvol=root,compress=zstd,noatime /dev/mapper/nixos-decrypted /mnt
# Create a directory for persistent directories
sudo -i mkdir -p /mnt/{boot,home,nix,persist,var/log}
# Mount home subvolume
sudo -i mount -o subvol=home,compress=zstd,noatime /dev/mapper/nixos-decrypted /mnt/home
# Mount nix subvolume
sudo -i mount -o subvol=nix,compress=zstd,noatime /dev/mapper/nixos-decrypted /mnt/nix
# Mount persist subvolume
sudo -i mount -o subvol=persist,compress=zstd,noatime /dev/mapper/nixos-decrypted /mnt/persist
# Mount log subvolume
sudo -i mount -o subvol=log,compress=zstd,noatime /dev/mapper/nixos-decrypted /mnt/var/log
# Mount boot subvolume
sudo -i mount "$DISK"p1 /mnt/boot
