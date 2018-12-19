#!/bin/bash

export FILDIR=$HOME/downloads
export FABMDIR=$HOME/tools/fabm/code
export FABM_PREFIX=$HOME/tools/fabm/build/fvcom
export FVCOMDIR=$HOME/tools/fvcom4.1

# download fabm
if [ -d $HFABMDIR ];then
	echo "fabm had been downloaded"
else
	git clone git://github.com/fabm-model/fabm.git $FABMDIR
fi

# download fvcom from downloads folder
if [ -d $FVCOMDIR ];then
	echo "fvcom4.1 had been downloaded"
else
	mkdir $FVCOMDIR
	cd $FILDIR
	tar -xzvf fvcom4.1.tar.gz -C $FVCOMDIR
fi

# build fabm for fvcom
if [ -d $HOME/tools/fabm/build/fvcom/lib ]; then
	echo "fabm had been built for fvcom"
else
	mkdir -p $FABM_PREFIX && cd $FABM_PREFIX
	cmake $FABMDIR/src \
		-DFABM_HOST=fvcom \
		-DCMAKE_INSTALL_PREFIX=`pwd` \
		-DCMAKE_Fortran_COMPILER=ifort
		make install
fi

# app prepare for fvcom
if [ -f $HOME/usr/local/bin/makedepf90 ];then
	echo "makedepf90 had been downloaded"
else
	mkdir $HOME/usr/local/makedepf90
	git clone git://github.com/outpaddling/makedepf90.git $HOME/usr/local/makedepf90
	cd $HOME/usr/local/makedepf90
	make
	if [ -d $HOME/usr/local/bin ];then
		ln makedepf90 $HOME/usr/local/bin/makedepf90
	else
		mkdir $HOME/usr/local/bin
		ln makedepf90 $HOME/usr/local/bin/makedepf90
	fi
fi

# build fvcom to compile a test alone
if [ -f $FVCOMDIR/FVCOM_source/fvcom ];then
	echo "fvcom had been built"
else
	cd $FVCOMDIR/FVCOM_source
	#file * .F
	nkf -Lu --overwrite ice_albedo.F
	nkf -Lu --overwrite ice_coupling.F
	nkf -Lu --overwrite ice_domain.F
	nkf -Lu --overwrite ice_fileunits.F
	nkf -Lu --overwrite ice_grid.F
	nkf -Lu --overwrite ice_kinds_mod.F
	nkf -Lu --overwrite ice_model_size.F
	nkf -Lu --overwrite ice_scaling.F
	nkf -Lu --overwrite ice_state.F
	nkf -Lu --overwrite swmod3.F

	if [ -f make.inc ];then
		echo "make.inc exsist"
	else
		cp make.inc_example make.inc
	fi

	echo "Did you finish modifing 'TOPDIR', NetCDF and compiler info in 'make.inc'? [y/n]"
	read bool_1
	if [ $bool_1 == "y" ];then
		echo "Did you finish modifing 'makefile' in '/FVCOM_source/libs'? [y/n]"
		read bool_2
		if [ $bool_2 == "y" ];then
			cd $FVCOMDIR/FVCOM_source/libs
			make
			cd ..
			echo "Did you finish modifing 'mod_esmf_nesting.F' in '/FVCOM_source/makefile'? [y/n]"
			read bool_3
			if [ $bool_3 == "y" ];then
				make
			else
				echo "Please modify 'mod_esmf_nesting.F' in '/FVCOM_source/makefile'."
				exit
			fi
		else
			echo "Please modify 'makefile' in '/FVCOM_source/libs'."
			exit
		fi
	else
		echo "Please modify 'makefile' in '/FVCOM_source/libs'."
		exit
	fi
fi
