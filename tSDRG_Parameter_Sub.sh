#!/bin/bash

sinfo

tSDRG_path="/home/aronton/tSDRG_random"

for i in {1..4};
do
    echo "scopion${i}"

    a=$(squeue -p scopion${i} -o "%%.10i %%.10P %%.76j %%.8u%%.8T%%.15M" | grep -o "RUNNING")
    Na=$(echo "${a}" | grep -c RUNNING)
    echo "RUNNING:${Na}"


    b=$(squeue -p scopion${i} -o "%%.10i %%.10P %%.76j %%.8u%%.8T%%.15M" | grep -o "PENDING")
    Nb=$(echo "${b}" | grep -c PENDING)
    echo "PENDING:${Nb}"
    echo ""
done


read -p "partition : " partition
scontrol show partition "scopion${partition}"
read -p "Number of core : " Ncore
read -p "Spin : " Spin
if [ "${Spin}" != "${1}" ] 
then
    echo -e "Spin key in is inconsistent, please resubmit"
    sh ~/aronton_script.sh
fi
read -p "ProDis : " P
read -p "BonDim : " bonDim
read -p "Init_L : " L1
read -p "Final_L : " L2
read -p "Space_L : " space_L
read -p "Init_J : " J1
read -p "Final_J : " J2
read -p "Space_J : " space_J
read -p "Init_D : " D1
read -p "Final_D : " D2
read -p "Space_D : " space_D
read -p "Init seed : " s1
read -p "Final seed : " s2
read -p "delta seed : " ds
read -p "BC :" BC
read -p "check_Or_Not :" checkOrNot


echo -e "\ntSDRG_Running_Parameter:\n\nSpin:"${Spin}"\n""BC:${BC}""\n""ProDis:"${P}"\n""Chi:"${bonDim}"\n""L:"${L1}"~"${L2}"("${space_L}")\n""J:"${J1}"~"${J2}"("${space_J}")\n""D:"${D1}"~"${D2}"("${space_D}")\n""seed:"${s1}"~"${s2}"(${ds})""\n""partion:scopion"${partition}"\n""cpu_per_task:"${Ncore}"\n"


read -p "Continue or not?(Y/N) : " Continue

if [ "${Continue}" == "Y" ]
then
    # nohup sh ./Sub_script/sub/sub.sh $partition $Ncore $Spin $P $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $s1 $s2 $ds $BC $checkOrNot >> a.txt

    nohup sh ${tSDRG_path}/tSDRG/Sub_script/sub/sub.sh $partition $Ncore $Spin $P $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $s1 $s2 $ds $BC $checkOrNot &
else
    sh ${tSDRG_path}/tSDRG/Sub_script/tSDRG_Parameter_Sub.sh
fi