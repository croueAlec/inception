echo Welcome
# set user as sudo
su
adduser $USER sudo
echo "$USER  ALL=(ALL) NOPASSWD: ALL" >> /etc/sudo
exit

# install utils
apt update
apt install curl htop git vim

# install docker-compose
curl -SL https://github.com/docker/compose/releases/download/v2.29.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose;
curl -sSL https://get.docker.com/ | sh
groupadd docker
usermod -aG docker $USER
chmod 666 /var/run/docker.sock

# install vscode
apt install software-properties-common apt-transport-https wget -y
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
apt install code
code --version

# install guest additions
apt install -y build-essential dkms linux-headers-$(uname -r)
mkdir -p /mnt/cdrom
  ## on virtual box insert the cd [ Devices > Insert Guest Additions CD Image ] ##
mount /dev/cdrom /mnt/cdrom
/mnt/cdrom/VBoxLinuxAdditions.run
reboot
