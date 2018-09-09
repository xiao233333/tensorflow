# TensorFlow

[![https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg](https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg)](https://singularity-hub.org/collections/260)

TensorFlow Version: 1.10.1-gpu-py3

MARCC NVidia GPU and installed drivers at testing time were: K80 & 396.44.

Here is an example job script `tensorflow_job.sh` to run on MARCC systems:

```
#!/bin/bash
#SBATCH -N 1
#SBATCH -n 6
#SBATCH -p gpuk80
#SBATCH --gres=gpu:1
#SBATCH -o tensorflow-%j.out
#SBATCH -t 1:0:0

module load cuda
module load singularity

# this works on MARCC, work on Lustre /scratch
mkdir -p /scratch/users/$USER/tensorflow_run_py3
cd /scratch/users/$USER/tensorflow_run_py3

# see this excellent reference: https://github.com/dsindex/tensorflow
wget -N https://raw.githubusercontent.com/dsindex/tensorflow/master/train_softmax.txt
wget -N https://raw.githubusercontent.com/marcc-hpc/tensorflow/1.10.1-gpu-py3/softmax_regression.py
wget -N http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz
wget -N http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz
wget -N http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz
wget -N http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz

singularity pull --name tensorflow.simg shub://marcc-hpc/tensorflow

# redefine SINGULARITY_HOME to mount current working directory to base $HOME
export SINGULARITY_HOME=$PWD:/home/$USER

singularity exec --nv ./tensorflow.simg python softmax_regression.py
```

Download this file: `wget https://raw.githubusercontent.com/marcc-hpc/tensorflow/1.10.1-gpu-py3/tensorflow_job.sh`
Submit job: `sbatch tensorflow_job.sh`

```
#!/bin/bash
#SBATCH -N 1
#SBATCH -n 6
#SBATCH -p gpuk80
#SBATCH --gres=gpu:1
#SBATCH -o tensorflow-%j.out
#SBATCH -t 1:0:0

module load cuda
module load singularity
module load tensorflow/1.10.1-gpu-py3

# this works on MARCC, work on Lustre /scratch
mkdir -p /scratch/users/$USER/tensorflow_run_py3
cd /scratch/users/$USER/tensorflow_run_py3

# see this excellent reference: https://github.com/dsindex/tensorflow
wget -N https://raw.githubusercontent.com/dsindex/tensorflow/master/train_softmax.txt
wget -N https://raw.githubusercontent.com/marcc-hpc/tensorflow/1.10.1-gpu-py3/softmax_regression.py
wget -N http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz
wget -N http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz
wget -N http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz
wget -N http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz

python3 softmax_regression.py
```

Download this file: `wget https://raw.githubusercontent.com/marcc-hpc/tensorflow/1.10.1-gpu-py3/tensorflow_job_on_marcc.sh`

Submit job: `sbatch tensorflow_job_on_marcc.sh`
