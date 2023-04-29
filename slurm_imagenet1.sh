#!/bin/bash
#SBATCH --job-name=imagenet1
#SBATCH --output=imagenet1.out.%j
#SBATCH --error=vasp1.err.%j
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH	--cpus-per-task=32
#SBATCH --comment=hustHAIL

echo "Activating conda environment..."
source ~/.bashrc
source activate pt2

# echo "Setting Wandb API key..."
# export WANDB_API_KEY=42f4584252c42654c6dc375454d6cbbc098ddbc4

python ./ImageNet/main.py --arch resnet50 --optim Adam --lr 0.001 -p 100 --wandb -j 32

# sbatch -s slurm_imagenet.sh
# print(, flush=True)
