import os
import math
import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt 
from scipy.optimize import curve_fit
import time
import sys



spin = int(sys.argv[1])
BC = str(sys.argv[2])
P = int(sys.argv[3])
M = int(sys.argv[4])

initial_L = int(sys.argv[5])
final_L = int(sys.argv[6])
space_L = int(sys.argv[7])

initial_J = float(sys.argv[8])
final_J = float(sys.argv[9])
space_J = float(sys.argv[10])

initial_D = float(sys.argv[11])
final_D = float(sys.argv[12])
space_D = float(sys.argv[13])

initial_Seed = int(sys.argv[14])
checkRangeFinalSeed = int(sys.argv[15])
deltaSeed = int(sys.argv[16])


Jdis = []
Dim = []
Ls = []

if(space_J == 0):
    Jdis.append( 'Jdis' + str(round( 100*(initial_J))).zfill(3) )
else:
    for k in range ( round((final_J - initial_J)/space_J) + 1 ):
        Jdis.append( 'Jdis' + str(round( 100*(initial_J + k * space_J ))).zfill(3) )
        # if(initial_J<>0):
        #     Jdis.append( 'Jdis' + str(round( 100*(initial_J + k * space_J ))).zfill(3) )
        # else:
            

if(space_D == 0):
    if(final_D < 0):
        Dim.append( 'DimN' + str(round( 100*(initial_D))).zfill(3) )
    else:
        Dim.append( 'Dim' + str(round( 100*(initial_D))).zfill(3) )
else:
    if(final_D < 0):
        Dminus = "Y"
        if(abs(final_D) > abs(initial_D)):
            final_D = abs(final_D)
            initial_D = abs(initial_D)
        for k in range ( round((final_D - initial_D)/space_D) + 1 ):
            Dim.append( 'DimN' + str(round( 100*(initial_D + k * space_D ))).zfill(3) )
    else:
        Dminus = "N"
        for k in range ( round((final_D - initial_D)/space_D) + 1 ):
            Dim.append( 'Dim' + str(round( 100*(initial_D + k * space_D ))).zfill(3) )

if(space_L == 0):
    Ls.append( initial_L )    
else:
    for k in range ( round((final_L - initial_L)/space_L) + 1 ):
        Ls.append( initial_L + space_L*k )   

# Jdis = ["Jdis050","Jdis100","Jdis130","Jdis150","Jdis180","Jdis200"]
# Ls = [16,32,48,64,80,96,128,160,192,256,384,448,512]


