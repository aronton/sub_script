echo "orderparameter         ==> ${1}"
echo "partition         ==> ${2}"
echo "Ncore         ==> ${3}"
echo "Spin         ==> ${4}"
echo "ProbDis        ==> ${5}"
echo "bonDim        ==> ${6}"
echo "L1        ==> ${7}"
echo "L2        ==> ${8}"
echo "space_L        ==> ${9}"
echo "J1        ==> ${10}"
echo "J2        ==> ${11}"
echo "space_J        ==> ${12}"
echo "D1        ==> ${13}"
echo "D2        ==> ${14}"
echo "space_D        ==> ${15}"
# echo "seed1        ==> ${16}"
# echo "seed2        ==> ${17}"
# echo "Nseed :   ==> ${18}"
# echo "BC :   ==> ${16}"
# echo "delta seed :   ==> ${20}"

date

orderparameter=${1}

partition=$(echo "scale=0; (${2})/1" | bc)
echo -e "partitio=$partition"

Ncore=$(echo "scale=0; (${3})/1" | bc)
echo -e "Ncore=$Ncore"

Spin=$(echo "scale=0; (${4})/1" | bc)
echo -e "Spin=$Spin"

ProbDis=$(echo "scale=0; (${5})/1" | bc)
echo -e "P=$P"

bonDim=$(echo "scale=0; (${6})/1" | bc)
echo -e "bonDim=$bonDim"

# L1=$(echo "scale=0; (${7})/1" | bc)
# echo -e "L1=$L1"
# L2=$(echo "scale=0; (${8})/1" | bc)
# echo -e "L2=$L2"
# space_L=$(echo "scale=0; (${9})/1" | bc)
# echo -e "space_L=$space_L"

# J1=$(echo "scale=2; (${10})/1." | bc)
# echo -e "J1=$J1"
# J2=$(echo "scale=2; (${11})/1." | bc)
# echo -e "J2=$J2"
# space_J=$(echo "scale=2; (${12})/1." | bc)
# echo -e "space_J=$space_J"

# D1=$(echo "scale=2; (${13})/1." | bc)
# echo -e "D1=$D1"
# D2=$(echo "scale=2; (${14})/1." | bc)
# echo -e "D2=$D2"
# space_D=$(echo "scale=2; (${15})/1." | bc)
# echo -e "space_D=$space_D"

# J1=$(echo "scale=2; (${10})/1" | bc)
# echo -e "J1=$J1"
# J2=$(echo "scale=2; (${11})/1" | bc)
# echo -e "J2=$J2"
# space_J=$(echo "scale=2; (${12})/1" | bc)
# echo -e "space_J=$space_J"

# D1=$(echo "scale=2; (${13})/1" | bc)
# echo -e "D1=$D1"
# D2=$(echo "scale=2; (${14})/1" | bc)
# echo -e "D2=$D2"
# space_D=$(echo "scale=2; (${15})/1" | bc)
# echo -e "space_D=$space_D"

L1=$(echo "scale=0; (${7})/1" | bc)
echo -e "L1=$L1"
L2=$(echo "scale=0; (${8})/1" | bc)
echo -e "L2=$L2"
space_L=$(echo "scale=0; (${9})/1" | bc)
echo -e "space_L=$space_L"

J1=$(echo "scale=2; (${10})/1." | bc)
echo -e "J1=$J1"
J2=$(echo "scale=2; (${11})/1." | bc)
echo -e "J2=$J2"
space_J=$(echo "scale=2; (${12})/1." | bc)
echo -e "space_J=$space_J"

D1=$(echo "scale=2; (${13})/1." | bc)
echo -e "D1=$D1"
D2=$(echo "scale=2; (${14})/1." | bc)
echo -e "D2=$D2"
space_D=$(echo "scale=2; (${15})/1." | bc)
echo -e "space_D=$space_D"


sorting_Path="/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/submit_record/"

now_date="$(date +'%Y_%m_%d')/"
# now="${date}"

