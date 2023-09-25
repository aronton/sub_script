date

echo "partition         ==> ${1}"
echo "Ncore         ==> ${2}"
echo "Spin         ==> ${3}"
echo "ProbDis        ==> ${4}"
echo "bonDim        ==> ${5}"
echo "L1        ==> ${6}"
echo "L2        ==> ${7}"
echo "space_L        ==> ${8}"
echo "J1        ==> ${9}"
echo "J2        ==> ${10}"
echo "space_J        ==> ${11}"
echo "D1        ==> ${12}"
echo "D2        ==> ${13}"
echo "space_D        ==> ${14}"
echo "seed1        ==> ${15}"
echo "seed2        ==> ${16}"
echo "sInterval        ==> ${17}"
echo "BC        ==> ${18}"
echo "check_Or_Not        ==> ${19}"


partition=$(echo "scale=0; (${1})/1" | bc)
echo -e "partitio=$partition"

Ncore=$(echo "scale=0; (${2})/1" | bc)
echo -e "Ncore=$Ncore"

Spin=$(echo "scale=0; (${3})/1" | bc)
echo -e "Spin=$Spin"

P=$(echo "scale=0; (${4})/1" | bc)
echo -e "P=$P"

bonDim=$(echo "scale=0; (${5})/1" | bc)
echo -e "bonDim=$bonDim"

L1=$(echo "scale=0; (${6})/1" | bc)
echo -e "L1=$L1"
L2=$(echo "scale=0; (${7})/1" | bc)
echo -e "L2=$L2"
space_L=$(echo "scale=0; (${8})/1" | bc)
echo -e "space_L=$space_L"

J1=$(echo "scale=3; (${9})/1." | bc)
echo -e "J1=$J1"
J2=$(echo "scale=3; (${10})/1." | bc)
echo -e "J2=$J2"
space_J=$(echo "scale=3; (${11})/1." | bc)
echo -e "space_J=$space_J"

D1=$(echo "scale=3; (${12})/1." | bc)
echo -e "D1=$D1"
D2=$(echo "scale=3; (${13})/1." | bc)
echo -e "D2=$D2"
space_D=$(echo "scale=3; (${14})/1." | bc)
echo -e "space_D=$space_D"

s1=$(echo "scale=0; (${15})/1" | bc)
echo -e "s1=$s1"
s2=$(echo "scale=0; (${16})/1" | bc)
echo -e "s2=$s2"
sInterval=$(echo "scale=0; (${17})/1" | bc)
echo -e "sInterval=$sInterval"

BC=${18}
echo -e "BC=$BC"

CheckOrNot=${19}
echo -e "Check_Or_Not=$CheckOrNot"

J1_100=$(echo "scale=0; 100*(${J1})/1" | bc)

if [ $J1_100 -lt 10 ]
then
    J1dis="Jdis00"$J1_100
elif [ $J1_100 -ge 10 ] && [ $J1_100 -lt 100 ]
then
    J1dis="Jdis0"$J1_100
else
    J1dis="Jdis"$J1_100
fi

J2_100=$(echo "scale=0; 100*(${J2})/1" | bc)

if [ $J2_100 -lt 10 ]
then
    J2dis="Jdis00"$J2_100
elif [ $J2_100 -ge 10 ] && [ $J2_100 -lt 100 ]
then
    J2dis="Jdis0"$J2_100
else
    J2dis="Jdis"$J2_100
fi

space_J_100=$(echo "scale=0; 100*(${space_J})/1" | bc)

if [ $space_J_100 -lt 10 ]
then
    space_Jdis="Jdis00"$space_J_100
elif [ $space_J_100 -ge 10 ] && [ $space_J_100 -lt 100 ]
then
    space_Jdis="Jdis0"$space_J_100
else
    space_Jdis="Jdis"$space_J_100
fi

D1_100=$(echo "scale=0; 100*(${D1})/1" | bc)

if [ $D1_100 -lt 10 ]
then
    dim1="dim00"$D1_100
elif [ $D1_100 -ge 10 ] && [ $D1_100 -lt 100 ]
then
    dim1="dim0"$D1_100
else
    dim1="dim"$D1_100
fi

D2_100=$(echo "scale=0; 100*(${D2})/1" | bc)

