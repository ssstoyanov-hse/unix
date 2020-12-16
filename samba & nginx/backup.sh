#!/bin/bash
sudo mkdir /backup
sudo tar cf - /mnt/DISK1 | (cd /backup && tar xvf -)
