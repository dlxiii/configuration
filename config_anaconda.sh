#!/bin/sh

export VERSION=5.3.1
export DATETIME=$(date '+%Y-%m-%d %H:%M:%S')
export PREFIX=/home/usr0/n70110d/usr/local/anaconda3

#wget -P /home/usr0/n70110d/downloads https://repo.anaconda.com/archive/Anaconda3-$VERSION-Linux-x86_64.sh

cd /home/usr0/n70110d/downloads
#mkdir -p '${PREFIX}'
bash ./Anaconda3-$VERSION-Linux-x86_64.sh -b -p ${PREFIX}/$VERSION

echo '# '$DATETIME': install the anaconda3, the path is:'>> ~/.bashrc
echo 'export PATH='$PREFIX'/'$VERSION'/bin:${PATH}'>> ~/.bashrc
echo 'alias apy3="'$PREFIX'/'$VERSION'/bin/python"'>> ~/.bashrc
echo ' '>> ~/.bashrc
source ~/.bashrc