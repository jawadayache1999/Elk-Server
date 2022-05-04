#!/bin/bash


# Prints free memory on system and saves it to a  text file
free -h > ~/backups/freemem/free_mem.txt

# Prints disk usage and saves it to a text file
du -h > ~/backups/diskuse/disk_usage.txt

# Prints a list of all open files and saves it to a text file
lsof > ~/backups/openlist/open_list.txt

# Prints file system disk space statistics and saves it to a text file
df -h > ~/backups/freedisk/free_disk.txt 
