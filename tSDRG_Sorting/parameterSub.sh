read -p "SOP, ZL, bulk_corr, gap, corr_etoe, gap_max?(a,b,c,d,e,f) : " number
sinfo

tSDRG_path="/home/aronton/tSDRG_random"

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
read -p "is J plus(Y/M) ? : " Jminus

read -p "Init_D : " D1
read -p "Final_D : " D2
read -p "Space_D : " space_D
read -p "is D plus(Y/M) ? : " Dminus

read -p "seed1 : " s1
read -p "seed2 : " s2
read -p "Nseed : " Nseed
if [ ${number} == "e" ]
then
    BC="OBC"
else
    BC="PBC"
fi
# read -p "BC : " BC
read -p "dx : " dx
read -p "deltaSeed : " deltaSeed

# if [ ${orderparameter} == "bulk_corr"]

# echo "Partition:" ${partition} "Number of core:" ${cpuspertask} "Spin:${Spin}"";L:"${L1}"~" ${L2} "(" ${space_L} ")" ";J:" ${J1} "~" ${J2} "(" ${space_J} ")" ";D:" ${D1} "~" ${D2} "(" ${space_D} ")" ",seed1:" ${s1} ",seed2:" ${s2} "Orderparameter:" ${orderparameter}

# read -p "Continue or not (Y/N): " Continue

# nohup sh /home/aronton/tSDRG_project/Sorting_data/tSDRG_Sorting/${orderparameter}/Metasub_${orderparameter}.sh $orderparameter $partition $Ncore $Spin $P $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $s1 $s2 $Nseed $BC $deltaSeed&

if [ ${number} == "a" ]
then
    orderparameter="SOP"
    echo "Partition:" ${partition} "Number of core:" ${cpuspertask} "Spin:${Spin}"";L:"${L1}"~" ${L2} "(" ${space_L} ")" ";J:" ${J1} "~" ${J2} "(" ${space_J} ")" ";D:" ${D1} "~" ${D2} "(" ${space_D} ")" ",seed1:" ${s1} ",seed2:" ${s2} ",dx:" ${dx}, "Orderparameter:" ${orderparameter}, "Jminus:" ${Jminus}, "Dminus:" ${Dminus}

    read -p "Continue or not (Y/N): " Continue

    nohup sh ${tSDRG_path}/Sorting_data/tSDRG_Sorting/${orderparameter}/Metasub_${orderparameter}.sh $orderparameter $partition $Ncore $Spin $P $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $s1 $s2 $Nseed $BC $dx $deltaSeed $Jminus $Dminus $tSDRG_path&
elif [ ${number} ==  "b" ]
then
    orderparameter="ZL"
    echo "Partition:" ${partition} "Number of core:" ${cpuspertask} "Spin:${Spin}"";L:"${L1}"~" ${L2} "(" ${space_L} ")" ";J:" ${J1} "~" ${J2} "(" ${space_J} ")" ";D:" ${D1} "~" ${D2} "(" ${space_D} ")" ",seed1:" ${s1} ",seed2:" ${s2} "Orderparameter:" ${orderparameter}, "Jminus:" ${Jminus}, "Dminus:" ${Dminus}

    read -p "Continue or not (Y/N): " Continue

    nohup sh ${tSDRG_path}/Sorting_data/tSDRG_Sorting/${orderparameter}/Metasub_${orderparameter}.sh $orderparameter $partition $Ncore $Spin $P $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $s1 $s2 $Nseed $BC $deltaSeed $Jminus $Dminus $tSDRG_path&
elif [ ${number} == "c" ]
then
    orderparameter="bulk_corr"
    echo "Partition:" ${partition} "Number of core:" ${cpuspertask} "Spin:${Spin}"";L:"${L1}"~" ${L2} "(" ${space_L} ")" ";J:" ${J1} "~" ${J2} "(" ${space_J} ")" ";D:" ${D1} "~" ${D2} "(" ${space_D} ")" ",seed1:" ${s1} ",seed2:" ${s2} "Orderparameter:" ${orderparameter}, "Jminus:" ${Jminus}, "Dminus:" ${Dminus}

    read -p "Continue or not (Y/N): " Continue

    nohup sh ${tSDRG_path}/Sorting_data/tSDRG_Sorting/${orderparameter}/Metasub_${orderparameter}.sh $orderparameter $partition $Ncore $Spin $P $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $s1 $s2 $Nseed $BC $deltaSeed $dx $Jminus $Dminus $tSDRG_path&
elif [ ${number} == "d" ]
then
    orderparameter="gap"
    echo "Partition:" ${partition} "Number of core:" ${cpuspertask} "Spin:${Spin}"";L:"${L1}"~" ${L2} "(" ${space_L} ")" ";J:" ${J1} "~" ${J2} "(" ${space_J} ")" ";D:" ${D1} "~" ${D2} "(" ${space_D} ")" ",seed1:" ${s1} ",seed2:" ${s2} "Orderparameter:" ${orderparameter}, "Jminus:" ${Jminus}, "Dminus:" ${Dminus}

    read -p "Continue or not (Y/N): " Continue

    nohup sh ${tSDRG_path}/Sorting_data/tSDRG_Sorting/${orderparameter}/Metasub_${orderparameter}.sh $orderparameter $partition $Ncore $Spin $P $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $s1 $s2 $Nseed $BC $deltaSeed $dx $Jminus $Dminus $tSDRG_path&
elif [ ${number} == "e" ]
then
    orderparameter="corr1_etoe"
    echo "Partition:" ${partition} "Number of core:" ${cpuspertask} "Spin:${Spin}"";L:"${L1}"~" ${L2} "(" ${space_L} ")" ";J:" ${J1} "~" ${J2} "(" ${space_J} ")" ";D:" ${D1} "~" ${D2} "(" ${space_D} ")" ",seed1:" ${s1} ",seed2:" ${s2} "Orderparameter:" ${orderparameter}, "Jminus:" ${Jminus}, "Dminus:" ${Dminus}

    read -p "Continue or not (Y/N): " Continue

    nohup sh ${tSDRG_path}/Sorting_data/tSDRG_Sorting/${orderparameter}/Metasub_${orderparameter}.sh $orderparameter $partition $Ncore $Spin $P $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $s1 $s2 $Nseed $BC $deltaSeed $Jminus $Dminus $tSDRG_path&
elif [ ${number} == "f" ]
then
    orderparameter="gap_max"
    echo "Partition:" ${partition} "Number of core:" ${cpuspertask} "Spin:${Spin}"";L:"${L1}"~" ${L2} "(" ${space_L} ")" ";J:" ${J1} "~" ${J2} "(" ${space_J} ")" ";D:" ${D1} "~" ${D2} "(" ${space_D} ")" ",seed1:" ${s1} ",seed2:" ${s2} "Orderparameter:" ${orderparameter}, "Jminus:" ${Jminus}, "Dminus:" ${Dminus}

    read -p "Continue or not (Y/N): " Continue

    nohup sh ${tSDRG_path}/Sorting_data/tSDRG_Sorting/${orderparameter}/Metasub_${orderparameter}.sh $orderparameter $partition $Ncore $Spin $P $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $s1 $s2 $Nseed $BC $deltaSeed $dx $Jminus $Dminus $tSDRG_path&
fi
