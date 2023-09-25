# Dimerization & bulk corr
### average raw data to meta data
import os
import math
import pandas as pd 
import numpy as np
# import matplotlib.pyplot as plt 
# from scipy.optimize import curve_fit
import sys

# seperate dx from each source file 
def get_dx_frame(dx, originalframe, L, J, D, seed):

    # dx seperate directory
    accumulate_dir_path = "/home/aronton/tSDRG_project/Sorting_data/Spin2/metadata/bulk_dx_seperate/" + str(J) + "/" + str(D) + "/" + "L" + str(L) + "/dx_" + str(dx) + "/"

    if(os.path.exists(accumulate_dir_path) == False):
        os.makedirs(accumulate_dir_path)

    # dx csv file
    accumulate_csv_path = accumulate_dir_path + "L" + str(L) + "_" + str(J) + "_" + str(D) + "_dx_" + str(dx) + "_seed_" + str(seed) +".csv"

    # print("dx\n",dx)
    # print("accumulate_csv_path\n",accumulate_csv_path)

    # save dx seperate frame
    outputframe = originalframe[originalframe["dx"] == dx]
    outputframe.to_csv(accumulate_csv_path, index = False)

    return 0


# get average from dx seperate frame
def get_ave_frame(dx, L, J, D, int_seed, final_seed):

    # dx seperate directory path
    bulk_dx_seperate_dir_path = "/home/aronton/tSDRG_project/Sorting_data/Spin2/metadata/bulk_dx_seperate/" + str(J) + "/" + str(D) + "/" + "L" + str(L) + "/dx_" + str(dx) + "/"

    print("accumulate_dir_path\n",bulk_dx_seperate_dir_path)

    if(os.path.exists(bulk_dx_seperate_dir_path) == False):
        os.makedirs(bulk_dx_seperate_dir_path)

    # dx seperate csv file path
    bulk_dx_seperate_csv_path = bulk_dx_seperate_dir_path + "L" + str(L) + "_" + str(J) + "_" + str(D) + "_dx_" + str(dx) + "_seed_" + "seed_num" +".csv"

    print("bulk_dx_seperate_csv_path\n",bulk_dx_seperate_csv_path)


    # dx accumulate directory path
    bulk_dx_accumulate_path = "/home/aronton/tSDRG_project/Sorting_data/Spin2/metadata/bulk_dx_accumulate/" + str(J) + "/" + str(D) + "/" + "L" + str(L) + "/dx_" + str(dx) + "/"

    # dx accumulate csv file path
    bulk_dx_accumulate_path = bulk_dx_accumulate_path + "/L" + str(L) + "_" + str(J) + "_" + str(D) + "_dx_" + str(dx) + "_seed1_" + str(int_seed) + "_seed2_" + str(final_seed) + ".csv"

    print("ave_path\n",bulk_dx_accumulate_path)

    # create dx accumulate frame empty
    bulk_dx_accumulate_frame = pd.DataFrame({"x1":[],"x2":[],"corr":[],"dx":[]})

    # setting data type of dx accumulate frame
    bulk_dx_accumulate_frame['x1'] = bulk_dx_accumulate_frame['x1'].astype('int')
    bulk_dx_accumulate_frame['x2'] = bulk_dx_accumulate_frame['x2'].astype('int')
    bulk_dx_accumulate_frame['corr'] = bulk_dx_accumulate_frame['corr'].astype('float')
    bulk_dx_accumulate_frame['dx'] = bulk_dx_accumulate_frame['dx'].astype('int')

    for seed in range(int_seed, final_seed + 1):

        print("bulk_dx_seperate_csv_path\n",bulk_dx_seperate_csv_path)

        # dx seperate scv path ( replace seed_num with seed )
        bulk_dx_seperate_csv_path_temp = bulk_dx_seperate_csv_path.replace("seed_num", str(seed)) 

        print("bulk_dx_seperate_csv_path_temp\n", bulk_dx_seperate_csv_path_temp)

        if(os.path.exists(bulk_dx_seperate_csv_path_temp) == False):
            continue

        # dx seperate frame read from csv 
        bulk_dx_seperate_csv_path_frame = pd.read_csv(bulk_dx_seperate_csv_path_temp)
        print("seed\n", seed)
        print("bulk_dx_seperate_csv_path_frame\n", bulk_dx_seperate_csv_path_frame)
        bulk_dx_accumulate_frame = bulk_dx_accumulate_frame.append(bulk_dx_seperate_csv_path_frame, ignore_index = True)
        print("seed\n", seed)
        print("ave_framn\n", bulk_dx_accumulate_frame)
        bulk_dx_accumulate_frame.to_csv(bulk_dx_accumulate_path, index = False)
    
    # bulk corr is defined as (-1)^dx < SS > 
    # if( ( dx % 2 ) != 0 ):
    #     # dx odd
    #     bulk_mean = -bulk_dx_accumulate_frame["corr"].mean()
    # else:
    #     # dx even
    bulk_mean = (-1)**dx*bulk_dx_accumulate_frame["corr"].mean()

    bulk_error = bulk_dx_accumulate_frame["corr"].sem(ddof=1)
    bulk_sample = final_seed - int_seed + 1

    # average directory path
    ave_dir = "/home/aronton/tSDRG_project/Sorting_data/Spin2/metadata/bulk_ave/" + str(J) + "/" + str(D) + "/" + "L" + str(L) + "/dx_" + str(dx) + "/"

    if(os.path.exists(ave_dir) == False):
        os.makedirs(ave_dir) 

    # average csv path
    ave_csv = "/home/aronton/tSDRG_project/Sorting_data/Spin2/metadata/bulk_ave/" + str(J) + "/" + str(D) + "/" + "L" + str(L) + "/dx_" + str(dx) + "/" + "bulk_ave_L" + str(L) + "_" + str(J) + "_" + str(D) + "_dx_" + str(dx) + ".csv"
    
    # average frame
    ave_frame = pd.DataFrame({"bulk_corr":[bulk_mean],"error":[bulk_error],"sample":[bulk_sample]})
    ave_frame['sample'] = ave_frame['sample'].astype('int')
    ave_frame.to_csv(ave_csv, index = False)
    return 0

