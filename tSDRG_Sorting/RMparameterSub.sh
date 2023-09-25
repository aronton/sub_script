read -p "SOP, ZL, bulk_corr?(Oz,ZL,bulk_corr) : " orderparameter
sinfo
read -p "partition : " partition
scontrol show partition "scopion${partition}"
read -p "Number of core : " Ncore
read -p "Spin : " Spin
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
read -p "BC : " BC
read -p "deltaSeed : " deltaSeed

echo "RM_empty:Partition:" ${partition} "Number of core:" ${cpuspertask} "Spin:${Spin}"";L:"${L1}"~" ${L2} "(" ${space_L} ")" ";J:" ${J1} "~" ${J2} "(" ${space_J} ")" ";D:" ${D1} "~" ${D2} "(" ${space_D} ")" "Orderparameter:" ${orderparameter}

read -p "Continue or not (Y/N): " Continue

nohup sh /home/aronton/tSDRG_project/Sorting_data/tSDRG_Sorting/rm_empty/rm_empty.sh $orderparameter $partition $Ncore $Spin $P $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $BC $deltaSeed&