if [ $D2_100 -lt 10 ]
then
    dim2="dim00"$D2_100
elif [ $D2_100 -ge 10 ] && [ $D2_100 -lt 100 ]
then
    dim2="dim0"$D2_100
else
    dim2="dim"$D2_100
fi

space_D_100=$(echo "scale=0; 100*(${space_D})/1" | bc)

if [ $space_D_100 -lt 10 ]
then
    space_dim="dim00"$space_D_100
elif [ $space_D_100 -ge 10 ] && [ $space_D_100 -lt 100 ]
then
    space_dim="dim0"$space_D_100
else
    space_dim="dim"$space_D_100
fi

now_date="$(date +'%Y_%m_%d')/"

tSDRG_path="/home/aronton/tSDRG_random"

tSDRG_record="${tSDRG_path}/tSDRG/Main_${Spin}/submit_record/"

fileName="tSDRG_Spin="${Spin}";BC=${BC}"";P="${P}";B="${bonDim}";L="${L1}"_"${L2}"("${space_L}");J="${J1dis}"_"${J2dis}"("${space_J_100}");D="${dim1}"_"${dim2}"("${space_D_100}");seed1="${s1}"_seed2="${s2}";Partition="${partition}";Number_of_core="${Ncore}

fileDir=${tSDRG_record}${now_date}${fileName}"/"

if [ -d "${fileDir}" ]; then
    # 目錄 /path/to/dir 存在
    echo -e "${fileDir}"
else
    # 目錄 /path/to/dir 不存在
    echo -e "mkdir -p ""${fileDir}"
    mkdir -p "${fileDir}"
fi

file=${fileDir}${fileName}

echo -e "\n\ntSDRG_Spin="${Spin}";BC=${BC}"";P="${P}";B="${bonDim}";""\n""L="${L1}"_"${L2}"("${space_L}");""\n""J="${J1dis}"_"${J2dis}"("${space_J_100}");""\n""D="${dim1}"_"${dim2}"("${space_D_100}");""\n""seed1="${s1}"_seed2="${s2}";""\n""Partition="${partition}";Number_of_core="${Ncore}"\n\n" >> "${file}.txt"

echo -e "\n\ntSDRG_Spin="${Spin}";BC=${BC}"";P="${P}";B="${bonDim}";""\n""L="${L1}"_"${L2}"("${space_L}");""\n""J="${J1dis}"_"${J2dis}"("${space_J_100}");""\n""D="${dim1}"_"${dim2}"("${space_D_100}");""\n""seed1="${s1}"_seed2="${s2}";""\n""Partition="${partition}";Number_of_core="${Ncore}"\n\n"

date >> "${file}.txt"

if [ "${space_L}" == "0" ]
then
    t0=$(echo "${space_L}" | bc)
else
    t0=$(echo "(${L2}-${L1})/${space_L}" | bc)
fi

if [ "${space_J}" == "0" ]
then
    t1=$(echo "${space_J}" | bc)
else
    t1=$(echo "(${J2}-${J1})/${space_J}" | bc)
fi

if [ "${space_D}" == "0" ]
then
    t2=$(echo "${space_D}" | bc)
else
    t2=$(echo "(${D2}-${D1})/${space_D}" | bc)
fi

