# set user as sudo
su
adduser $USER sudo
echo "$USER  ALL=(ALL) NOPASSWD: ALL" >> /etc/sudo
exit

# install utils
apt install curl htop git

# install docker-compose
sudo curl -SL https://github.com/docker/compose/releases/download/v2.29.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose;

# install guest additions
sudo apt install -y build-essential dkms linux-headers-$(uname -r)
sudo mkdir -p /mnt/cdrom
sudo mount /dev/cdrom /mnt/cdrom
sudo /mnt/cdrom/VBoxLinuxAdditions.run
sudo reboot
