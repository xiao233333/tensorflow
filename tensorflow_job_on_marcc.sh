#!/bin/bash
#SBATCH -N 1
#SBATCH -n 6
#SBATCH -p gpu
#SBATCH --gres=gpu:1
#SBATCH -o tensorflow-%j.out
#SBATCH -t 1:0:0

module load cuda
module load singularity
module load tensorflow/1.10.1-gpu

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

python softmax_regression.py
