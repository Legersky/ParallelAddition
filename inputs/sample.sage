#---------------INPUTS---------------
#Name of the numeration system
name = 'ctyri'

#Minimal polynomial of ring generator (use variable x)
minPol ='x - 1'

#Embedding (the closest root of minimal polynomial to this value is taken as the ring generator)
omegaCC= 1

#Alphabet (use \'omega\' as ring generator)
alphabet =  '[-2, -1, 0, 1, 2]'

#Input alphabet (if empty, A + A is used)
inputAlphabet = ''

#Base (use \'omega\' as ring generator)
base = '4'

#Or you can load setting from the file (in folder /examples):
setting_name = ''



#------------SAVING----------------
#save general info to .tex file
info=True

#save Weight function to .csv file
WFcsv=True

#save Local conversion to .csv file
localConversionCsv=False

#save Inputs setting
saveSetting=True

#save Log file
saveLog=True

#save Unsolved inputs after interruption
saveUnsolved=True

#run sanity check
sanityCheck=True
len_inp =  3     #Number of digits for sanity check
