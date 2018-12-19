#!/bin/bash

export DATETIME=$(date "+%Y-%m-%d %H:%M:%S")
export APPDIR=$HOME/usr/local
export FILDIR=$HOME/downloads

# install netcdf
if [ -d $APPDIR/netcdf-3.6.3 ];then
	echo "netcdf-3.6.3 had been installed"
else
	cd $FILDIR
	tar -xzvf netcdf-3.6.3.tar.gz
	cd netcdf-3.6.3
	./configure --prefix=$APPDIR/netcdf-3.6.3 CC=icc CXX=icpc --enable-cxx CFLAGS=-O3 CXXFLAGS=-O3 FC=ifort F77=ifort F90=ifort --enable-fortran --enable-fortran2003 FFLAGS=-O3 CPP='icc -E' CXXCPP='icpc -E'
	make
	make check
	make install
	cd ..
	rm -rf netcdf-3.6.3
	
	echo '# '$DATETIME': install the netcdf-3.6.3, the path is:'>> ~/.bashrc
	echo 'export LD_LIBRARY_PATH='$APPDIR'/netcdf-3.6.3/lib:${LD_LIBRARY_PATH}'>> ~/.bashrc
	echo 'export PATH='$APPDIR'/netcdf-3.6.3/bin:${PATH}'>> ~/.bashrc
	echo ' '>> ~/.bashrc
	source ~/.bashrc
fi