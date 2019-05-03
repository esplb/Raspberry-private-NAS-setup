#upgrade from Jessie to Stretch
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo sed -i /deb/s/jessie/stretch/g /etc/apt/sources.list
sudo sed -i /deb/s/jessie/stretch/g /etc/apt/sources.list.d/*.list
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

#install && start docker
sudo apt install wget -y
wget https://download.docker.com/linux/debian/dists/stretch/pool/stable/armhf/docker-ce_18.09.5~3-0~debian-stretch_armhf.deb
wget https://download.docker.com/linux/debian/dists/stretch/pool/stable/armhf/docker-ce-cli_18.09.5~3-0~debian-stretch_armhf.deb
wget https://download.docker.com/linux/debian/dists/stretch/pool/stable/armhf/containerd.io_1.2.5-1_armhf.deb

sudo dpkg -i containerd.io_1.2.5-1_armhf.deb
sudo dpkg -i docker-ce-cli_18.09.5~3-0~debian-stretch_armhf.deb
sudo dpkg -i docker-ce_18.09.5~3-0~debian-stretch_armhf.deb

#install lvm
sudo apt install lvm2 -y

#create physical Volumne
sudo pycreate /dev/sda
#crteate vilume group name is data
sudo vgcreate data /dev/sda
# create logic volum
sudo lvcreate -L 4GB data -n owncloud

#mount 
sudo mkdir /mnt/owncloud
sudo mkfs.ext4 /dev/data/owncloud
sudo mkdir /mnt/owncloud
sudo mount /dev/data/owncloud /mnt/owncloud

#run
sudo docker run --name owncloud -d -p 8080:80 -v /mnt/owncloud:/var/www/html owncloud
#if you had ran once before
sudo docker start owncloud


## if you add more dik
#add disk
#pycreate /dev/sdb

#vgextend data /dev/sdb
#vgdisplay data#show how much total and left 
#lvresize -r -L +10GB /dev/data/owncloud


