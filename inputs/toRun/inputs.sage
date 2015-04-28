#Loading
name = 'eisenstein'                    #Name of the numeration system
minPol ='x^2 + x + 1'                    #Minimal polynomial of ring generator (use variable x)
omegaCC= -1/2 + I*sqrt(3)/2         #Embedding (the closest root of minimal polynomial to this value is taken as the ring generator)
alphabet =  '[0,1, -1,omega, -omega, omega^2, -omega^2]'     #Alphabet (use \'omega\' as ring generator)
inputAlphabet = ''               #Input alphabet (if empty, A + A is used)
base = 'omega-1'                 #Base (use \'omega\' as ring generator)
setting_name = 'ctyri'                #Or you can load setting from the file (in folder /examples):

info=True     #General info to .tex file
WFcsv=True      #Weight function to .csv file
localConversionCsv=False     #Local conversion to .csv file
saveSetting=True     #Inputs setting
saveLog=True     #Log file
saveUnsolved=True     #Unsolved inputs after interruption
sanityCheck=True
len_inp =  3     #Number of digits for sanity check