final_seed = np.zeros([len(Ls),len(Jdis),len(Dim)],dtype=int)
final_seed_reverse = np.zeros([len(Ls),len(Jdis),len(Dim)],dtype=int)
# seedRange = np.linspace(0, checkRangeFinalSeed, 11, dtype=int)
seedRangeReverse = np.linspace(checkRangeFinalSeed, 0, checkRangeFinalSeed//deltaSeed + 1, dtype=int)
seedRangeReverse[-1] = 1


print(Jdis)
print(Dim)
print(Ls)
# print(seedRange)
print(seedRangeReverse)




for l in range(len(Ls)):
    L = Ls[l]
    for j in range(len(Jdis)):
        jdis = Jdis[j]
        for d in range(len(Dim)):
            if(Dminus == "Y"):
                dimer = Dim[d]
                D = float(Dim[d][4] + '.' + Dim[d][5] + Dim[d][6])
            else:
                dimer = Dim[d]
                D = float(Dim[d][3] + '.' + Dim[d][4] + Dim[d][5])                
            # myfileMeta = '/home/aronton/tSDRG_project/Sorting/Spin' + str(spin) + '/metadata/ZL'+ jdis + '/'+ dimer + '/' + BC + '_L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_ZL' + '.csv'
            # if(os.path.exists(myfileMeta)):
            #      final_seed[l,j,d] = myfileMeta['Nseed'][0]
            # for k in seedRange:
            #     myfile = '/home/aronton/tSDRG_project/tSDRG/Main_' + str(spin) + '/data/'+ BC +'/'+ jdis + '/'+ dimer + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(k) + '/' + 'energy.csv'
            #     if(os.path.exists(myfile)):
            #         print(myfile)
            #         final_seed[l,j,d] = k
            #         print("final_seed[l,j,d]",final_seed[l,j,d])
            #         print("k",k)
            #     else:
            #         break
            if(BC == "PBC"):
                for k in seedRangeReverse:
                    myfile = '/home/aronton/tSDRG_random/tSDRG/Main_' + str(spin) + '/data_random/'+ BC +'/'+ jdis + '/'+ dimer + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(k) + '/' + 'L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(k) + "_corr1.csv"
                    # print("myfile:",myfile)
                    if(os.path.exists(myfile)):
                        final_seed_reverse[l,j,d] = k
                        print("final_seed_reverse[l,j,d] = ",final_seed_reverse[l,j,d])
                        print("myfile:",myfile)
                        # print("kk",k)
                        break
            else:
                for k in seedRangeReverse:
                    myfile = '/home/aronton/tSDRG_random/tSDRG/Main_' + str(spin) + '/data_random/'+ BC +'/'+ jdis + '/'+ dimer + '/L'+ str(L) +'_P'+ str(P) +'_m'+ str(M) +'_'+ str(k) + '/' + "corr1_etoe.csv"
                    # print("myfile:",myfile)
                    if(os.path.exists(myfile)):
                        final_seed_reverse[l,j,d] = k
                        print("final_seed_reverse[l,j,d] = ",final_seed_reverse[l,j,d])
                        print("myfile:",myfile)
                        # print("kk",k)
                        break                
                
fileName = "seedArray" + str(spin) + "_reverse_random_" + "range_" + str(1) + "_" + str(checkRangeFinalSeed) + "_BC_" + str(BC) + "_J=" + str(initial_J) + "_" + str(final_J) + "_(" + str(space_J) + ")_D=" + str(initial_D) + "_" + str(final_D) + "_(" + str(space_D) + ")_L=" + str(initial_L) + "_" + str(final_L) + "_(" + str(space_L) + ")"

# np.save("./Spin" + str(spin) + "/checkXlsx/" + fileName + ".npy", final_seed_reverse)

print("fileName",fileName)

print(final_seed_reverse)

seedArrayFrame = []

for k in range(len(Ls)):
    seedArrayFrame.append( pd.DataFrame( final_seed_reverse[k,:,:], columns = Dim, index = Jdis, dtype = int))

seedArrayxlsx = pd.ExcelWriter("/home/aronton/tSDRG_random/tSDRG/check/Spin" + str(spin) + "/checkXlsx/" + fileName + ".xlsx", engine='xlsxwriter')

for k in range(len(Ls)):
    seedArrayFrame[k].to_excel(seedArrayxlsx, sheet_name= str(Ls[k]))

seedArrayxlsx.save()

# np.save("seedArrayReverse" + str(spin) + "range_" + str(1) + "_" + str(checkRangeFinalSeed) + ".npy", final_seed_reverse)

# print(final_seed_reverse)

# seedArrayReverseFrame = []

# for k in range(len(Ls)):
#     seedArrayReverseFrame.append( pd.DataFrame( final_seed_reverse[k,:,:], columns = Dim, index = Jdis, dtype = int))

# seedArrayReversexlsx = pd.ExcelWriter("seedArrayReverse" + str(spin) + "range_" + str(1) + "_" + str(checkRangeFinalSeed) + ".xlsx", engine='xlsxwriter')

# for k in range(len(Ls)):
#     seedArrayReverseFrame[k].to_excel(seedArrayReversexlsx, sheet_name= str(Ls[k]))

# seedArrayReversexlsx.save()
#record = open("./" + str(final_Seed) + ".txt", 'w')
#record.writelines( str(time.localtime()) + "\n" )

#originArray = pd.read_excel("/home/aronton/tSDRG_project/tSDRG/SeedArray2000.xlsx", sheet_name = None)

# if( initial_Seed == 1 ):
#     seedArray = np.zeros((len(L), len(Jdis), len(Dim)), dtype = int)
#     for l in range( len(L) ):
#         print("L:",L[l])
#         print("\n\n")
#         for i in range( len(Jdis) ):
#             print("J:", Jdis[i])
#             print("\n\n")
#             for j in range( len(Dim) ):
#                 print("D:", Dim[j])
#                 print("\n\n")

#                 filePath = '/home/aronton/tSDRG_project/tSDRG/Main_1/data/PBC/' + Jdis[i] + '/' + Dim[j] + '/L' + str(L[l]) + '_P10_m30_' 

#                 if ( os.path.exists(filePath + str(10000) + '/energy.csv') ):
#                     seedArray[l,i,j] = 10000
#                     print("10000\n")
#                 elif ( os.path.exists(filePath + str(8000) + '/energy.csv') ):
#                     seedArray[l,i,j] = 8000
#                     print("8000\n")
#                 elif ( os.path.exists(filePath + str(6000) + '/energy.csv') ):
#                     seedArray[l,i,j] = 6000
#                     print("6000\n")
#                 elif ( os.path.exists(filePath + str(4000) + '/energy.csv') ):
#                     seedArray[l,i,j] = 4000
#                     print("4000\n")
#                 elif ( os.path.exists(filePath + str(2000) + '/energy.csv') ):
#                     seedArray[l,i,j] = 2000
#                     print("2000\n")
#                 else:
#                     seedArray[l,i,j] = 0
#                     print("0\n")

                
# else:
#     seedArray = np.load("seedArray" +str(initial_Seed - 1) + ".npy")
#     for l in range( len(L) ):
#         for i in range( len(Jdis) ):
#             for j in range( len(Dim) ):
#                 if seedArray[l,i,j] == 0:
#                     continue
#                 initial_Seed = seedArray[l,i,j] + 1
#                 for k in range(initial_Seed, final_Seed + 1):
#                     filePath = '/home/aronton/tSDRG_project/tSDRG/Main_1/data/PBC/' + Jdis[i] + '/' + Dim[j] + '/L' + str(L[l]) + '_P10_m30_' + str(k)
#                     if( os.path.exists(filePath + '/energy.csv') ):
#                         seedArray[l,i,j] = seedArray[l,i,j] + 1

#     np.save("seedArray" + str(final_Seed) +".npy", seedArray)
#     seedArrayFrame = []

#     for k in range(len(L)):
#         seedArrayFrame.append( pd.DataFrame( seedArray[k,:,:], columns = Dim, index = Jdis, dtype = int))

#     seedArray = pd.ExcelWriter("seedArray" + str(final_Seed) + ".xlsx", engine='xlsxwriter')

#     for k in range(4):
#         seedArrayFrame[k].to_excel(seedArray, sheet_name= str(16*(k+1)))

#     seedArray.save()

#originArray.DataFrame.to_excel("/home/aronton/tSDRG_project/tSDRG/SeedArray" + str(final_Seed) + ".xlsx")
#record.writelines( "done\n" )
#record.writelines( str(time.localtime()) + "\n" )
#record.close
