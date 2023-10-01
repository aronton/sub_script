sinfo

tSDRG_path="/home/aronton/tSDRG_random"

read -p "partition : " partition
scontrol show partition "scopion${partition}"
read -p "Number of core : " Ncore
read -p "count direction R/F : " direction
read -p "Spin : " Spin
read -p "BC : " BC
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
read -p "initial_Seed : " initial_Seed
read -p "checkRangeFinalSeed : " checkRangeFinalSeed
read -p "deltaSeed : " deltaSeed

now_time="$(date +'%Y_%m_%d_H%H_M%M_S%S')"
now_year="$(date +'%Y')"
now_month="$(date +'%m')"
now_day="$(date +'%d')"


if [ "$direction" == "R" ]
then
    echo -e "$now_time"
    checkDirection="Reverse"
    directoryPath="${tSDRG_path}/tSDRG/check/Spin$Spin/script/$now_month/$now_day"
    outputPath="${tSDRG_path}/tSDRG/check/Spin$Spin/output/$now_month/$now_day/Spin${Spin}_L${L1}_L${L2}_${space_L}_${J1}_${J2}_${space_J}_${D1}_${D2}_${space_D}_${BC}_${initial_Seed}_${checkRangeFinalSeed}.out"
    outputDir="${tSDRG_path}/tSDRG/check/Spin$Spin/output/$now_month/$now_day/"
    scriptPath="${tSDRG_path}/tSDRG/check/Spin$Spin/script/$now_month/$now_day/check$checkDirection"_"$now_time.sh"
    # checkDirection="Reverse"
    # directoryPath="/home/aronton/tSDRG_random/tSDRG/Sub_script/check/Spin$Spin/script/$now_month/$now_day"
    # outputPath="/home/aronton/tSDRG_random/tSDRG/Sub_script/check/Spin$Spin/output/$now_month/$now_day/Spin${Spin}_L${L1}_L${L2}_${space_L}_${J1}_${J2}_${space_J}_${D1}_${D2}_${space_D}_${initial_Seed}_${checkRangeFinalSeed}.out"
    # outputDir="/home/aronton/tSDRG_random/tSDRG/Sub_script/check/Spin$Spin/output/$now_month/$now_day/"
    # scriptPath="/home/aronton/tSDRG_random/tSDRG/Sub_script/check/Spin$Spin/script/$now_month/$now_day/check$checkDirection"_"$now_time.sh"
    if [ -d "$directoryPath" ];
    then
        echo -e "$directoryPath"
    else
        echo -e "$directoryPath"
        echo -e "$scriptPath"
        mkdir -p "$directoryPath"
        # mkdir -p "$outputPath"
    fi

    if [ -d "$outputDir" ];
    then
        echo -e "$outputPath"
    else
        echo -e "$outputPath"
        mkdir -p "$outputDir"
    fi
    # cp /home/aronton/tSDRG_random/tSDRG/Sub_script/check/check$checkDirection.sh scriptPath
    cp ${tSDRG_path}/Sub_script/check/checkReverse.sh $scriptPath
    sed -e "s@scopion@scopion$partition@" -i $scriptPath
    sed -e "s@cpus-per-task@cpus-per-task=$Ncore@" -i $scriptPath
    sed -e "s@output@output=$outputPath@" -i $scriptPath
    # sed -e "s@BC@BC=$BC@" -i $scriptPath
    sbatch $scriptPath $Spin $BC $P $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $initial_Seed $checkRangeFinalSeed $deltaSeed

    
elif [ "$direction" == "D" ]
then
    direction="Forwarf"
    scriptName="${tSDRG_path}/tSDRG/check/check$direction$PBC.sh"
else
    sh ${tSDRG_path}/tSDRG/sub_check.sh $Spin $BC $P $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $initial_Seed $checkRangeFinalSeed $deltaSeed
fi
 

# sbatch /home/aronton/tSDRG_project/tSDRG/Sub_script/check/check$direction$PBC.sh