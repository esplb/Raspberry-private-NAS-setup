#update raspbian to latest
sudo apt update -y
sudo apt dist-upgrade -y

#install && start docker
sudo apt install docker -y
sudo systemctl enable docker
sudo service docker start

#install lvm
sudo apt install lvm2 -y


#insert Disk drives and create filesystem
#lsblk to check what disks are avaliable
lsblk
# may show something like below

###
#NAME                         MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
#sda                            8:0    1 14.9G  0 disk
#`-data-t1                    253:0    0   12G  0 lvm  /mnt/t1
#sdb                            8:16   1  3.7G  0 disk
#loop0                          7:0    0  100G  0 loop
#`-docker-179:7-288690-pool   253:1    0  100G  0 dm
#  `-docker-179:7-288690-base 253:2    0   10G  0 dm
#loop1                          7:1    0    2G  0 loop
#`-docker-179:7-288690-pool   253:1    0  100G  0 dm
#  `-docker-179:7-288690-base 253:2    0   10G  0 dm
#mmcblk0                      179:0    0 14.9G  0 disk
#|-mmcblk0p1                  179:1    0  1.1G  0 part
#|-mmcblk0p2                  179:2    0    1K  0 part
#|-mmcblk0p5                  179:5    0   32M  0 part /media/pi/SETTINGS1
#|-mmcblk0p6                  179:6    0   63M  0 part /boot
#`-mmcblk0p7                  179:7    0 13.6G  0 part /
####

#create physical Volumne
pycreate /dev/sda
#crteate vilume group name is data
vgcreate data /dev/sda
# create logic volum
lvcreate -L 4GB data -n owncloud

#mount 
mkdir /mnt/owncloud
mkfs.ext4 /dev/data/owncloud
mkdir /mnt/owncloud
mount /dev/data/owncloud /mnt/owncloud


#run
docker run --name owncloud -d -p 8080:80 -v /mnt/owncloud:/var/www/html/data
#open http://RAPBERRYPI_IP:8080 finish the admin name and password config

#if you had ran once before
#docker start owncloud

#add disk
#pycreate /dev/sdb

#vgextend data /dev/sdb
#vgdisplay data#show how much total and left 
#lvresize -r -L +10GB /dev/data/owncloud


