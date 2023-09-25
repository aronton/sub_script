sinfo

tSDRG_path="/home/aronton/tSDRG_random"

read -p "Spin : " Spin
read -p "partition : " partition
read -p "ProDis : " ProbDis
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
read -p "deltaSeed : " deltaSeed
read -p "BC : " BC
read -p "Ncore : " Ncore
read -p "check_Or_Not :" checkOrNot

echo -e "\nScancel By Job Name:\n\nSpin:"${Spin}"\n""ProDis:"${ProbDis}"\n""Chi:"${bonDim}"\n""L:"${L1}"~"${L2}"("${space_L}")\n""J:"${J1}"~"${J2}"("${space_J}")\n""D:"${D1}"~"${D2}"("${space_D}")\n""Ncore="${Ncore}"\nseed:"${s1}"~"${s2}"\npartition${partition}\n"

read -p "Continue or not?(Y/N) : " Continue

if [ "${Continue}" == "Y" ]
then
    nohup sh ${tSDRG_path}/tSDRG/Sub_script/scancel_and_resubmit.sh $Spin $ProbDis $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $s1 $s2 $deltaSeed $BC $Ncore $partition $checkOrNot &
else
    sh ${tSDRG_path}/Sub_script/tSDRG/scancel_and_resubmit.sh
fi