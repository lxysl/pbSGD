'''Train CIFAR10 with PyTorch.'''
from __future__ import print_function
import datetime

import numpy as np

import torch
import torch.nn as nn
import torch.optim as optim
import torch.nn.functional as F
import torch.backends.cudnn as cudnn

import torchvision
import torchvision.transforms as transforms

import os
import argparse
import collections

from models.resnet import ResNet50
from models.densenet import DenseNet121
from utils import get_lr, get_gamma

from pbSGD import *
from tensorboardX import SummaryWriter

import wandb

if torch.__version__ >= '2.0.0':
    torch.set_float32_matmul_precision('high')
history = collections.defaultdict(lambda: [])


def get_parser():
    parser = argparse.ArgumentParser(description='PyTorch CIFAR10 Training')
    parser.add_argument('--arch', default='resnet50', type=str, help='model arch')
    parser.add_argument('--optim', default='SGDM', type=str, help='train optimizer',
                        choices=['SGD', 'SGDM', 'Adam', 'RMSprop', 'Adagrad', 'pbAMSGrad',
                        'pbSGD', 'pbSGDM', 'Adamax', 'AMSGrad', 'pbAdam', 'pbAdam2', 'pbAdam3',
                        'AdamW', 'pbAdamW', 'pbAdamW2', 'Lion', 'pbLion', 'pbLion2'])
    parser.add_argument('--lr', default=0.1, type=float, help='learning rate')
    parser.add_argument('--gamma', default=0.8, type=float, help='control pb value')
    parser.add_argument('--momentum', default=0., type=float, help='pbSGD momentum')
    parser.add_argument('--batch-size', default=128, type=int, help='select batch size')
    parser.add_argument('--weight_decay', default=5e-4, type=float,help='weight decay for optimizers')
    parser.add_argument('--device', default='0', type=str, help='setu GPU device ID')
    parser.add_argument('--epoch', default=160, type=int, help='train epoch nums')
    parser.add_argument('--save-name', default=None, type=str, help='save history name')
    parser.add_argument('--wandb', action='store_true', help='use wandb')
    parser.add_argument('--comments', default='', type=str)

    args = parser.parse_args()
    return args


def build_dataset():
    # Data
    print('\n==> Preparing data..')
    transform_train = transforms.Compose([
        transforms.RandomCrop(32, padding=4),
        transforms.RandomHorizontalFlip(),
        transforms.ToTensor(),
        transforms.Normalize((0.4914, 0.4822, 0.4465), (0.2023, 0.1994, 0.2010)),
    ])

    transform_test = transforms.Compose([
        transforms.ToTensor(),
        transforms.Normalize((0.4914, 0.4822, 0.4465), (0.2023, 0.1994, 0.2010)),
    ])

    trainset = torchvision.datasets.CIFAR10(root='./data', train=True, download=True, transform=transform_train)
    trainloader = torch.utils.data.DataLoader(trainset, batch_size=args.batch_size, shuffle=True, num_workers=2)

    testset = torchvision.datasets.CIFAR10(root='./data', train=False, download=True, transform=transform_test)
    testloader = torch.utils.data.DataLoader(testset, batch_size=args.batch_size, shuffle=False, num_workers=2)

    classes = ('plane', 'car', 'bird', 'cat', 'deer', 'dog', 'frog', 'horse', 'ship', 'truck')

    return trainloader, testloader


def get_optimizer(args, net):
    if args.optim == 'SGDM':
        return optim.SGD(net.parameters(), lr=args.lr, momentum=0.9, weight_decay=args.weight_decay)
    if args.optim == 'SGD':
        return optim.SGD(net.parameters(), lr=args.lr, weight_decay=args.weight_decay)
    elif args.optim == 'Adam':
        return optim.Adam(net.parameters(), lr=args.lr, weight_decay=args.weight_decay)
    elif args.optim == 'RMSprop':
        return optim.RMSprop(net.parameters(), lr=args.lr, weight_decay=args.weight_decay)
    elif args.optim == 'Adagrad':
        return optim.Adagrad(net.parameters(), lr=args.lr, weight_decay=args.weight_decay)
    elif args.optim == 'pbSGD':
        return pbSGD(net.parameters(), lr=args.lr, gamma=args.gamma, weight_decay=args.weight_decay)
    elif args.optim == 'pbSGDM':
        return pbSGD(net.parameters(), lr=args.lr, gamma=args.gamma, momentum=args.momentum, weight_decay=args.weight_decay)
    elif args.optim == 'Adamax':
        return optim.Adamax(net.parameters(), lr=args.lr, weight_decay=args.weight_decay)
    elif args.optim == 'AMSGrad':
        return optim.Adam(net.parameters(), lr=args.lr, weight_decay=args.weight_decay, amsgrad=True)
    elif args.optim == 'pbAdam':
        return pbAdam(net.parameters(), lr=args.lr, gamma=args.gamma, weight_decay=args.weight_decay)
    elif args.optim == 'pbAdam2':
        return pbAdam2(net.parameters(), lr=args.lr, gamma=args.gamma, weight_decay=args.weight_decay)
    elif args.optim == 'pbAdam3':
        return pbAdam3(net.parameters(), lr=args.lr, gamma=args.gamma, weight_decay=args.weight_decay)
    elif args.optim == 'pbAMSGrad':
        return pbAdam(net.parameters(), lr=args.lr, gamma=args.gamma, weight_decay=args.weight_decay, amsgrad=True)
    elif args.optim == 'AdamW':
        return optim.AdamW(net.parameters(), lr=args.lr, weight_decay=args.weight_decay)
    elif args.optim == 'pbAdamW':
        return pbAdamW(net.parameters(), lr=args.lr, gamma=args.gamma, weight_decay=args.weight_decay)
    elif args.optim == 'pbAdamW2':
        return pbAdamW2(net.parameters(), lr=args.lr, gamma=args.gamma, weight_decay=args.weight_decay)
    elif args.optim == 'Lion':
        return Lion(net.parameters(), lr=args.lr, weight_decay=args.weight_decay)
    elif args.optim == 'pbLion':
        return pbLion(net.parameters(), lr=args.lr, gamma=args.gamma, weight_decay=args.weight_decay)
    elif args.optim == 'pbLion2':
        return pbLion2(net.parameters(), lr=args.lr, gamma=args.gamma, weight_decay=args.weight_decay)


