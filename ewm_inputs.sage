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
#k-block
kblock=1

#------------EWM SETTING----------------
methods_phase1=['1a', '1d']     #methods in the list are used. If empty, default method is used. (See the description below)
methods_phase2=['2c', '2d']     #methods in the list are used. If empty, default method is used. (See the description below)
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
#---RUN EXTENDING WINDOW METHOD--------
load('ewm.sage')


#------------methods Phase 1--------------------------------------
# 1a (= 14) - takes first the only possible candidates and all in non-covered lists
# 1b (= 12) -  takes first the only possible candidates and then add all smallest elements (absolute value)
# 1c (= 16) - chooses all smallest elements (absolute value)
# 1d (= 13) - takes first the only possible candidates and then add all smallest elements (natural norm) (default)
# 1e (= 15) - chooses all smallest elements (in beta-norm)

# experimental:
# 1 - chooses the smallest element (the embedding to CC is necessary here)
# 2 - takes first the only possible candidates and then chooses the smallest element (in absolute value, the embedding to CC is necessary here) - dependent on order of digits in alphabet!!!
# 3 - takes first the only possible candidates and then chooses the smallest element in the natural norm  - dependent on order of digits in alphabet!!!
# 4 - weight coefficients set given by bound (norm) DO NOT USE
# 5 - weight coefficients set given by bound (abs) DO NOT USE
# 6 - takes first the only possible candidates and all in non-covered lists - implementation dependent
# 7 == 9, but A+A is taken even if the input alphabet is different
# 8 -  takes first the only possible candidates and then add all smallest elements (absolute value) - implementation dependent
# 9 - takes first the only possible candidates and then add all smallest elements (natural norm) - implementation dependent
# 10 - chooses all smallest elements (in beta-norm) - implementation dependent
# 11 - chooses all smallest elements (absolute value) - implementation dependent


#------------methods Phase 2--------------------------------------
# 2a (= 9)  - pick element from all resting list which is the closest (in absolute value) to center of gravity of points in all resting lists
# 2b (= 15) - pick element from the shortest lists which is closest to already added (absolute value)
# 2c (= 22) - pick element from the shortest lists which is the smallest (in absolute value)
# 2d (= 23) - pick element from the shortest lists which is the smallest (beta-norm)
# 2e (= 14) - pick element from those with highest occurrencies, which is the closest to the center of gravity of already added (in absolute value)

# experimental:
# 0 - add the first element in the first shortest list (implementation dependent)
# 1 - find the smallest covering coefficients from the shortest lists (really slow !!!)
# 2 - random from the shortest lists
# 3 - pick element from the shortest lists lexicographically according to coordinates in lattice
# 4 - pick element from the shortest list which is the closest (according to lattice) to rounded center of gravity of points in shortest lists (default)
# 5 - pick element from all resting list which is the closest (according to lattice) to rounded center of gravity of points in all resting lists
# 6 - find the smallest covering coefficients from all resting lists (really slow !!!)
# 7 - pick element from the shortest list which is the closest (in absolute value) to rounded center of gravity of points in shortest lists
# 8 - pick element from the shortest list which is the closest (in absolute value) to center of gravity of points in shortest lists
# 10 - each value covered separately by the point closest to point of gravity of covering values - deleted
# 11 - pick element from the shortest lists which is the smallest (in absolute value) - implementation dependent
# 12 - pick element from the shortest lists which is the smallest (beta-norm) - implementation dependent
# 13 - pick element from those with highest occurrencies, which is the closest to 0 in beta-norm
# 16 - pick element from those with highest occurrencies, which is the closest to center of gravity of already added (in beta norm)
# 17 - pick element from all resting which is the closest (in beta norm) to the center of gravity of already added
# 18 - pick element according to covering by alphabets
# 19 - pick more elements according to covering by alphabets
# 20 - another way to pick an element according to covering by alphabets
# 21 - pick element from the shortest lists which is closest to already added (beta norm)
