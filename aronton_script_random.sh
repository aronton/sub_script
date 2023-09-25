echo "tSDRG_random:"

sinfo -o "%n %e %m %a %c %C"

tSDRG_path="/home/aronton/tSDRG_random"

read -p "which command: tSDRG_sub:
        (a)_tSDRG_submit
        (b)_tSDRG_scancel
        (c)_tSDRG_scancel_re
        (d)_Sorting_submit
        (e)_Sorting_scancel
        (f)_check_sample
        (g)_check_job_user
        (h)_check_job_partition
        enter your command (a,b,c...):" command

read -p "spin:" Spin

if [ "$command" = "a" ]
then
    # origin=pwd
    execute_dir="${tSDRG_path}/tSDRG/Main_"$Spin
    cd $execute_dir
    echo "execute_dir:"$execute_dir
    # echo "$pwd"
    # echo $(pwd)
    # echo $$
    sh ${tSDRG_path}/tSDRG/Sub_script/tSDRG_Parameter_Sub.sh ${Spin}
    # echo "sh /home/aronton/tSDRG_project/tSDRG/Sub_script/tSDRG_Parameter_Sub.sh"
elif [ "$command" = "b" ]
then
    sh ${tSDRG_path}/tSDRG/Sub_script/subscancel.sh
    echo "_tSDRG_scancel"
elif [ "$command" = "c" ]
then
    execute_dir="${tSDRG_path}/tSDRG/Main_${Spin}"
    cd $execute_dir
    sh ${tSDRG_path}/tSDRG/Sub_script/subscancel_re.sh
    echo "_tSDRG_scancel_re"
elif [ "$command" = "d" ]
then
    echo "_Sorting_scancel"
elif [ "$command" = "e" ]
then
    echo "_check_sample"
elif [ "$command" = "f" ]
then
    echo "_check_job_by_user"
    squeue -u aronton -o "%%.10i %%.10P %%.76j %%.8u%%.8T%%.15M"
elif [ "$command" = "g" ]
then
    echo "_check_job_by_partition"
    squeue -p scopion3 -o "%%.10i %%.10P %%.76j %%.8u%%.8T%%.15M"
fi
