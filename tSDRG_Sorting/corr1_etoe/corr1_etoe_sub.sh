#!/bin/bash
#SBATCH --partition=scopion
#SBATCH --cpus-per-task
#SBATCH --output=/home/aronton/tSDRG_random/Sorting_data/Spin/slurm/fileName.out

# [ "$#" -lt 9 ] && echo "The number of parameter is less than 9.  Stop here." && exit 0
echo "spin         ==> ${1}"
echo "BC         ==> ${2}"
echo "probDis         ==> ${3}"
echo "chi        ==> ${4}"
echo "L        ==> ${5}"
echo "jdis         ==> ${6}"
echo "dim         ==> ${7}"
echo "initial_Seed         ==> ${8}"
echo "final_Seed        ==> ${9}"
# echo "s1        ==> ${10}"
# echo "s2        ==> ${11}"
# echo "Nseed        ==> ${12}"
# echo "Spin         ==> ${13}"


date
    python ./corr1_etoe/corr1_etoe_average_grasp.py ${1} ${2} ${3} ${4} ${5} ${6} ${7} ${8} ${9} 
echo -e "\ndone.\n\n"
date
