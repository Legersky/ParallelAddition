#---------------INPUTS---------------
#Name of the numeration system
name = 'Quadratic+1-5+3_1-block_integer'

#Minimal polynomial of ring generator (use variable x)
minPol ='x^2 - 5*x + 3'

#Embedding (the closest root of minimal polynomial to this value is taken as the ring generator)
omegaCC= 1.00000000000000*I

#Alphabet (use 'omega' as ring generator)
alphabet = '[0, 1, 2, 3, 4, 5, 6]'

#Input alphabet (if empty, A + A is used)
inputAlphabet = ''

#Base (use 'omega' as ring generator)
base =' omega'

#------------LIMITATIONS----------------
#maximum of iterations in searching weight coefficient set
max_iterations = 10

#maximal length of input of weight function
max_input_length =  10

#------------SAVING----------------
#save general info to .tex file
info=True

#save Weight function to .csv file
WFcsv=False

#save Local conversion to .csv file
localConversionCsv=False

#save Inputs setting
saveSetting=True

#save Log file
saveLog=True

#save Unsolved inputs after interruption
saveUnsolved=False

#run sanity check
sanityCheck=False

#---------IMAGES--------------------
#save image of the alphabet and input alphabet
alphabet_img=True

#save image of lattice with shifted alphabet
lattice_img=False

#save step-by-step images of phase 1
phase1_images=True

#save step-by-step images of phase 2
phase2_images=True
#for input
phase2_input='(omega,1,omega,1,omega,1,omega,1)'

