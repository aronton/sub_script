# Dimerization & String Order Parameter 
### average raw data to meta data
import os
import math
import time
import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt 
import multiprocessing as mp
from scipy.optimize import curve_fit
import sys

tSDRG_path = "/home/aronton/tSDRG_random"

# parameter input

spin = int(sys.argv[1])

BC = str(sys.argv[2])

probDis = int(sys.argv[3])

chi = int(sys.argv[4])

L = int(sys.argv[5])

jdis = str(sys.argv[6])

dim = str(sys.argv[7])

initial_Seed = int(sys.argv[8])

final_Seed = int(sys.argv[9])

print("\n---------------Parameter List----------------\n")

print("spin:",spin)
print("BC:",BC)
print("Prob:",probDis)
print("chi:",chi)
print("L:",L)
print("Jdis",jdis)
print("Dim",dim)
print("initial_Seed",initial_Seed)
print("final_Seed",final_Seed)

print("\n---------------Direction Path----------------\n")

# direc1 = '/home/aronton/tSDRG_project/Sorting_data/Spin' + str(spin) + '/metadata/' + 'ZL_Accumulation11/' + jdis +'/' + dim +'/' +'ZL_Accumulation_' + jdis + "_" + dim + "_" + BC +'_L'+ str(L) +'_P' + str(probDis) + '_m'+ str(chi) + '.csv'
# print(direc1)
# print("\n")

# if(os.path.exists(direc1) == False):
#     os.mkdir(direc1)
# direc2 =  direc1 + 'ZL_Accumulation11/'
# print(direc2)
# print("\n")

# if(os.path.exists(direc2) == False):
#     os.mkdir(direc2)
# direc3 =  direc2 + jdis +'/'
# print(direc3)
# print("\n")

# if(os.path.exists(direc3) == False):
#     os.mkdir(direc3)
# direc4 =  direc3 + dim +'/'
# print(direc4)
# print("\n")

# if(os.path.exists(direc4) == False):
#     os.mkdir(direc4)

accumulation_dir_path = tSDRG_path + '/Sorting_data/Spin' + str(spin) + '/metadata/' + 'corr_etoe_Accumulation/' + str(BC) + "/" + jdis +'/' + dim +'/'

if(os.path.exists(accumulation_dir_path) == False):
    print("accumulation_dir_path not exist : ",accumulation_dir_path)
    os.makedirs(accumulation_dir_path)

accumulation_path = accumulation_dir_path +'/' +'corr_etoe_Accumulation_' + jdis + "_" + dim + "_" + BC +'_L'+ str(L) +'_P' + str(probDis) + '_m'+ str(chi) + '.csv'


# accumulation_path = direc4 +'ZL_Accumulation_' + jdis + "_" + dim + "_" + BC +'_L'+ str(L) +'_P' + str(probDis) + '_m'+ str(chi) + '.csv'

# die_seed_path = direc4 +'ZL_Die_Seed_' + jdis + "_" + dim + '_' + BC +'_L'+ str(L) +'_P' + str(probDis) + '_m'+ str(chi) + '.csv'

# die_seed_dir_path = '/home/aronton/tSDRG_project/Sorting_data/Spin' + str(spin) + '/metadata/' + 'corr_etoe_die_seed/' + jdis +'/' + dim +'/' 

# if(os.path.exists(die_seed_dir_path) == False):
#     os.makedirs(die_seed_dir_path)

# die_seed_path = '/home/aronton/tSDRG_project/Sorting_data/Spin' + str(spin) + '/metadata/' + 'corr_etoe_Accumulation11/' + jdis +'/' + dim +'/' +'ZL_Die_Seed_' + jdis + "_" + dim + "_" + BC +'_L'+ str(L) +'_P' + str(probDis) + '_m'+ str(chi) + '.csv'

