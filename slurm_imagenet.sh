#!/bin/bash
#SBATCH --job-name=imagenet1
#SBATCH --output=imagenet1.out.%j
#SBATCH --error=vasp1.err.%j
#SBATCH --partition=gpu
#SBATCH --nodes=3
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH	--cpus-per-task=32
#SBATCH --comment=hustHAIL

echo "Activating conda environment..."
source ~/.bashrc
source activate pt2

# echo "Setting Wandb API key..."
# export WANDB_API_KEY=42f4584252c42654c6dc375454d6cbbc098ddbc4

srun -s python ./ImageNet/main.py --arch resnet50 --optim Adam --lr 0.001 -p 100 --wandb -j 32
srun -s python ./ImageNet/main.py --arch resnet50 --optim pbAdam --lr 0.001 --gamma 0.8 -p 100 --wandb -j 32
srun -s python ./ImageNet/main.py --arch resnet50 --optim SGDM --lr 0.1 -p 100 --wandb -j 32

# sbatch -s slurm_imagenet.sh
