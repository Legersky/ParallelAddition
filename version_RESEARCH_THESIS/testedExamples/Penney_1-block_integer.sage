#---------------INPUTS---------------
#Name of the numeration system
name = 'Penney_1-block_integer'

#Minimal polynomial of ring generator (use variable x)
minPol =' x^2 + 1 '

#Embedding (the closest root of minimal polynomial to this value is taken as the ring generator)
omegaCC= 1.00000000000000*I

#Alphabet (use 'omega' as ring generator)
alphabet = '[0, 1, -1, 2, -2]'

#Input alphabet (if empty, A + A is used)
inputAlphabet = ''

#Base (use 'omega' as ring generator)
base =' omega - 1 '

#------------LIMITATIONS----------------
#maximum of iterations in searching weight coefficient set
max_iterations = 20

#maximal length of input of weight function
max_input_length =  10
sanityCheck=True        #run sanity check

#------------SAVING---------------------
info=True                #save general info to .tex file
WFcsv=True              #save weight function to .csv file
localConversionCsv=True #save local conversion to .csv file
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
