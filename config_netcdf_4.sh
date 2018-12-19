#!/bin/bash

export DATETIME=$(date "+%Y-%m-%d %H:%M:%S")
export APPDIR=$HOME/usr/local
export FILDIR=$HOME/downloads

# install and setup zlib
if [ -d $APPDIR/zlib-1.2.11 ];then
	echo "zlib had been installed"
else
	cd $FILDIR
	tar -xzvf zlib-1.2.11.tar.gz
	cd zlib-1.2.11
	./configure --prefix=$APPDIR/zlib-1.2.11
	make
	make check
	make install
	cd ..
	rm -rf zlib-1.2.11
fi

# install and setup hdf5
if [ -d $APPDIR/hdf-1.8.20 ];then
	echo "hdf5 had been installed"
else
	cd $FILDIR
	tar -xzvf hdf5-1.8.20.tar.gz
	cd hdf5-1.8.20
	./configure --prefix=$APPDIR/hdf-1.8.20 --with-zlib=$APPDIR/zlib-1.2.11 CC=icc CXX=icpc --enable-cxx CFLAGS=-O3 CXXFLAGS=-O3 FC=ifort F77=ifort F90=ifort --enable-fortran --enable-fortran2003 FFLAGS=-O3 CPP='icc -E' CXXCPP='icpc -E'
	make
	make check
	make install
	cd ..
	rm -rf hdf5-1.8.20
fi

# install and setup curl
if [ -d $APPDIR/curl-7.60.0 ];then
	echo "curl had been installed"
else
	cd $FILDIR
	tar -xzvf curl-7.60.0.tar.gz
	cd curl-7.60.0
	./configure --prefix=$APPDIR/curl-7.60.0 --with-zlib=$APPDIR/zlib-1.2.11
	make
	make install
	cd ..
	rm -rf curl-7.60.0
fi

# install gnu m4
if [ -d $APPDIR/m4-1.4.18 ];then
	echo "gnu_m4 had been installed"
else
	cd $FILDIR
	tar -xzvf m4-1.4.18.tar.gz
	cd m4-1.4.18
	./configure --prefix=$APPDIR/m4-1.4.18
	make
	make install
	cd ..
	rm -rf m4-1.4.18

	echo '# '$DATETIME': install the m4-1.4.18, the path is:'>> ~/.bashrc
	echo 'export PATH="/home/usr0/n70110d/usr/local/m4-1.4.18/bin:$PATH"' >> ~/.bashrc
	echo ' '>> ~/.bashrc
	source ~/.bashrc
fi

# install netcdf-c
if [ -d $APPDIR/netcdf-4.6.1 ];then
	echo "netcdf-c had been installed"
else
	cd $FILDIR
	tar -xzvf netcdf-c-4.6.1.tar.gz
	cd netcdf-c-4.6.1
	CPPFLAGS=-I/home/usr0/n70110d/usr/local/hdf-1.8.20/include LDFLAGS=-L/home/usr0/n70110d/usr/local/hdf-1.8.20/lib ./configure --prefix=$APPDIR/netcdf-4.6.1 --with-zlib=$APPDIR/zlib-1.2.11 CC=icc CXX=icpc --enable-cxx CFLAGS=-O3 CXXFLAGS=-O3 FC=ifort F77=ifort F90=ifort --enable-fortran --enable-fortran2003 FFLAGS=-O3 CPP='icc -E' CXXCPP='icpc -E'  --disable-netcdf-4 --disable-dap
	make
	make check
	make install
	cd ..
	rm -rf netcdf-c-4.6.1
	
	echo '# '$DATETIME': install the netcdf-4.6.1, the path is:'>> ~/.bashrc
	echo 'export LD_LIBRARY_PATH=/home/usr0/n70110d/usr/local/netcdf-4.6.1/lib:${LD_LIBRARY_PATH}'>> ~/.bashrc
	echo 'export PATH=/home/usr0/n70110d/usr/local/netcdf-4.6.1/bin:${PATH}'>> ~/.bashrc
	echo ' '>> ~/.bashrc
	source ~/.bashrc
fi

# install netcdf-fortran
if [ -d $APPDIR/netcdff-4.4.4 ];then
	echo "netcdf-fortran had been installed"
else
	cd $FILDIR
	tar -xzvf netcdf-fortran-4.4.4.tar.gz
	cd netcdf-fortran-4.4.4
	CPPFLAGS=-I/home/usr0/n70110d/usr/local/netcdf-4.6.1/include LDFLAGS=-L/home/usr0/n70110d/usr/local/netcdf-4.6.1/lib ./configure --prefix=$APPDIR/netcdff-4.4.4 CC=icc CXX=icpc CFLAGS=-O3 CXXFLAGS=-O3 FC=ifort F77=ifort F90=ifort FFLAGS=-O3 CPP='icc -E' CXXCPP='icpc -E'
	make
	make check
	make install
	cd ..
	rm -rf netcdf-fortran-4.4.4

	echo '# '$DATETIME': install the netcdff-4.4.4, the path is:'>> ~/.bashrc
	echo 'export LD_LIBRARY_PATH=/home/usr0/n70110d/usr/local/netcdff-4.4.4/lib:${LD_LIBRARY_PATH}'>> ~/.bashrc
	echo 'export PATH=/home/usr0/n70110d/usr/local/netcdff-4.4.4/bin:${PATH}'>> ~/.bashrc
	echo ' '>> ~/.bashrc
	source ~/.bashrc
fi
