#! /bin/bash
#SBATCH --partition=scopion
#SBATCH --ntasks=1
#SBATCH --cpus-per-task
#SBATCH --output

date

#sbatch $scriptPath $Spin $BC $P $bonDim $L1 $L2 $Lspace_L $J1 $J2 $Lspace_J $D1 $D2 $Lspace_D $initial_Seed $checkRangeFinalSeed $deltaSeed

# echo "partition         ==> ${1}"
# echo "Ncore         ==> ${2}"
echo "Spin         ==> ${1}"
echo "BC        ==> ${2}"
echo "P        ==> ${3}"
echo "bonDim        ==> ${4}"
echo "L1        ==> ${5}"
echo "L2        ==> ${6}"
echo "space_L        ==> ${7}"
echo "J1        ==> ${8}"
echo "J2        ==> ${9}"
echo "space_J        ==> ${10}"
echo "D1        ==> ${11}"
echo "D2        ==> ${12}"
echo "space_D        ==> ${13}"
echo "seed1        ==> ${14}"
echo "seed2        ==> ${15}"
echo "sInterval        ==> ${16}"
# echo "check_Or_Not        ==> ${19}"


# partition=$(echo "scale=0; (${1})/1" | bc)
# echo -e "partitio=$partition"

# Ncore=$(echo "scale=0; (${2})/1" | bc)
# echo -e "Ncore=$Ncore"

Spin=${1}
# Spin=$(echo "scale=0; (${1})/1" | bc)
echo -e "Spin=$Spin"

PBC=${2}
echo -e "PBC=$BC"

P=${3}
# P=$(echo "scale=0; (${3})/1" | bc)
echo -e "P=$P"

bonDim=${4}
# bonDim=$(echo "scale=0; (${4})/1" | bc)
echo -e "bonDim=$bonDim"
L1=${5}
# L1=$(echo "scale=0; (${5})/1" | bc)
echo -e "L1=$L1"
L2=${6}
# L2=$(echo "scale=0; (${6})/1" | bc)
echo -e "L2=$L2"
space_L=${7}
# space_L=$(echo "scale=0; (${7})/1" | bc)
echo -e "space_L=$space_L"

# J1=$(echo "scale=3; (${8})/1." | bc)
# echo -e "J1=$J1"
# J2=$(echo "scale=3; (${9})/1." | bc)
# echo -e "J2=$J2"
# space_J=$(echo "scale=3; (${10})/1." | bc)
# echo -e "space_J=$space_J"

# D1=$(echo "scale=3; (${11})/1." | bc)
# echo -e "D1=$D1"
# D2=$(echo "scale=3; (${12})/1." | bc)
# echo -e "D2=$D2"
# space_D=$(echo "scale=3; (${13})/1." | bc)
# echo -e "space_D=$space_D"

s1=${14}
# s1=$(echo "scale=0; (${14})/1" | bc)
echo -e "s1=$s1"
s2=${15}
# s2=$(echo "scale=0; (${15})/1" | bc)
echo -e "s2=$s2"
sInterval=${16}
echo -e "sInterval=$sInterval"




# sbatch $scriptPath $Spin $PBC $P $bonDim $L1 $L2 $Lspace_L $J1 $J2 $Lspace_J $D1 $D2 $Lspace_D $initial_Seed $checkRangeFinalSeed $deltaSeed


date
python /home/aronton/tSDRG_random/tSDRG/Sub_script/check/checkReverse.py $Spin $PBC $P $bonDim $L1 $L2 $space_L ${8} ${9} ${10} ${11} ${12} ${13} $s1 $s2 $sInterval
date