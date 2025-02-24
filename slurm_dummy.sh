#!/bin/bash
#SBATCH --job-name=imagenet1
#SBATCH --output=imagenet1.out.%j
#SBATCH --error=vasp1.err.%j
#SBATCH --partition=iirmas-gpu
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH	--cpus-per-task=4
#SBATCH --comment=hustHAIL

echo "Activating conda environment..."
source activate pt2

echo "Setting Wandb API key..."
export WANDB_API_KEY=42f4584252c42654c6dc375454d6cbbc098ddbc4

srun python ./ImageNet/main.py --arch resnet50 --optim Adam --lr 0.001 -p 100 --dummy --epochs 1
srun python ./ImageNet/main.py --arch resnet50 --optim AdamW --lr 0.001 -p 100 --dummy --epochs 1
srun python ./ImageNet/main.py --arch resnet50 --optim Lion --lr 0.001 -p 100 --dummy --epochs 1
srun python ./ImageNet/main.py --arch resnet50 --optim SGDM --lr 0.1 -p 100 --dummy --epochs 1
