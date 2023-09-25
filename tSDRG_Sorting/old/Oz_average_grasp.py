# Dimerization & String Order Parameter 
### average raw data to meta data
import os
import math
import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt 
from scipy.optimize import curve_fit
import sys

# BC = 'PBC'
# P = 10 
# M = 30

# spin = int(sys.argv[1])
spin = 15
# BC = str(sys.argv[2])
BC = "PBC"
# probDis = int(sys.argv[3])
probDis = 10
# chi = int(sys.argv[4])
chi = 30
# L = int(sys.argv[5])
L = 32
# final_L = int(sys.argv[2])
# space_L =int(sys.argv[3])

# jdis = str(sys.argv[6])
jdis = "Jdis010"
# final_J = float(sys.argv[5])
# space_J = float(sys.argv[6])

# dimer = str(sys.argv[7])
dim = "Dim005"
# final_D = float(sys.argv[8])
# space_D = float(sys.argv[9])

# initial_Seed = int(sys.argv[8])
# final_Seed = int(sys.argv[9])
initial_Seed = 1 
final_Seed = 20

print("spin:",spin)
print("BC:",BC)
print("Prob:",probDis)
print("chi:",chi)
print("L:",L)
print("Jdis",jdis)
print("Dim",dim)
print("initial_Seed",initial_Seed)
print("final_Seed",final_Seed)

# Ls = []
# Jdis = []
# Dim = []

# if(space_J == 0):
#     Jdis.append( 'Jdis' + str(round( 100*(initial_J))).zfill(3) )
# else:
#     for k in range ( round((final_J - initial_J)/space_J) + 1 ):
#         Jdis.append( 'Jdis' + str(round( 100*(initial_J + k * space_J ))).zfill(3) )

# if(space_D == 0):
#     Dim.append( 'Dim' + str(round( 100*(initial_D))).zfill(3) )
# else:
#     for k in range ( round((final_D - initial_D)/space_D) + 1 ):
#         Dim.append( 'Dim' + str(round( 100*(initial_D + k * space_D ))).zfill(3) )

# if(space_L == 0):
#     Ls.append( initial_L )    
# else:
#     for k in range ( round((final_L - initial_L)/space_L) + 1 ):
#         Ls.append( initial_L + space_L*k )    

# final_seed = np.zeros([len(Ls),len(Jdis),len(Dim)],dtype=int)
# seedRange = np.linspace(final_Seed, 0, 11, dtype=int)

# for l in range(len(Ls)):
#     L = Ls[l]
#     for j in range(len(Jdis)):
#         jdis = Jdis[j]
#         for d in range(len(Dim)):
#             dimer = Dim[d]
#             D = float(Dim[d][3] + '.' + Dim[d][4] + Dim[d][5])
#             for k in seedRange:
#                 myfile = '/home/aronton/tSDRG_project/tSDRG/Main_1/data/'+ BC +'/'+ jdis + '/'+ dimer + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(k) + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(k) + '_string.csv'
#                 if(os.path.exists(myfile)):
#                     final_seed[l,j,d] = k
# print(Ls)
# print(Jdis)
# print(Dim)
# print(initial_Seed)
# print(tot_Seed)

# for i in range(len(Ls)):
    # L = Ls[i]
    # for j in range(len(Jdis)):
        # jdis = Jdis[j]
        # for d in range(len(Dim)):
            # dimer = Dim[d]

direc1 = '/home/aronton/tSDRG_project/Sorting_data/Spin' + str(spin) + '/metadata/'
print(direc1)
if (os.path.exists(direc1) == False):
    os.mkdir(direc1)
direc2 =  direc1 + 'Corr1_Accumulation/'
print(direc2)
if (os.path.exists(direc2) == False):
    os.mkdir(direc2)
direc3 =  direc2 + jdis +'/'
print(direc3)
if (os.path.exists(direc3) == False):
    os.mkdir(direc3)
direc4 =  direc3 + dim +'/'
print(direc4)
if (os.path.exists(direc4) == False):
    os.mkdir(direc4)

path_initial = direc4 +'Corr1_Accumulation_' + jdis + "_" + dim + "_" + "finalSeed_" + str(initial_Seed-1) + '_' + BC +'_L'+ str(L) +'_P' + str(probDis) + '_m'+ str(chi) + '.csv'

path_final = direc4 +'Corr1_Accumulation_' + jdis + "_" + dim + "_" + "finalSeed_" + str(final_Seed) + '_' + BC +'_L'+ str(L) +'_P' + str(probDis) + '_m'+ str(chi) + '.csv'


die_seed_path_initial = direc4 +'Corr1_Die_Seed_' + jdis + "_" + dim + "_" + "finalSeed_" + str(initial_Seed-1) + '_' + BC +'_L'+ str(L) +'_P' + str(probDis) + '_m'+ str(chi) + '.csv'

die_seed_path_final = direc4 +'Corr1_Die_Seed_' + jdis + "_" + dim + "_" + "finalSeed_" + str(final_Seed) + '_' + BC +'_L'+ str(L) +'_P' + str(probDis) + '_m'+ str(chi) + '.csv'