get_dx_frame_vector = np.vectorize(get_dx_frame, excluded=['originalframe','L','J','D', 'seed'])

get_ave_frame_vector = np.vectorize(get_ave_frame, excluded=['L', 'J', 'D', 'int_seed', 'final_seed'])

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

# template of accumulate_dir_path
accumulate_dir_path_temp = '/home/aronton/tSDRG_project/Sorting_data/Spin' + str(spin) + '/metadata/' + 'bulk_dx_seperate/' + jdis +'/' + dim +'/' + "L" + str(L) + "/dx_" + "dx_num/"

# template of accumulate_csv_path
accumulate_csv_path_temp = '/home/aronton/tSDRG_project/Sorting_data/Spin' + str(spin) + '/metadata/' + 'bulk_dx_seperate/' + jdis +'/' + dim +'/' + "L" + str(L) + "/dx_" + "dx_num" + "/L" + str(L) + "_" + jdis + "_" + dim + "_dx_" + "dx_num" + "_seed_" + str(final_Seed - initial_Seed + 1) + ".csv"

print(accumulate_dir_path_temp)
print("\n")
print(accumulate_csv_path_temp)
print("\n")

# template of ave_dir_path
ave_dir_path_temp = '/home/aronton/tSDRG_project/Sorting_data/Spin' + str(spin) + '/metadata/' + 'bulk_dx_accumulate/' + jdis +'/' + dim +'/' + "L" + str(L) + "/dx_" + "dx_num"

# template of ave_csv_path
ave_csv_path_temp = ave_dir_path_temp + "/L" + str(L) + "_" + jdis + "_" + dim + "_dx_" + "dx_num" + "_smaple_" + str(final_Seed - initial_Seed + 1) + ".csv"


print(ave_dir_path_temp)
print("\n")
print(ave_csv_path_temp)
print("\n")

dx_array = np.array(np.linspace(1,L//2,L//2), dtype = int)

for dx in dx_array:

    dir = ave_dir_path_temp.replace("dx_num",str(dx))
    if(os.path.exists(dir) == False):
        os.makedirs(dir)

for seed_num in range(initial_Seed, final_Seed + 1):

    # replace "seed_num" with int seed_num
    accumulate_dir_path = accumulate_dir_path_temp.replace("seed_num", str(seed_num))

    print("accumulate_dir_path:\n", accumulate_dir_path)

    # replace "seed_num" with int seed_num
    ave_csv_path = ave_dir_path_temp.replace("seed_num", str(seed_num))

    print("ave_csv_path:\n", ave_csv_path)

    # path of source file
    source_csv = '/home/aronton/tSDRG_project/tSDRG/Main_' + str(spin) + '/data/'+ BC +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(probDis) +'_m'+ str(chi) +'_'+ str(seed_num) + '/L'+ str(L) +'_P'+ str(probDis) +'_m'+ str(chi) +'_'+ str(seed_num) + "_corr1" + '.csv'

    print("source_csv:\n", source_csv)

    if(os.path.exists(source_csv) == False):
        continue
    # read path file and create a new column call dx
    corr_frame = pd.read_csv(source_csv)
    dx_corr_series = corr_frame["x2"] - corr_frame["x1"]
    dx_corr_series = pd.DataFrame(dx_corr_series)
    dx_corr_series.set_axis(['dx'], axis=1, inplace=True)
    corr_frame["dx"] = dx_corr_series

    # seperate dx frome source frame
    get_dx_frame_vector(dx_array, originalframe=corr_frame, L=L, J=jdis, D=dim, seed=seed_num)

# get average from each seperate dx frome
get_ave_frame_vector(dx_array, L=L, J=jdis, D=dim, int_seed=initial_Seed, final_seed=final_Seed)
