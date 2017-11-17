# tensorflow

MARCC Installed Drivers at testing time were: K80 with 384.81 Driver.

Here's how to run it on MARCC systems:

Work with this job script `tensorflow_job.sh`:

```
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

# redefine SINGULARITY_HOME to mount current working directory to base $HOME
export SINGULARITY_HOME=$PWD:/home/$USER 

singularity exec -B $CUDA_DRIVER:/.singularity.d/libs/ ./tensorflow.simg python softmax_regression.py

```

Submit job: `sbatch tensorflow_job.sh`
