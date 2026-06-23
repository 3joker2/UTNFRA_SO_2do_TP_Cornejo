#!/bin/bash
# PUNTO A - LVM
# Cornejo

echo "=== PUNTO A - LVM ==="

# me fijo que discos tengo
lsblk -d -o NAME,SIZE,TYPE

# agarro los de 2G y 1G
DISCO_2GB=$(lsblk -d -o NAME,SIZE | grep -E "^[a-z]+[[:space:]]+2G$" | awk '{print $1}')
DISCO_1GB=$(lsblk -d -o NAME,SIZE | grep -E "^[a-z]+[[:space:]]+1G$" | awk '{print $1}')

echo "laburo con /dev/$DISCO_2GB y /dev/$DISCO_1GB"

# particiono el de 2GB
echo "particionando $DISCO_2GB ..."
sudo fdisk /dev/$DISCO_2GB << EOF
n
p


t
8E
w
EOF

# particiono el de 1GB
echo "particionando $DISCO_1GB ..."
sudo fdisk /dev/$DISCO_1GB << EOF
n
p


t
8E
w
EOF

# creo los pv
sudo pvcreate /dev/${DISCO_2GB}1 /dev/${DISCO_1GB}1

# creo los vg
sudo vgcreate vg_datos /dev/${DISCO_2GB}1
sudo vgcreate vg_temp /dev/${DISCO_1GB}1

# lv
sudo lvcreate -L 5M -n lv_docker vg_datos
sudo lvcreate -L 1.5G -n lv_workareas vg_datos
sudo lvcreate -L 512M -n lv_swap vg_temp

# formateo
sudo mkfs.ext4 /dev/vg_datos/lv_docker
sudo mkfs.ext4 /dev/vg_datos/lv_workareas
sudo mkswap /dev/vg_temp/lv_swap

# directorios
sudo mkdir -p /var/lib/docker /work

# monto
sudo mount /dev/vg_datos/lv_docker /var/lib/docker/
sudo mount /dev/vg_datos/lv_workareas /work/
sudo swapon /dev/vg_temp/lv_swap

# fstab
echo '/dev/vg_datos/lv_docker /var/lib/docker ext4 defaults 0 0' | sudo tee -a /etc/fstab
echo '/dev/vg_datos/lv_workareas /work ext4 defaults 0 0' | sudo tee -a /etc/fstab
echo '/dev/vg_temp/lv_swap none swap sw 0 0' | sudo tee -a /etc/fstab

# verifico
echo ""
echo "como queda:"
sudo pvs
sudo vgs
sudo lvs
df -h | grep -E "(vg_datos|vg_temp)"
sudo swapon --show | grep lv_swap

echo "listo punto A"
