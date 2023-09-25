#!/bin/bash
#SBATCH --partition=scopion
#SBATCH --ntasks=1
#SBATCH --job-name=example_random
#SBATCH --cpus-per-task
#SBATCH --output=tSDRG_path/tSDRG/Main/jobRecord/slurmOutput/fileName_random.out

date

echo -e "current dir:"
pwd

get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     # While $SOURCE is a symlink, resolve it
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          # If $SOURCE was a relative symlink (so no "/" as prefix, need to resolve it relative to the symlink base directory
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
     echo "$DIR"
}

echo "script_directory"
echo "$(get_script_dir)"

#echo "The script name is        ==> ${0}"
#echo "Total parameter number is ==> $#"

#/home/aronton/tSDRG_random/tSDRG/Main/jobRecord/slurmOutput/fileName_random.out


# [ "$#" -lt 8 ] && echo "The number of parameter is less than 8.  Stop here." && exit 0

#echo "Your whole parameter is   ==> '$@'"
echo "L         ==> ${1}"
echo "J         ==> ${2}"
echo "D         ==> ${3}"
echo "P        ==> ${4}"
echo "s1        ==> ${5}"
echo "s2        ==> ${6}"
echo "spin        ==> ${7}"
echo "bonDim        ==> ${8}"
echo "BC        ==> ${9}"
echo "Ncore        ==> ${10}"

# ${L} ${J} ${D} ${localS1} ${localS2} ${Spin} ${bonDim} ${BC} ${Ncore} ${CheckOrNot}

L=${1}

P=${4}

s1=${5}

s2=${6}

spin=${7}

bonDim=${8}

BC=${9}

Ncore=${10}

CheckOrNot=${11}


echo "tSDRG_pathm/tSDRG/Main/Spin${spin}_ran.exe ${L} ${bonDim} ${P} ${2} ${3} ${BC} ${s1} ${s2} ${CheckOrNot}"
#sbatch ./spin15.exe ${1} 30 10 ${2} ${3} PBC ${4} ${5}
# date >> /home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/running
# echo "L:", ${1}, ",J:", ${2}, ",D:", ${3}, ",seed1:", ${4}, ",seed2:", ${5} >> /home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/running
tSDRG_path/tSDRG/Main/Spin${spin}_ran.exe ${L} ${bonDim} ${P} ${2} ${3} ${BC} ${s1} ${s2} ${CheckOrNot}

date

# ${L} ${J} ${D} ${localS1} ${localS2} ${Spin} ${bonDim} ${BC} ${Ncore} ${CheckOrNot}