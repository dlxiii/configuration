#!/bin/bash
#PJM -L "rscunit=ito-a"
#PJM -L "rscgrp=ito-g-16-dbg"
#PJM -L "vnode=4"
#PJM -L "vnode-core=36"
#PJM -L "elapse=10:00"
#PJM -j
#PJM -X

cd fvcom4.1//Examples/Estuary/run
ln -s ../../../FVCOM_source/fvcom

#NUM_NODES=$PJM_VNODES
NUM_CORES=36 
#NUM_PROCS=36 
 
#export I_MPI_PERHOST=$NUM_CORES
#export I_MPI_FABRICS=shm:ofa

#export I_MPI_HYDRA_BOOTSTRAP=rsh
#export I_MPI_HYDRA_BOOTSTRAP_EXEC=/bin/pjrsh
#export I_MPI_HYDRA_HOST_FILE=${PJM_O_NODEINF} 

export OMP_NUM_THREADS=$NUM_CORES

#mpiexec.hydra -n $NUM_PROCS ./fvcom --casename=tst
./fvcom --casename=tst