if [ -d "${sorting_Path}""${now_date}" ]; then
    # submit_record 目錄存在
    echo -e "${sorting_Path}""${now_date}"
else
    # submit_record 目錄不存在
    echo -e "mkdir""-p""${sorting_Path}""${now_date}"
    mkdir -p "${sorting_Path}""${now_date}"
fi

file="${sorting_Path}${now_date}RM_Null_Orderparameter=${orderparameter};P=${P};B=${bonDim};L=${L1}_${L2}(${space_L});J=${J1}_${J2}(${space_J});D=${D1}_${D2}(${space_D});Partition=${partition};Number_of_core=${Ncore}"

echo -e "${file}"

date >> "${file}.txt"

echo -e "RM_Null_Partition:${partition};Number of core:${Ncore};Spin:${Spin};L:${L1}~${L2}(${space_L});J:${J1}~${J2}(${space_J});D:${D1}~${D2}(${space_D}):${seed2};Orderparameter:${orderparameter}" >> "${file}.txt"

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
      echo -e "ooooooooooL_L=${L}_oooooooooo"
      echo -e "\n\noooooooooo_L=${L}_oooooooooo\n\n" >> "${file}.txt"

      for (( j=0; j<=${t1}; j=j+1 ))
      do

            J=$(echo "scale=3; ${J1}+${j}*${space_J}" | bc)
            J_100=$(echo "scale=0; 100*(${J1}+${j}*${space_J})/1" | bc)

            if [ $J_100 -lt 10 ]
            then
                  Jdis="Jdis00"$J_100
            elif [ $J_100 -ge 10 ] && [ $J_100 -lt 100 ]
            then
                  Jdis="Jdis0"$J_100
            else
                  Jdis="Jdis"$J_100
            fi

            echo "xxxxxxxxxxxxxxx_${Jdis}_xxxxxxxxxxxxxxx"
            echo -e "\n\nxxxxxxxxxxxxxxx_${Jdis}_xxxxxxxxxxxxxxx\n\n" >> "${file}.txt"

            # echo "J:"$J
            # echo -e "J:${J}\n" >> "${file}.txt"

            # if [ $j -ge 100 ];   then
            #       J="Jdis$j"
            #       # echo -e "Jdis$j"
            # elif [ $j -lt 100 ] & [ $j -ge 10 ];   then
            #       J="Jdis0$j"
            #       # echo -e "Jdis0$j"
            # else
            #       J="Jdis00$j"
            #       # echo -e "Jdis00$j"
            # fi

            for (( d=0; d<=${t2}; d=d+1 ))
            do
                  D=$(echo "scale=3; ${D1}+${d}*${space_D}" | bc)
                  D_100=$(echo "scale=0; 100*(${D1}+${d}*${space_D})/1" | bc)

                  if [ $D_100 -lt 10 ]
                  then
                        Dim="Dim00"$D_100
                  elif [ $D_100 -ge 10 ] && [ $D_100 -lt 100 ]
                  then
                        Dim="Dim0"$D_100
                  else
                        Dim="Dim"$D_100
                  fi

                  echo -e "---------------${Dim}---------------" 
                  echo -e "\n\n---------------${Dim}---------------\n\n" >> "${file}.txt"

                  # echo -e "D:"$D
                  # echo -e "D:${D}\n" >> "${file}.txt"

                  for ((dx=1;dx<=${L}/2;dx=dx+1))
                  do

                        # echo -e "---------------${dx}---------------" 
                        # echo -e "\n\n---------------${dx}---------------\n\n" >> "${file}.txt"

                        # echo -e "L$l"
                        # echo -e "Dim$d"
                        # echo -e "Jdis$j"

                        folder="/home/aronton/tSDRG_project/Sorting_data/Spin2/metadata/bulk_ave/${Jdis}/${Dim}/L${L}/dx_${dx}"

                        csv="/home/aronton/tSDRG_project/Sorting_data/Spin2/metadata/bulk_ave/${Jdis}/${Dim}/L${L}/dx_${dx}/bulk_ave_L${L}_${Jdis}_${Dim}_dx_${dx}.csv"
                        
                        # echo -e "${csv}" >> "${file}.txt"
                        # echo -e "${folder}" >> "${file}.txt"

                        if ! [ -d ${folder} ]; then
                              continue
                        fi

                        if ! [ -f ${csv} ]; then
                              echo -e "${csv} not exist, rm -rf ${folder}" >> "${file}.txt"
                              rm -rf ${folder}
                              continue
                        fi

                        while IFS="," read -r f1 f2 f3;
                        do
                              if [ -z "$f1" ];   then
                                    echo "J:${Jdis}, D:${Dim}, l:${L}" >> "${file}.txt"
                                    echo "N" >> "${file}.txt"
                                    echo "rm ${csv}" >> "${file}.txt"
                                    echo "rm -rf ${folder}" >> "${file}.txt"
                                    rm ${csv}
                                    rm -rf ${folder}
                                    # echo "N"
                              else
                                    echo "csv is ok"
                                    echo "$f1, $f2"
                                    echo "csv is ok" >> "${file}.txt"
                                    echo "$f1, $f2" >> "${file}.txt"
                                    # echo "$f2"
                              fi
                        done < ${csv}

                        # if ! [ -d ${folder} ]; then
                        #       # echo -e "${csv}"
                        #       continue
                        # fi

                        # if [ "$(ls -A ${folder})" ]; then
                        #       echo "${folder} is not Empty, do not rm"
                        # else
                        #       echo "${folder} is Empty"
                        #       rm -rf ${folder}
                        # fi

                  done

                  folder="/home/aronton/tSDRG_project/Sorting_data/Spin2/metadata/bulk_ave/${Jdis}/${Dim}/L${L}"

                  if ! [ -d ${folder} ]; then
                        # echo -e "${csv}"
                        continue
                  fi

                  if [ "$(ls -A ${folder})" ]; then
                        echo "${folder} is not Empty, do not rm"
                        echo "${folder} is not Empty, do not rm" >> "${file}.txt"
                  else
                        echo "${folder} is Empty, rm -rf ${folder}"
                        echo "${folder} is Empty, rm -rf ${folder}" >> "${file}.txt"
                        rm -rf ${folder}
                  fi
            done

            folder="/home/aronton/tSDRG_project/Sorting_data/Spin2/metadata/bulk_ave/${Jdis}/${Dim}"

            if ! [ -d ${folder} ]; then
                  # echo -e "${csv}"
                  continue
            fi

            if [ "$(ls -A ${folder})" ]; then
                  echo "${folder} is not Empty, do not rm"
                  echo "${folder} is not Empty, do not rm" >> "${file}.txt"
            else
                  echo "${folder} is Empty, rm -rf ${folder}"
                  echo "${folder} is Empty, rm -rf ${folder}" >> "${file}.txt"
                  rm -rf ${folder}
            fi
      done

      folder="/home/aronton/tSDRG_project/Sorting_data/Spin2/metadata/bulk_ave/${Jdis}"

      if ! [ -d ${folder} ]; then
            # echo -e "${csv}"
            continue
      fi

      if [ "$(ls -A ${folder})" ]; then
            echo "${folder} is not Empty, do not rm"
            echo "${folder} is not Empty, do not rm" >> "${file}.txt"
      else
            echo "${folder} is Empty, rm -rf ${folder}"
            echo "${folder} is Empty, rm -rf ${folder}" >> "${file}.txt"
            rm -rf ${folder}
      fi

done

echo -e "RM_Null_Partition:${partition};Number of core:${Ncore};Spin:${Spin};L:${L1}~${L2}(${space_L});J:${J1}~${J2}(${space_J});D:${D1}~${D2}(${space_D}):${seed2};Orderparameter:${orderparameter}" >> "${file}.txt"

date