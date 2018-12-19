#!/bin/bash

export DATETIME=$(date "+%Y-%m-%d %H:%M:%S")
export FABMDIR=$HOME/tools/fabm/code
export GOTMDIR=$HOME/tools/gotm/code
export ERSEMDIR=$HOME/tools/ersem/code
export FABM_PREFIX=$HOME/tools/fabm/build/gotm
export GOTM_PREFIX=$HOME/tools/gotm/build
export COMPILER=ifort

# download fabm code
if [ -d $HOME/tools/fabm/build/gotm/models/gotm ];then
	echo "Step1: fabm had been downloaded and installed"
else
	git clone git://github.com/fabm-model/fabm.git $FABMDIR
	# setup and install for gotm environment
	mkdir -p $FABM_PREFIX && cd $FABM_PREFIX
	cmake $FABMDIR/src -DCMAKE_INSTALL_PREFIX=`pwd` -DFABM_EMBED_VERSION=ON -DCMAKE_Fortran_COMPILER=$COMPILER
	make install
fi

# download ersem code
if [ -d $ERSEMDIR/src ];then
	echo "Step2: ersem had been downloaded"
else
	git clone git@gitlab.ecosystem-modelling.pml.ac.uk:stable/ersem.git $ERSEMDIR
  git clone git@gitlab.ecosystem-modelling.pml.ac.uk:stable/gotm-fabm-ersem-configurations.git /home/usr0/n70110d/tools/ersem/gfe_configurations
fi

# download gotm code
if [ -f $HOME/tools/gotm/build/gotm ];then
	echo "gotm had been downloaded and installed"
else
	git clone git://github.com/gotm-model/code.git $GOTMDIR
	# setup and install for fabm-gotm-ersem environment
	mkdir -p $GOTM_PREFIX && cd $GOTM_PREFIX
	cmake $GOTMDIR/src -DCMAKE_INSTALL_PREFIX=`pwd` -DFABM_BASE=$FABMDIR -DFABM_ERSEM_BASE=$ERSEMDIR -DCMAKE_Fortran_COMPILER=$COMPILER
	make install
	echo ' '>> ~/.bashrc
	echo '# '$DATETIME': add gotm in fabm-gotm-ersem environment to the path'>> ~/.bashrc
  echo 'export PATH="$HOME/tools/gotm/build:$PATH"'>> ~/.bashrc
	echo ' '>> ~/.bashrc
  source ~/.bashrc
fi

#download gotm case file
if [ -d $HOME/tools/gotm/cases ];then
	echo "gotm case file had been downloaded and installed"
else
	git clone git://github.com/gotm-model/cases.git $HOME/tools/gotm/cases
	cd $HOME/downloads
	pip2 install xmlplot --upgrade --user
	pip2 install xmlstore --upgrade --user
	pip2 install editscenario --upgrade --user
	pip install gotmgui-0.1.1-py2-none-any.whl --user
	cd $HOME/tools/gotm/cases
	make namelist
fi

