#!/bin/bash

export DATETIME=$(date "+%Y-%m-%d %H:%M:%S")

echo ' '>> ~/.bashrc
echo '# '$DATETIME': chang ethe display language from Japanese to English.'>> ~/.bashrc
echo 'export LANG="en_US.UTF-8"'>> ~/.bashrc

echo ' '>> ~/.bashrc
echo '# '$DATETIME': load module intel compiler automaticlly.'>> ~/.bashrc
echo 'module load intel/2018'>> ~/.bashrc

echo ' '>> ~/.bashrc
echo '# '$DATETIME': load module matlab2018 automaticlly.'>> ~/.bashrc
echo 'ulimit -v 20140000'>> ~/.bashrc
echo 'module load matlab/R2018a'>> ~/.bashrc

echo ' '>> ~/.bashrc
echo '# '$DATETIME': load module python automaticlly.'>> ~/.bashrc
echo '#module avail python'>> ~/.bashrc
echo 'module load python/3.6.2'>> ~/.bashrc
echo 'alias py3="/usr/local/python3.6.2/bin/python3.6"'>> ~/.bashrc
echo 'alias py2="/usr/bin/python2.7"'>> ~/.bashrc

echo ' '>> ~/.bashrc
echo '# '$DATETIME': load module netcdf automaticlly.'>> ~/.bashrc
echo 'module load netcdf/4.4.1.1'>> ~/.bashrc
echo '# コンパイル時： -I/home/app/a/NetCDF-4.4.1.1/include'>> ~/.bashrc
echo '# リンク時　　： -L/home/app/a/NetCDF-4.4.1.1/lib'>> ~/.bashrc
echo '##### EXAMPLE #####'>> ~/.bashrc
echo '#$ module load netcdf/4.4.1.1'>> ~/.bashrc
echo '#$ mpiifort sample.f90 \'>> ~/.bashrc
echo '#  -I/home/app/a/NetCDF-4.4.1.1/include \'>> ~/.bashrc
echo '#  -L/home/app/a/NetCDF-4.4.1.1/lib \'>> ~/.bashrc
echo '#  -lnetcdff'>> ~/.bashrc
echo '#$ mpiicc sample.c \'>> ~/.bashrc
echo '#  -I/home/app/a/NetCDF-4.4.1.1/include \'>> ~/.bashrc
echo '#  -L/home/app/a/NetCDF-4.4.1.1/lib \'>> ~/.bashrc
echo '#  -lnetcdf'>> ~/.bashrc

echo ' '>> ~/.bashrc
echo '# '$DATETIME': load module nkf automaticlly.'>> ~/.bashrc
echo 'module load nkf/2.1.4'>> ~/.bashrc
echo '##### EXAMPLE #####'>> ~/.bashrc
echo '#$ nkf -d -w -O in.txt out.txt'>> ~/.bashrc

echo ' '>> ~/.bashrc
echo '# '$DATETIME': add system root:'>> ~/.bashrc
echo 'export PATH="/home/usr0/n70110d/usr/local/bin:$PATH"'>> ~/.bashrc
echo ' '>> ~/.bashrc

source ~/.bashrc