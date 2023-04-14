python ./CIFAR10/main.py --optim Adam --arch densenet121 --lr 0.01   --device "$1" --wandb
python ./CIFAR10/main.py --optim Adam --arch densenet121 --lr 0.005  --device "$1" --wandb
python ./CIFAR10/main.py --optim Adam --arch densenet121 --lr 0.001  --device "$1" --wandb
python ./CIFAR10/main.py --optim Adam --arch densenet121 --lr 0.0005 --device "$1" --wandb
python ./CIFAR10/main.py --optim Adam --arch densenet121 --lr 0.0001 --device "$1" --wandb

python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.01   --gamma 0.2 --device "$1" --wandb
python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.005  --gamma 0.2 --device "$1" --wandb
python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.001  --gamma 0.2 --device "$1" --wandb
python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.0005 --gamma 0.2 --device "$1" --wandb
python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.0001 --gamma 0.2 --device "$1" --wandb

python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.01   --gamma 0.5 --device "$1" --wandb
python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.005  --gamma 0.5 --device "$1" --wandb
python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.001  --gamma 0.5 --device "$1" --wandb
python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.0005 --gamma 0.5 --device "$1" --wandb
python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.0001 --gamma 0.5 --device "$1" --wandb

python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.01   --gamma 0.8 --device "$1" --wandb
python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.005  --gamma 0.8 --device "$1" --wandb
python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.001  --gamma 0.8 --device "$1" --wandb
python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.0005 --gamma 0.8 --device "$1" --wandb
python ./CIFAR10/main.py --optim pbAdam --arch densenet121 --lr 0.0001 --gamma 0.8 --device "$1" --wandb