# direc1_ave = '/home/aronton/tSDRG_project/Sorting_data/Spin' + str(spin) + '/metadata/'
# print(direc1_ave)
# print("\n")

# if(os.path.exists(direc1_ave) == False):
#     os.mkdir(direc1_ave)
# direc2_ave =  direc1_ave + 'ZL1/'
# print(direc2_ave)
# print("\n")

# if(os.path.exists(direc2_ave) == False):
#     os.mkdir(direc2_ave)
# direc3_ave =  direc2_ave + jdis +'/'
# print(direc3_ave)
# print("\n")

# if(os.path.exists(direc3_ave) == False):
#     os.mkdir(direc3_ave)
# direc4_ave =  direc3_ave + dim +'/'
# print(direc4_ave)
# print("\n")

# if (os.path.exists(direc4_ave) == False):
#     os.mkdir(direc4_ave)

# average_path = direc4_ave + BC + '_L' + str(L) + "_P" + str(probDis) + "_m" + str(chi) + "_ZL" + '.csv'

average_dir_path = tSDRG_path + '/Sorting_data/Spin' + str(spin) + "/metadata/corr_etoe/" + BC  + "/" + jdis +"/" + dim + "/"

if(os.path.exists(average_dir_path) == False):
    os.makedirs(average_dir_path)

average_path = average_dir_path + "corr_etoe_" + "L" + str(L) + "_P_" + str(probDis) + "_m" + str(chi) + "_" + jdis + "_" + dim + '.csv'

print("accumulation_path:")
print(accumulation_path)
print("\n")

print("average_path:")
print(average_path)
print("\n")


print("\n---------------averageFrame----------------\n")

averageFrame = pd.DataFrame(columns = ['corr_etoe', 'error', 'Nseed', 'Nsample'])
averageFrame['Nseed'] = averageFrame['Nseed'].astype('int')
averageFrame['Nsample'] = averageFrame['Nsample'].astype('int')


print("averageFrame",averageFrame)

# accumulation_frame = pd.DataFrame(columns = ['corr_etoe', 'seed_num'])
# averageFrame['seed_num'] = averageFrame['seed_num'].astype('int')

# print("accumulation_frame",accumulation_frame)


print("\n----------------Start---------------\n")


start_time = time.time()
print("start time:")
print(time.time())

if(initial_Seed != 1):

    initial_Seed = pd.read_csv(average_path).at[0, "Nseed"]
    initial_Seed = int(initial_Seed) + 1

    print("accumulation_path_exist\n")
    accumulation_frame = pd.read_csv(accumulation_path)

    print("accumulation_frame\n")
    print(accumulation_frame)

    print("average_frame\n")
    print(pd.read_csv(average_path))

    if(os.path.exists(die_seed_path)):
        print("die_seed_frame exist:\n")
        die_seed_frame = pd.read_csv(die_seed_path)
        print(die_seed_frame)
    else:
        print("die_seed_path does not exist, creatOne")
        die_seed_frame = pd.DataFrame(columns = ['die_seed_num'])
        print("die_seed_frame:\n")
        print(die_seed_frame)

    for seed_num in range(initial_Seed, final_Seed + 1):

        my_csv = tSDRG_path + '/tSDRG/Main_' + str(spin) + '/data_random/'+ BC +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(probDis) +'_m'+ str(chi) +'_'+ str(seed_num) + 'corr1_etoe' + '.csv'

        my_file = tSDRG_path + '/tSDRG/Main_' + str(spin) + '/data_random/'+ BC +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(probDis) +'_m'+ str(chi) +'_'+ str(seed_num) 

        if(os.path.exists(my_csv)):
            # try:
            #     inputFrame = pd.read_csv(my_csv)
            # except:
            #     continue    
            inputFrame = pd.read_csv(my_csv)  
            corr_etoe = inputFrame.at[0, "corr"]
            accumulation_frame = accumulation_frame.append({"corr_etoe": corr_etoe,"seed_num": int(seed_num)}, ignore_index=True)
        else:
            if(os.path.exists(my_file)):
                die_seed_frame.append({"die_seed_num": int(seed_num)},ignore_index=True)
                print("die_seed_num:", seed_num)
                print("my_csv:", my_csv)
            else:
                print("missing data:", seed_num)
                print("my_file:", my_csv)
