python ./ImageNet/main.py --arch resnet50 --optim Adam --lr 0.001 -p 100 --evaluate --wandb
python ./ImageNet/main.py --arch resnet50 --optim AdamW --lr 0.001 -p 100 --evaluate --wandb
python ./ImageNet/main.py --arch resnet50 --optim Lion --lr 0.001 -p 100 --evaluate --wandb
python ./ImageNet/main.py --arch resnet50 --optim SGDM --lr 0.1 -p 100 --evaluate --wandb

python ./ImageNet/main.py --arch resnet50 --optim pbAdam --lr 0.001 --gamma 0.8 -p 100 --evaluate --wandb
python ./ImageNet/main.py --arch resnet50 --optim pbAdamW --lr 0.001 --gamma 0.8 -p 100 --evaluate --wandb
python ./ImageNet/main.py --arch resnet50 --optim pbLion --lr 0.001 --gamma 0.8 -p 100 --evaluate --wandb


python ./ImageNet/main.py --arch resnet50 --optim Adam --lr 0.0001 -p 100 --evaluate --wandb
python ./ImageNet/main.py --arch resnet50 --optim AdamW --lr 0.0001 -p 100 --evaluate --wandb
python ./ImageNet/main.py --arch resnet50 --optim Lion --lr 0.0001 --weight_decay 1e-3 -p 100 --evaluate --wandb
python ./ImageNet/main.py --arch resnet50 --optim SGDM --lr 0.01 -p 100 --evaluate --wandb

python ./ImageNet/main.py --arch resnet50 --optim pbAdam --lr 0.0001 --gamma 0.5 -p 100 --evaluate --wandb
python ./ImageNet/main.py --arch resnet50 --optim pbAdamW --lr 0.0001 --gamma 0.5 -p 100 --evaluate --wandb
python ./ImageNet/main.py --arch resnet50 --optim pbLion --lr 0.0001 --weight_decay 1e-3 --gamma 0.5 -p 100 --evaluate --wandb

