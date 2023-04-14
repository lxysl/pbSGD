python ./CIFAR100/main.py --optim Adam --arch resnext --lr 0.01   --wandb
python ./CIFAR100/main.py --optim Adam --arch resnext --lr 0.005  --wandb
python ./CIFAR100/main.py --optim Adam --arch resnext --lr 0.001  --wandb
python ./CIFAR100/main.py --optim Adam --arch resnext --lr 0.0005 --wandb
python ./CIFAR100/main.py --optim Adam --arch resnext --lr 0.0001 --wandb

python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.01   --gamma 0.2 --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.005  --gamma 0.2 --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.001  --gamma 0.2 --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.0005 --gamma 0.2 --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.0001 --gamma 0.2 --wandb

python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.01   --gamma 0.5 --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.005  --gamma 0.5 --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.001  --gamma 0.5 --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.0005 --gamma 0.5 --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.0001 --gamma 0.5 --wandb

python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.01   --gamma 0.8 --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.005  --gamma 0.8 --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.001  --gamma 0.8 --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.0005 --gamma 0.8 --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.0001 --gamma 0.8 --wandb