direc1_ave = '/home/aronton/tSDRG_project/Sorting_data/Spin' + str(spin) + '/metadata/'
print(direc1_ave)
if (os.path.exists(direc1_ave) == False):
    os.mkdir(direc1_ave)
direc2_ave =  direc1_ave + 'Corr1_Average/'
print(direc2_ave)
if (os.path.exists(direc2_ave) == False):
    os.mkdir(direc2_ave)
direc3_ave =  direc2_ave + jdis +'/'
print(direc3_ave)
if (os.path.exists(direc3_ave) == False):
    os.mkdir(direc3_ave)
direc4_ave =  direc3_ave + dim +'/'
print(direc4_ave)
if (os.path.exists(direc4_ave) == False):
    os.mkdir(direc4_ave)

averge_path = direc4_ave +'Corr1_Average_' + jdis + "_" + dim + "_" + "finalSeed_" + str(final_Seed) + '_' + BC +'_L'+ str(L) +'_P' + str(probDis) + '_m'+ str(chi) + '.csv'

print("path_initial:")
print(path_initial)
print("path_final:")
print(path_final)

averageFrame = pd.DataFrame(columns = ['Corr1', 'error', 'Nseed', 'Nsample'])
print("averageFrame",averageFrame)

start = time.time()
print("start time:")
print(time.ctime())
print(start)

