python ./ImageNet/main.py --arch resnet50 --optim Adam --lr 0.001 -p 100 --wandb -j 16
python ./ImageNet/main.py --arch resnet50 --optim SGDM --lr 0.1 -p 100 --wandb -j 16
python ./ImageNet/main.py --arch resnet50 --optim pbAdam --lr 0.001 --gamma 0.8 -p 100 --wandb -j 16

python ./ImageNet/main.py --arch resnet50 --optim Adam --lr 0.0001 -p 100 --wandb -j 16
python ./ImageNet/main.py --arch resnet50 --optim SGDM --lr 0.01 -p 100 --wandb -j 16
python ./ImageNet/main.py --arch resnet50 --optim pbAdam --lr 0.0001 --gamma 0.8 -p 100 --wandb -j 16