else:
    print("start from seed 1, creat one")
    accumulation_frame = pd.DataFrame(columns = ['corr_etoe','seed_num'])
    accumulation_frame['seed_num'] = accumulation_frame['seed_num'].astype('int')

    print("accumulation_frame\n")
    print(accumulation_frame)

    # die_seed_frame = pd.DataFrame(columns = ['die_seed_num'])
    # print("die_seed_frame\n")
    # print(die_seed_frame)
    
    
    for seed_num in range(initial_Seed, final_Seed + 1):

        my_csv = tSDRG_path + '/tSDRG/Main_' + str(spin) + '/data_random/'+ "OBC" +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(probDis) +'_m'+ str(chi) +'_'+ str(seed_num) + '/corr1_etoe' + '.csv'

        my_file = tSDRG_path + '/tSDRG/Main_' + str(spin) + '/data_random/'+ "OBC" +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(probDis) +'_m'+ str(chi) +'_'+ str(seed_num) 

        if(os.path.exists(my_csv)):
            # try:
            #     inputFrame = pd.read_csv(my_csv)
            # except:
            #     continue         
            inputFrame = pd.read_csv(my_csv)   
            corr_etoe = inputFrame.at[0, "corr"]
            accumulation_frame = accumulation_frame.append({"corr_etoe": -corr_etoe,"seed_num": int(seed_num)}, ignore_index=True)
        else:
            # two situation, die seed or file broken
            if(os.path.exists(my_file)):
                # die seed, csv is not, file is ok
                # die_seed_frame.append({"die_seed_num": int(seed_num)},ignore_index=True)
                print("die_seed_num:", seed_num)
                print("my_csv:", my_csv)
            else:
                # die seed, csv is ok, file is not
                print("missing data:", seed_num)
                print("my_file:", my_file)


Nsample = len(accumulation_frame.index)
average = accumulation_frame.mean()["corr_etoe"]
std = accumulation_frame.std()["corr_etoe"]
error = std/np.sqrt(Nsample)
averageFrame = averageFrame.append({"corr_etoe":average,"error":error,"Nseed":final_Seed,"Nsample":Nsample}, ignore_index=True)

averageFrame["Nseed"] = averageFrame["Nseed"].astype('int')
averageFrame["Nsample"] = averageFrame["Nsample"].astype('int')

accumulation_frame['seed_num'] = accumulation_frame['seed_num'].astype('int')


end_time = time.time()
print("end time:")
print(time.time())

print("tot_time:",end_time-start_time)

print("\n----------------end---------------\n")

print("Nsample",Nsample)
print("average",average)
print("std",std)
print("error",error)

# print("accumulation_frame:\n")
# print(accumulation_frame)
if(accumulation_frame["corr_etoe"].isnull().any() == True):
    print("accumulation_frame : No data")
    print(accumulation_frame)
else:
    accumulation_frame.to_csv(accumulation_path, index=False)
    print(accumulation_frame)


# print("averageFrame:\n")
# print(averageFrame)
if(averageFrame["corr_etoe"].isnull().any() == True):
    print("averageFrame : No data")
    print(averageFrame)
else:
    averageFrame.to_csv(average_path, index=False)
    print(averageFrame)


# print("die_seed_frame:\n")
# print(die_seed_frame)
# if(die_seed_frame["die_seed_num"].isnull().any() == True):
#     print("die_seed_num : No data")
#     print(die_seed_frame)
# else:
#     die_seed_frame.to_csv(die_seed_path, index=False)
#     print(die_seed_frame)

print('all done')