for (( l=0; l<=${t0}; l=l+1 ))
do
    L=$(echo "scale=3; ${L1}+${l}*${space_L}" | bc)

    echo "ooooooooooL_L=${L}_oooooooooo"
    echo -e "\n\noooooooooo_L=${L}_oooooooooo\n\n" >> "${file}.txt"

    # if [ -d "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}" ]; then
    #     # 目錄 /path/to/dir 存在
    #     echo -e "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}_ok" >> "${file}.txt"
    # else
    #     # 目錄 /path/to/dir 不存在
    #     echo -e "mkdir /home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}" >> "${file}.txt"
    #     mkdir "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}"
    # fi

    # if [ -d "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}" ]; then
    #     # 目錄 /path/to/dir 存在
    #     echo -e "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}_ok" >> "${file}.txt"
    # else
    #     # 目錄 /path/to/dir 不存在
    #     echo -e "mkdir /home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}" >> "${file}.txt"
    #     mkdir "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}"
    # fi

    # if [ -d "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/slurmOutput/${BC}/B${bonDim}/L${L}" ]; then
    #     # 目錄 /path/to/dir 存在
    #     echo -e "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/slurmOutput/${BC}/B${bonDim}/L${L}_ok" >> "${file}.txt"
    # else
    #     # 目錄 /path/to/dir 不存在
    #     echo -e "mkdir /home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/slurmOutput/${BC}/B${bonDim}/L${L}" >> "${file}.txt"
    #     mkdir "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/slurmOutput/${BC}/B${bonDim}/L${L}"
    # fi

        for (( j=0; j<=${t1}; j=j+1 ))
        do
                J=$(echo "scale=3; ${J1}+${j}*${space_J}" | bc)
                J_100=$(echo "scale=0; 100*(${J1}+${j}*${space_J})/1" | bc)

                if [ $J_100 -ge 0 ]
                then
                        if [ $J_100 -lt 10 ]
                        then
                            Jdis="Jdis00"$J_100
                        elif [ $J_100 -ge 10 ] && [ $J_100 -lt 100 ]
                        then
                            Jdis="Jdis0"$J_100
                        else
                            Jdis="Jdis"$J_100
                        fi
                else
                        J_100=$(echo "scale=0; ${J_100}*(-1)" | bc)
                        if [ $J_100 -lt 10 ]
                        then
                            Jdis="JdisN00"$J_100
                        elif [ $J_100 -ge 10 ] && [ $J_100 -lt 100 ]
                        then
                            Jdis="JdisN0"$J_100
                        else
                            Jdis="JdisN"$J_100
                        fi     
                fi


                # if [$J_100 -ge 0]
                # then
                #     if [ $J_100 -lt 10 ]
                #     then
                #         Jdis="Jdis00"$J_100
                #     elif [ $J_100 -ge 10 ] && [ $J_100 -lt 100 ]
                #     then
                #         Jdis="Jdis0"$J_100
                #     else
                #         Jdis="Jdis"$J_100
                #     fi
                # else [$J_100 -lt 0]
                #     J_100=$(echo "scale=0; -1*${J_100}" | bc)
                #     if [ $J_100 -ge -10 ]
                #     then
                #         Jdis="JdisN00"$J_100
                #     elif [ $J_100 -lt -10 ] && [ $J_100 -ge -100 ]
                #     then
                #         Jdis="JdisN0"$J_100
                #     else
                #         Jdis="JdisN"$J_100
                #     fi
                # fi                    

                echo "xxxxxxxxxxxxxxx_${Jdis}_xxxxxxxxxxxxxxx"
                echo -e "\n\nxxxxxxxxxxxxxxx_${Jdis}_xxxxxxxxxxxxxxx\n\n" >> "${file}.txt"

                # if [ -d "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}/${Jdis}" ]; then
                #     # 目錄 /path/to/dir 存在
                #     echo -e "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/script/${BC}//B${bonDim}/L${L}/${Jdis}_ok" >> "${file}.txt"
                # else
                #     # 目錄 /path/to/dir 不存在
                #     echo -e "mkdir /home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/script/${BC}//B${bonDim}/L${L}/${Jdis}" >> "${file}.txt"
                #     mkdir "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/script/${BC}//B${bonDim}/L${L}/${Jdis}"
                # fi

                # if [ -d "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/slurmOutput/${BC}//B${bonDim}}/L${L}/${Jdis}" ]; then
                #     # 目錄 /path/to/dir 存在
                #     echo -e "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/slurmOutput/${BC}//B${bonDim}/L${L}/${Jdis}_ok" >> "${file}.txt"
                # else
                #     # 目錄 /path/to/dir 不存在
                #     echo -e "mkdir /home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/slurmOutput/${BC}//B${bonDim}/L${L}/${Jdis}" >> "${file}.txt"
                #     mkdir "/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/slurmOutput/${BC}//B${bonDim}/L${L}/${Jdis}"
                # fi

                for (( d=0; d<=${t2}; d=d+1 ))
                do
                        D=$(echo "scale=3; ${D1}+${d}*${space_D}" | bc)
                        D_100=$(echo "scale=0; 100*(${D1}+${d}*${space_D})/1" | bc)

                        if [ $D_100 -ge 0 ]
                        then
                                if [ $D_100 -lt 10 ]
                                then
                                    Dim="Dim00"$D_100
                                elif [ $D_100 -ge 10 ] && [ $D_100 -lt 100 ]
                                then
                                    Dim="Dim0"$D_100
                                else
                                    Dim="Dim"$D_100
                                fi
                        else
                                D_100=$(echo "scale=0; ${D_100}*(-1)" | bc)
                                if [ $D_100 -lt 10 ]
                                then
                                    Dim="DimN00"$D_100
                                elif [ $D_100 -ge 10 ] && [ $D_100 -lt 100 ]
                                then
                                    Dim="DimN0"$D_100
                                else
                                    Dim="DimN"$D_100
                                fi     
                        fi

                        # if [$D_100 -ge 0]
                        # then
                        #     if [ $D_100 -lt 10 ]
                        #     then
                        #         Dim="Dim00"$D_100
                        #     elif [ $D_100 -ge 10 ] && [ $D_100 -lt 100 ]
                        #     then
                        #         Dim="Dim0"$D_100
                        #     else
                        #         Dim="Dim"$D_100
                        #     fi
                        # else [$D_100 -lt 0]
                        #     D_100=$(echo "scale=0; -1*${D_100}" | bc)
                        #     if [ $D_100 -ge -10 ]
                        #     then
                        #         Dim="DimN00"$D_100
                        #     elif [ $D_100 -lt -10 ] && [ $D_100 -ge -100 ]
                        #     then
                        #         Dim="DimN0"$D_100
                        #     else
                        #         Dim="DimN"$D_100
                        #     fi
                        # fi        


                        # if [ $D_100 -lt 10 ]
                        # then
                        #     Dim="Dim00"$D_100
                        # elif [ $D_100 -ge 10 ] && [ $D_100 -lt 100 ]
                        # then
                        #     Dim="Dim0"$D_100
                        # else
                        #     Dim="Dim"$D_100
                        # fi

                        echo "---------------${Dim}---------------" 
                        echo -e "\n\n---------------${Dim}---------------\n\n" >> "${file}.txt"

                        if [ -d "${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}" ]; then
                            # 目錄 /path/to/dir 存在
                            echo -e "${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}_ok" >> "${file}.txt"
                        else
                            # 目錄 /path/to/dir 不存在
                            echo -e "mkdir ${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}" >> "${file}.txt"
                            mkdir -p "${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}"
                        fi
                        
                        if [ -d "${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/slurmOutput/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}" ]; then
                            # 目錄 /path/to/dir 存在
                            echo -e "${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/slurmOutput/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}_ok" >> "${file}.txt"
                        else
                            # 目錄 /path/to/dir 不存在
                            echo -e "mkdir ${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/slurmOutput/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}" >> "${file}.txt"
                            mkdir -p "${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/slurmOutput/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}"
                        fi     

                        # sInterval=$(echo "scale=0; (${17})/$sInterval" | bc)
                        # echo -e "sInterval=$sInterval"

                        numOfinterval=$(echo "scale=0; (${s2}-${s1}+1)/${sInterval}" | bc)
                        echo -e "numOfinterval=$numOfinterval"

                        for (( s=0; s<${numOfinterval}; s=s+1 ))
                        do              
                                # localS1=$(echo "scale=0; (${s}*${sInterval}+1" | bc)
                                # localS2=$(echo "scale=0; (${s}*${sInterval}+${sInterval}" | bc)
                                localS1=$(( ${s}*${sInterval}+${s1} ))
                                localS2=$(( (${s}+1)*${sInterval}+${s1}-1 ))
                                # localS1=${s}*${sInterval}+1
                                # localS2=(${s}+1)*${sInterval}        
                                submitTime="$(date +'%Y_%m_%d_H%H_M%M_S%S')"
                                # echo "ss:${submitTime}"
                                scriptName="spin${Spin}_L${L}_${Jdis}_${Dim}_P${P}_B${bonDim}_BC=${BC}_Ncore=${Ncore}_seed1=${localS1}_seed2=${localS2}_${submitTime}"
                                jobName="spin${Spin}_L${L}_${Jdis}_${Dim}_P${P}_B${bonDim}_BC=${BC}_Ncore=${Ncore}_seed1=${localS1}_seed2=${localS2}"
                                outputPath="${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}/${scriptName}"
                                # scriptName

                                echo "sh ${scriptName} ${partition} ${L} ${J} ${D} ${P} ${localS1} ${localS2} ${Spin} ${bonDim} ${BC} ${Ncore} ${CheckOrNot}"
                                echo -e "sh ${scriptName} ${partition} ${L} ${J} ${D} ${P} ${localS1} ${localS2} ${Spin} ${bonDim} ${BC} ${Ncore} ${CheckOrNot}" >> "${file}.txt"

                                echo "sh outputPath ${outputPath}"
                                echo -e "sh outputPath ${outputPath}" >> "${file}.txt"

                                # echo "sh spin${Spin}_L${L}_${Jdis}_${Dim}_${bonDim}_${BC}_seed1=${s1}_seed2=${s2}.sh ${partition} ${L} ${J} ${D} ${s1} ${s2} ${Spin} ${bonDim} ${BC}"
                                # echo -e "sh spin${Spin}_L${L}_${Jdis}_${Dim}_${bonDim}_${BC}_seed1=${s1}_seed2=${s2}.sh ${partition} ${L} ${J} ${D} ${s1} ${s2} ${Spin} ${bonDim} ${BC}" >> "${file}.txt"
                                # /home/aronton/tSDRG_project/tSDRG/Sub_script/sub/run.sh
                                cp ${tSDRG_path}/tSDRG/Sub_script/sub/run.sh ${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}/${scriptName}.sh

                                sed -e "s@tSDRG_path@${tSDRG_path}@" -i ${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}/${scriptName}.sh

                                sed -e "s@scopion@scopion$partition@" -i ${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}/${scriptName}.sh
                                
                                sed -e "s@cpus-per-task@cpus-per-task=$Ncore@" -i ${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}/${scriptName}.sh

                                sed -e "s@fileName@${outputPath}@" -i ${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}/${scriptName}.sh    

                                sed -e "s@example@${jobName}@" -i ${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}/${scriptName}.sh                               
                                # sed -e "s@fileName@${outputPath}@" -i /home/aronton/tSDRG_project/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}/"spin${Spin}_L${L}_${Jdis}_${Dim}_${bonDim}_${BC}_Ncore=${Ncore}_seed1=${localS1}_seed2=${localS2}"

                                sed -e "s@Main@Main_${Spin}@" -i ${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}/${scriptName}.sh 
                                
                                sbatch ${tSDRG_path}/tSDRG/Main_${Spin}/jobRecord/script/${BC}/B${bonDim}/L${L}/${Jdis}/${Dim}/${scriptName}.sh ${L} ${J} ${D} ${P} ${localS1} ${localS2} ${Spin} ${bonDim} ${BC} ${Ncore} ${CheckOrNot}
                        done
                        # date >> /home/aronton/tSDRG_project/tSDRG/Main_1/jobRecord/pending
                        
                        # echo "Partition:", ${partition}, "Number of core", ${Ncore} "L:", ${L}, ",J:", ${J}, ",D:", ${D}, ",seed1:", ${s1}, ",seed2:", ${s2} >> /home/aronton/tSDRG_project/tSDRG/Main_1/jobRecord/pending 
                done
        done
