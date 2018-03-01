#!/bin/bash
#SBATCH -N 1
#SBATCH -n 6
#SBATCH -p gpu
#SBATCH --gres=gpu:1
#SBATCH -t 1:0:0

module load cuda/9.0 
module load singularity/2.4

# this works on MARCC, work on Lustre /scratch
mkdir -p /scratch/users/$USER/tensorflow_run
cd /scratch/users/$USER/tensorflow_run

# see this excellent reference: https://github.com/dsindex/tensorflow
wget -N https://raw.githubusercontent.com/dsindex/tensorflow/master/train_softmax.txt
wget -N https://raw.githubusercontent.com/dsindex/tensorflow/master/softmax_regression.py
wget -N http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz
wget -N http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz
wget -N http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz
wget -N http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz

singularity pull --name tensorflow.simg shub://marcc-hpc/tensorflow

# redefine SINGULARITY_HOME to mount current working directory to base $HOME
export SINGULARITY_HOME=$PWD:/home/$USER

singularity exec --nv ./tensorflow.simg python softmax_regression.py
