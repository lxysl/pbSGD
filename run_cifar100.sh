python ./CIFAR100/main.py --optim Adam --arch resnext --lr 0.01   --gpu "$1" --wandb
python ./CIFAR100/main.py --optim Adam --arch resnext --lr 0.005  --gpu "$1" --wandb
python ./CIFAR100/main.py --optim Adam --arch resnext --lr 0.001  --gpu "$1" --wandb
python ./CIFAR100/main.py --optim Adam --arch resnext --lr 0.0005 --gpu "$1" --wandb
python ./CIFAR100/main.py --optim Adam --arch resnext --lr 0.0001 --gpu "$1" --wandb

python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.01   --gamma 0.2 --gpu "$1" --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.005  --gamma 0.2 --gpu "$1" --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.001  --gamma 0.2 --gpu "$1" --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.0005 --gamma 0.2 --gpu "$1" --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.0001 --gamma 0.2 --gpu "$1" --wandb

python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.01   --gamma 0.5 --gpu "$1" --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.005  --gamma 0.5 --gpu "$1" --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.001  --gamma 0.5 --gpu "$1" --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.0005 --gamma 0.5 --gpu "$1" --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.0001 --gamma 0.5 --gpu "$1" --wandb

python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.01   --gamma 0.8 --gpu "$1" --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.005  --gamma 0.8 --gpu "$1" --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.001  --gamma 0.8 --gpu "$1" --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.0005 --gamma 0.8 --gpu "$1" --wandb
python ./CIFAR100/main.py --optim pbAdam --arch resnext --lr 0.0001 --gamma 0.8 --gpu "$1" --wandb
