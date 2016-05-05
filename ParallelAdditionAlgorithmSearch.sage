#------------INPUTS---------------------
#Name of the numeration system
name = 'Eisenstein_1-block_complex'
#Minimal polynomial of ring generator (use variable x)
minPol ='x^2 + x + 1'
#Embedding (the closest root of the minimal polynomial to this value is taken as the ring generator)
omegaCC= -0.5 + 0.8*I
#Alphabet (use 'omega' as ring generator)
alphabet = '[0, 1, -1, omega, -omega, -omega - 1, omega + 1]'
#Input alphabet (if empty, A + A is used)
inputAlphabet = ''
#Base (use 'omega' as ring generator)
base ='omega - 1'

#------------EWM SETTING----------------
methods_phase1=['1a', '1d']     #methods in the list are used. If empty, default method is used.
methods_phase2=['2c', '2d']     #methods in the list are used. If empty, default method is used.
#Cartesian product of lists methods_phase1 and methods_phase2 is computed

#------------SANITY CHECK---------------
sanityCheck=False        #run sanity check

#------------SAVING---------------------
info=True                #save general info to .tex file
WFcsv=False              #save weight function to .csv file
localConversionCsv=False #save local conversion to .csv file
saveLog=True             #save log file

#------------IMAGES--------------------
alphabet_img=False      #save image of alphabet and input alphabet
phase1_images=False     #save step-by-step images of Phase 1
weightCoefSet_img=False #save image of the weight coeff. set
phase2_images=False     #save step-by-step images of Phase 2 for input:
phase2_input='(omega,1,omega,1,omega,1,omega,1)'

#-----------Methods Phase 1---------------------------------------
# 1 - chooses the smallest element (the embedding to CC is necessary here)  - implementation dependent
# 2 - takes first the only possible candidates and then chooses the smallest element (in absolute value, the embedding to CC is necessary here) - dependent on order of digits in alphabet!!!
# 3 - takes first the only possible candidates and then chooses the smallest element in the natural norm  - dependent on order of digits in alphabet!!!
# 4 - weight coefficients set given by bound (norm) - do not use
# 5 - weight coefficients set given by bound (abs) - do not use
# 6 - takes first the only possible candidates and all in non-covered lists - implementation dependent
# 7 == 9, but A+A is taken even if the input alphabet is different
# 8 -  takes first the only possible candidates and then add all smallest elements (absolute value) - implementation dependent
# 9 - takes first the only possible candidates and then add all smallest elements (natural norm) - implementation dependent
# 10 - chooses all smallest elements (in beta-norm) - implementation dependent
# 11 - chooses all smallest elements (absolute value) - implementation dependent
# 12 = 1b -  takes first the only possible candidates and then add all smallest elements (absolute value)
# 13 = 1d - takes first the only possible candidates and then add all smallest elements (natural norm) (default) 
# 14 = 1a - takes first the only possible candidates and all in non-covered lists
# 15 = 1e - chooses all smallest elements (in beta-norm)
# 16 = 1c - chooses all smallest elements (absolute value)

#-----------Methods Phase 2---------------------------------------
# 0 - add the first element in the first shortest list (implementation dependent)
# 1 - find the smallest covering coefficients from the shortest lists (really slow !!!)
# 2 - random from the shortest lists
# 3 - pick element from the shortest lists lexicographically according to coordinates in lattice
# 4 - pick element from the shortest list which is the closest (according to lattice) to rounded center of gravity of points in shortest lists (default)
# 5 - pick element from all resting list which is the closest (according to lattice) to rounded center of gravity of points in all resting lists
# 6 - find the smallest covering coefficients from all resting lists (really slow !!!)
# 7 - pick element from the shortest list which is the closest (in absolute value) to rounded center of gravity of points in shortest lists
# 8 - pick element from the shortest list which is the closest (in absolute value) to center of gravity of points in shortest lists
# 9 = 2a - pick element from all resting list which is the closest (in absolute value) to center of gravity of points in all resting lists
# 10 - each value covered separately by the point closest to point of gravity of covering values - deleted
# 11 - pick element from the shortest lists which is the smallest (in absolute value) - implementation dependent
# 12 - pick element from the shortest lists which is the smallest (beta-norm) - implementation dependent
# 13 - pick element from those with highest occurrencies, which is the closest to 0 in beta-norm
# 14 = 2e - pick element from those with highest occurrencies, which is the closest to the center of gravity of already added (in absolute value)
# 15 = 2b - pick element from the shortest lists which is closest to already added (absolute value)
# 16 - pick element from those with highest occurrencies, which is the closest to center of gravity of already added (in beta norm)
# 17 - pick element from all resting which is the closest (in beta norm) to the center of gravity of already added
# 18 - pick element according to covering by alphabets
# 19 - pick more elements according to covering by alphabets
# 20 - another way to pick an element according to covering by alphabets
# 21 - pick element from the shortest lists which is closest to already added (beta norm)
# 22 = 2c - pick element from the shortest lists which is the smallest (in absolute value)
# 23 = 2d - pick element from the shortest lists which is the smallest (beta-norm)

#---RUN EXTENDING WINDOW METHOD--------
load_attach_path('~')

load_attach_path('/home/legerjan/ParallelAddition')
load_attach_path('/home/legerjan/ParallelAddition/classes')

folder_path='./'
load('ewm.sage')