done
# else
#     sh /home/aronton/tSDRG_project/tSDRG/Main_15/sub/sub.sh
# fi

date >> "${file}.txt"

echo -e "\n\ntSDRG_Spin="${Spin}";BC=${BC}"";P="${P}";B="${bonDim}";""\n""L="${L1}"_"${L2}"("${space_L}");""\n""J="${J1dis}"_"${J2dis}"("${space_J_100}");""\n""D="${dim1}"_"${dim2}"("${space_D_100}");""\n""seed1="${s1}"_seed2="${s2}";""\n""Partition="${partition}";Number_of_core="${Ncore}"\n\n"


# echo "Partition:" ${partition} "Number of core:" ${Ncore} ";L:" ${L1} "~" ${L2} "(" ${space_L} ")" ";J:" ${J1} "~" ${J2} "(" ${space_J} ")" ";D:" ${D1} "~" ${D2} "(" ${space_D} ")" ",seed1:" ${s1} ",seed2:" ${s2} >> /home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/running

# echo "Partition:" ${partition} "Number of core:" ${Ncore} ";L:" ${L1} "~" ${L2} "(" ${space_L} ")" ";J:" ${J1} "~" ${J2} "(" ${space_J} ")" ";D:" ${D1} "~" ${D2} "(" ${space_D} ")" ",seed1:" ${s1} ",seed2:" ${s2}

