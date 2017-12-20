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
kblock=2

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
#---RUN EXTENDING WINDOW METHOD--------
load('ewm.sage')
