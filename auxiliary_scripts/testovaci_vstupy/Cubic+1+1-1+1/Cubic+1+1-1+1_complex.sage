#------------INPUTS---------------------
#Name of the numeration system
name = 'Cubic+1+1-1+1_complex'
#Minimal polynomial of ring generator (use variable x)
minPol ='x^3+x^2 - 1*x + 1'
#Embedding (the closest root of the minimal polynomial to this value is taken as the ring generator)
omegaCC= -1000
#Alphabet (use 'omega' as ring generator)
alphabet = '[0, omega + 1, omega + 2, -omega - 1, -omega - 2]'
#Input alphabet (if empty, A + A is used)
inputAlphabet = ''
#Base (use 'omega' as ring generator)
base ='omega'

#------------LIMITATIONS----------------
max_iterations = 40      #maximum of iterations in searching for the weight coefficient set
max_input_length = 15    #maximal length of the input of the weight function

#------------SANITY CHECK---------------
sanityCheck=False         #run sanity check

#------------SAVING---------------------
info=True                #save general info to .tex file
WFcsv=False              #save weight function to .csv file
localConversionCsv=False #save local conversion to .csv file
saveSetting=False        #save inputs setting as a dictionary
saveLog=True             #save log file
saveUnsolved=False       #save unsolved combinations after interruption

#------------IMAGES--------------------
alphabet_img=True        #save image of alphabet and input alphabet
lattice_img=True         #save image of lattice with shifted alphabet
phase1_images=True       #save step-by-step images of phase 1
weightCoefSet_img=True   #save image of the weight coefficient set
#with estimation given by lemma:
estimation=True
phase2_images=True       #save step-by-step images of phase 2
#for input:
phase2_input='(omega,1,omega,1,omega,1,omega,1)'