if(L <= 16):
    siteInterval = np.linspace(1,L//2,L//2,dtype=int)
    for s in siteInterval:
        outputNumpy = np.array([0,0,0,0], dtype = float)
        averageFrame = pd.DataFrame(columns = ['corr1', 'error', 'Nseed', 'Nsample'])
        # outputframe = pd.DataFrame(columns = ['s1-s2=%d' %(spinInterval[s]), 'error', 'Nseed', 'Nsample'])
        Nsample = 0
        for seed in range(final_Seed):
            myfile = '/home/aronton/tSDRG_project/tSDRG/Main_15/data/'+ BC +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(probDis) +'_m'+ str(chi) +'_'+ str(seed) + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(seed) + 'corr1.csv'
            if(os.path.exists(myfile)):
                Nsample = Nsample + 1
                inputFrame = pd.read_csv(myfile)
                inputNumpy = inputFrame.values[s-1,:]
                np.insert(outputNumpy ,seed+1 ,inputNumpy ,axis=0)
                # outputFrame = outputFrame.append(inputFrame.s, ignore_index=True)
            else:
                die_seed_array[k] = k+1
        average = np.average(outputNumpy)
        std = np.std(outputNumpy, ddof=1)
        error = std / np.sqrt(np.size(outputNumpy))
        averageFrame.loc[0,:] = [average, error, final_Seed, Nsample]
else:
    siteInterval = np.linspace(1,L//2,L//2,dtype=int)
    for s in siteInterval:
        outputNumpy = np.array([0,0,0,0], dtype = float)
        averageFrame = pd.DataFrame(columns = ['corr1', 'error', 'Nseed', 'Nsample'])
        # outputframe = pd.DataFrame(columns = ['s1-s2=%d' %(spinInterval[s]), 'error', 'Nseed', 'Nsample'])
        Nsample = 0
        if(s <= 10):
            for seed in range(final_Seed):
                myfile = '/home/aronton/tSDRG_project/tSDRG/Main_15/data/'+ BC +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(probDis) +'_m'+ str(chi) +'_'+ str(seed) + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(seed) + 'corr1.csv'
                if(os.path.exists(myfile)):
                    Nsample = Nsample + 1
                    inputFrame = pd.read_csv(myfile)
                    inputNumpy = inputFrame.values[s-1,2]
                    np.insert(outputNumpy ,seed+1 ,inputNumpy ,axis=0)
                    # outputFrame = outputFrame.append(inputFrame.s, ignore_index=True)
                else:
                    die_seed_array[k] = k+1
            average = np.average(outputNumpy)
            std = np.std(outputNumpy, ddof=1)
            error = std / np.sqrt(np.size(outputNumpy))
            averageFrame.loc[0,:] = [average, error, final_Seed, Nsample]
        else:
            for seed in range(final_Seed):
                myfile = '/home/aronton/tSDRG_project/tSDRG/Main_15/data/'+ BC +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(probDis) +'_m'+ str(chi) +'_'+ str(seed) + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(seed) + 'corr1.csv'
                if(os.path.exists(myfile)):
                    rowIndex = s - 1
                    Nsample = Nsample + 1
                    inputFrame = pd.read_csv(myfile)
                    inputNumpy = inputFrame.values[rowIndex,2]
                    np.insert(outputNumpy ,seed+1 ,inputNumpy ,axis=0)
                    while(rowIndex <= len(inputNumpy[:,0])):
                        rowIndex = L//2 - 1 + s -10
                        Nsample = Nsample + 1
                        inputFrame = pd.read_csv(myfile)
                        inputNumpy = inputFrame.values[rowIndex,2]
                        np.insert(outputNumpy ,seed+1 ,inputNumpy ,axis=0)    
                        rowIndex = rowIndex + L//2 - 9             
                    # outputFrame = outputFrame.append(inputFrame.s, ignore_index=True)
                else:
                    die_seed_array[k] = k+1
            average = np.average(outputNumpy)
            std = np.std(outputNumpy, ddof=1)
            error = std / np.sqrt(np.size(outputNumpy))
            averageFrame.loc[0,:] = [average, error, final_Seed, Nsample]            


            # D = float(Dim[d][3] + '.' + Dim[d][4] + Dim[d][5])
            # x = 0

            # Frame to be saved in final
            # outputFrame = pd.DataFrame(columns = ['O^z', 'error', 'Nseed', 'Nsample'])

            # check how many seed to average 
            # for k in seedRange:
            #     if(k == 0):
            #         print("No data")
            #         os._exit(0)
            #     myfile = '/home/aronton/tSDRG_project/tSDRG/Main_15/data/'+ BC +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(k) + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(k) + '_string.csv'
            #     if(os.path.exists(myfile)):
            #         final_seed = k
            #         break

            # Nsample = final_seed
            # Valuelist = [] # list used to stored data which will be averaged later

            # if(L <= 16):

            #     print( "L=", L )
            #     print( "J=", jdis )
            #     print( "D=", dimer )

            #     for k in range(initial_Seed, final_seed + 1):
            #         myfile = '/home/aronton/tSDRG_project/tSDRG/Main_15/data/'+ BC +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(k) + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(k) + '_string.csv'
            #         if(os.path.exists(myfile)):
            #             # Frame used to get data
            #             inputFrame = pd.read_csv(myfile)
            #             Valuelist.append(inputFrame['corr'][0])

            #     Nsample = np.size(Valuelist)
            #     average = np.average(Valuelist)
            #     error = np.std(Valuelist) / np.sqrt(Nsample)    
            #     outputFrame.loc[0] = {'O^z':average,'error':error, 'Nseed':final_seed, 'Nsample':Nsample}
            # else:
            #     seedArray = []
            #     valueeArray = []
            #     meanArray = [] # since as L>16 there will be more than one Oz in each running, this list store the mean values of each dataframe
            #     variance = 0

            #     for k in range(initial_Seed, final_seed + 1):
            #         myfile = '/home/aronton/tSDRG_project/tSDRG/Main_15/data/'+ BC +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(k) + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(k) + '_string.csv'
            #         if(os.path.exists(myfile)):
            #             seedArray.append(k)
            #             inputFrame = pd.read_csv(myfile)
            #             meanArray.append(inputFrame['corr'].mean())

            #     Nsample = np.size(seedArray)*L/2 # since as L>16 the code will get be more than one sample  in each running
            #     average = np.average(meanArray) # get the mean value of all seed

            #     for k in seedArray:
            #         myfile = '/home/aronton/tSDRG_project/tSDRG/Main_15/data/'+ BC +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(k) + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(k) + '_string.csv'
            #         inputFrame = pd.read_csv(myfile)
            #         for l in range(int(L/2)):
            #             variance += np.square(inputFrame['corr'][l] - average)      

            #     variance = variance/(Nsample)
            #     error = np.sqrt(variance) / np.sqrt(Nsample)    
            #     outputFrame.loc[0] = {'O^z':average,'error':error, 'Nseed':final_seed, 'Nsample':Nsample}
                
            # direc = '/home/aronton/tSDRG_project/Sorting_data/Spin15/metadata/SOP/'+ jdis +'/'
            # if (os.path.exists(direc) == False):
            #     os.mkdir(direc)
            # direc1 =  direc + dim
            # if (os.path.exists(direc1) == False):
            #     os.mkdir(direc1)
            # path = direc1 +'/'+ BC +'_L'+ str(L) +'_P' + str(P) + '_m'+ str(M) +'_SOP' + '.csv'
            # outputFrame.to_csv(path,index=0)

end = time.time()
print("end time:")
print(time.ctime())
print(end)

print("tot_time:",end-start)

print("Nsample",Nsample)
print("average",average)
print("std",std)
print("error",error)

print("outputFrame:\n")
print(outputFrame)
outputFrame.to_csv(path_final, index=False)
print("averageFrame:\n")
print(averageFrame)
averageFrame.to_csv(averge_path, index=False)
print("die_seed:\n")
die_seed.to_csv(die_seed_path_final, index=False)
# np.save("sopMetadataArray" +".npy", final_seed)

# final_seedFrame = []
# for k in range(len(L)):
#     final_seedFrame.append( pd.DataFrame( final_seed[k,:,:], columns = Dim, index = Jdis, dtype = int))

# sopMetadataExcel = pd.ExcelWriter('sopMetadataArray.xlsx', engine='xlsxwriter')

# for k in range(Ls):
#     final_seedFrame[k].to_excel(sopMetadataExcel, sheet_name= str(k))

# sopMetadataExcel.save()


print('all done')