def build_model():
    # Model
    print('\n==> Building model..')
    # net = VGG('VGG19')
    # net = ResNet50()
    # net = PreActResNet18()
    # net = GoogLeNet()
    # net = DenseNet121()
    # net = ResNeXt29_2x64d()
    # net = MobileNet()
    # net = MobileNetV2()
    # net = DPN92()
    # net = ShuffleNetG2()
    # net = SENet18()
    # net = ShuffleNetV2(1)

    if args.arch == 'resnet50':
        net = ResNet50()
    elif args.arch == 'densenet121':
        net = DenseNet121()

    print('Select Model {} ...'.format(args.arch))

    net = net.to(device)
    if device == 'cuda':
        cudnn.benchmark = True

    return net


# Training
def train(epoch):
    print(f'\nEpoch: {epoch + 1} / {args.epoch}')
    print('Learning rate: %.5f' % get_lr(optimizer))

    net.train()
    train_loss = 0
    correct = 0
    total = 0
    for batch_idx, (inputs, targets) in enumerate(trainloader):
        inputs, targets = inputs.to(device), targets.to(device)
        optimizer.zero_grad()
        outputs = net(inputs)
        loss = criterion(outputs, targets)
        loss.backward()
        optimizer.step()

        train_loss += loss.item()
        _, predicted = outputs.max(1)
        total += targets.size(0)
        correct += predicted.eq(targets).sum().item()

    print('Train Loss: %.3f | Acc: %.3f%% (%d/%d)' % (train_loss/(batch_idx+1),
            100.*correct/total, correct, total))

    writer.add_scalar('train/loss', train_loss/(batch_idx+1), epoch)
    writer.add_scalar('train/acc', 100.*correct/total, epoch)

    if args.wandb:
        wandb.log({'train loss': train_loss/(batch_idx+1), 'train acc': 100.*correct/total}, step=epoch)


def test(epoch):
    global best_acc
    net.eval()
    test_loss = 0
    correct = 0
    total = 0
    with torch.no_grad():
        for batch_idx, (inputs, targets) in enumerate(testloader):
            inputs, targets = inputs.to(device), targets.to(device)
            outputs = net(inputs)
            loss = criterion(outputs, targets)

            test_loss += loss.item()
            _, predicted = outputs.max(1)
            total += targets.size(0)
            correct += predicted.eq(targets).sum().item()

    print('Test Loss: %.3f | Acc: %.3f%% (%d/%d)' % (test_loss/(batch_idx+1), 100.*correct/total, correct, total))

    writer.add_scalar('val/loss', test_loss/(batch_idx+1), epoch)
    writer.add_scalar('val/acc', 100.*correct/total, epoch)

    if args.wandb:
        wandb.log({'val loss': test_loss/(batch_idx+1), 'val acc': 100.*correct/total}, step=epoch)


def adjust_learning_rate(optimizer, epoch):
    if epoch < 60:
        lr = args.lr
    elif epoch < 130:
        lr = args.lr * 0.1
    else:
        lr = args.lr * (1 / epoch)
    for param_group in optimizer.param_groups:
        param_group['lr'] = lr


best_acc = 0  # best test accuracy
start_epoch = 0  # start from epoch 0 or last checkpoint epoch

args = get_parser()

device = torch.device("cuda:{}".format(args.device)) if torch.cuda.is_available() else torch.device("cpu")
# os.environ['CUDA_VISIBLE_DEVICES'] = args.device

if args.save_name:
    name = args.save_name
elif 'pb' not in args.optim:
    name = '{}_lr={}'.format(args.optim, args.lr)
else:
    name = '{}_lr={}_gamma={}'.format(args.optim, args.lr, args.gamma)

writer = SummaryWriter('runs/{}'.format(name))

cur_time = datetime.datetime.now().strftime('%Y%m%d-%H%M%S')
if args.wandb:
    wandb.init(project="pbAdam", name=cur_time, config=vars(args))
    print(vars(args))

trainloader, testloader = build_dataset()

net = build_model()

if torch.__version__ >= '2.0.0':
    net = torch.compile(net)

criterion = nn.CrossEntropyLoss()

optimizer = get_optimizer(args, net)

step_decay = optim.lr_scheduler.StepLR(optimizer, step_size=60, gamma=0.1)

for epoch in range(start_epoch, start_epoch + args.epoch):
    step_decay.step()
    # adjust_learning_rate(optimizer, epoch)
    train(epoch)
    test(epoch)

writer.close()

print('\n==> Save History Complete\n')

if args.wandb:
    wandb.finish()
