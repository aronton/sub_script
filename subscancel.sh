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



echo -e "\nScancel By Job Name:\n\n"
echo -e "Spin:"${Spin}"\n"
echo -e "ProDis:"${ProbDis}"\n"
echo -e "Chi:"${bonDim}"\n"
echo -e "L:"${L1}"~"${L2}"("${space_L}")\n"
echo -e "J:"${J1}"~"${J2}"("${space_J}")\n"
echo -e "D:"${D1}"~"${D2}"("${space_D}")\n"
echo -e "Ncore="${Ncore}"\n"
echo -e "seed:"${s1}"~"${s2}"\n"
echo -e "partition${partition}\n"


read -p "Continue or not?(Y/N) : " Continue

if [ "${Continue}" == "Y" ]
then
    nohup sh ${tSDRG_path}/tSDRG/Sub_script/scancel.sh $Spin $ProbDis $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $s1 $s2 $deltaSeed $BC $Ncore $partition &
else
    sh ${tSDRG_path}/tSDRG/subscancel.sh
fi