#t0=$(echo "(${L2}-${L1})/${space_L}" | bc)
#t1=$(echo "(${J2}-${J1})/${space_J}" | bc)
#t2=$(echo "(${D2}-${D1})/${space_D}" | bc)

# for (( l=0; l<=${t0}; l=l+1 ))
# do
#         L=$(echo "scale=3; ${L1}+${l}*${space_L}" | bc)

#         if [ -d "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/script/L${L}" ]; then
#             # 目錄 /path/to/dir 存在
#             echo "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/script/L${L}"
#         else
#             # 目錄 /path/to/dir 不存在
#             echo "mkdir /home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/script/L${L}"
#             mkdir "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/script/L${L}"
#         fi

#         if [ -d "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/slurmOutput/L${L}" ]; then
#             # 目錄 /path/to/dir 存在
#             echo "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/slurmOutput/L${L}"
#         else
#             # 目錄 /path/to/dir 不存在
#             echo "mkdir /home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/slurmOutput/L${L}"
#             mkdir "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/slurmOutput/L${L}"
#         fi

#         for (( j=0; j<=${t1}; j=j+1 ))
#         do
#                 J=$(echo "scale=3; ${J1}+${j}*${space_J}" | bc)

#                 if [ $J -lt 10 ]
#                 then
#                     Jdis="Jdis00"$J
#                 elif [ $J -ge 10 ] && [ $J -lt 100 ]
#                 then
#                     Jdis="Jdis0"$J
#                 else
#                     Jdis="Jdis"$J
#                 fi

