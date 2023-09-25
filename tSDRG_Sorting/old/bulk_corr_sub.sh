#!/bin/bash
#SBATCH --partition=scopion
#SBATCH --cpus-per-task
#SBATCH --output=/home/aronton/tSDRG_project/Sorting_data/Spin/slurm/bulk_corr/fileName.out

# [ "$#" -lt 9 ] && echo "The number of parameter is less than 9.  Stop here." && exit 0
echo "spin         ==> ${1}"
echo "BC         ==> ${2}"
echo "probDis         ==> ${3}"
echo "chi        ==> ${4}"
echo "L        ==> ${5}"
echo "jdis         ==> ${6}"
echo "dim         ==> ${7}"
echo "init_Seed         ==> ${8}"
echo "final_Seed        ==> ${9}"


date
    # python /home/aronton/tSDRG_project/Sorting_data/tSDRG_Sorting/bulk_corr/bulk_corr.py ${1} ${2} ${3} ${4} ${5} ${6} ${7} ${8} ${9}
    python ./bulk_corr.py ${1} ${2} ${3} ${4} ${5} ${6} ${7} ${8} ${9}
echo -e "\ndone.\n\n"
date


