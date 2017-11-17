#!/bin/bash
#SBATCH -N 1
#SBATCH -n 6
#SBATCH -p gpu
#SBATCH --gres=gpu:1
#SBATCH -t 1:0:0

module load cuda/9.0           # also locates matching $CUDA_DRIVER location
module load singularity/2.4

wget -N https://raw.githubusercontent.com/dsindex/tensorflow/master/train_softmax.txt
wget -N https://raw.githubusercontent.com/dsindex/tensorflow/master/softmax_regression.py
wget -N http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz
wget -N http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz
wget -N http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz
wget -N http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz

singularity pull --name tensorflow shub://marcc-hpc/tensorflow
