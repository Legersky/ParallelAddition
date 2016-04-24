#------------INPUTS---------------------
#Name of the numeration system:
name = 'base_10'
#Minimal polynomial of ring generator (use variable x):
minPol ='x - 1'
#Embedding (the closest root of the minimal polynomial to this value is taken as the ring generator):
omegaCC= 1
#Alphabet (use 'omega' as ring generator):
alphabet = '[-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]'
#Input alphabet (if empty, A + A is used):
inputAlphabet = ''
#Base (use 'omega' as ring generator):
base ='10*omega'

#------------SETTING--------------------
max_iterations = 20      #maximum of iterations in searching for the weight coefficient set
max_input_length = 10    #maximal length of the input of the weight function
sanityCheck=False        #run sanity check

#------------SAVING---------------------
info=True                #save general info to .tex file
WFcsv=False              #save weight function to .csv file
localConversionCsv=False #save local conversion to .csv file
saveSetting=False        #save inputs setting as a dictionary
saveLog=True             #save log file
saveUnsolved=False       #save unsolved combinations after interruption

#------------IMAGES--------------------
alphabet_img=True        #save image of alphabet and input alphabet
lattice_img=True         #save image of lattice
phase1_images=True       #save images of steps of phase 1
weightCoefSet_img=True   #save image of the weight coefficient set with the estimation given by lemma:
estimation=True
phase2_images=True       #save images of steps of phase 2 for the input:
phase2_input='(omega,2,omega,2,omega,2,omega,2)'