#                 if [ -d "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/script/L${L}/J${Jdis}" ]; then
#                     # 目錄 /path/to/dir 存在
#                     echo "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/script/L${L}/J${Jdis}"
#                 else
#                     # 目錄 /path/to/dir 不存在
#                     echo "mkdir /home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/script/L${L}/J${Jdis}"
#                     mkdir "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/script/L${L}/J${Jdis}"
#                 fi

#                 if [ -d "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/slurmOutput/L${L}/J${Jdis}" ]; then
#                     # 目錄 /path/to/dir 存在
#                     echo "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/slurmOutput/L${L}/J${Jdis}"
#                 else
#                     # 目錄 /path/to/dir 不存在
#                     echo "mkdir /home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/slurmOutput/L${L}/J${Jdis}"
#                     mkdir "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/slurmOutput/L${L}/J${Jdis}"
#                 fi

#                 for (( d=0; d<=${t2}; d=d+1 ))
#                 do
#                         D=$(echo "scale=0; 100*(${D1}+${d}*${space_D})/1" | bc)

#                         if [ $D -lt 10 ]
#                         then
#                             Dim="Dim00"$D
#                         elif [ $D -ge 10 ] && [ $D -lt 100 ]
#                         then
#                             Dim="Dim0"$D
#                         else
#                             Dim="Dim"$D
#                         fi

#                         if [ -d "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/script/L${L}/J${Jdis}/D${Dim}" ]; then
#                             # 目錄 /path/to/dir 存在
#                             echo "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/script/L${L}/J${Jdis}/D${Dim}"
#                         else
#                             # 目錄 /path/to/dir 不存在
#                             echo "mkdir /home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/script/L${L}/J${Jdis}/D${Dim}"
#                             mkdir "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/script/L${L}/J${Jdis}/D${Dim}"
#                         fi
                        
#                         if [ -d "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/slurmOutput/L${L}/J${Jdis}/D${Dim}" ]; then
#                             # 目錄 /path/to/dir 存在
#                             echo "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/slurmOutput/L${L}/J${Jdis}/D${Dim}"
#                         else
#                             # 目錄 /path/to/dir 不存在
#                             echo "mkdir /home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/slurmOutput/L${L}/J${Jdis}/D${Dim}"
#                             mkdir "/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/slurmOutput/L${L}/J${Jdis}/D${Dim}"
#                         fi
                
#                 done
#         done
# done


# if [ "${Continue}" == "Y" ]
# then