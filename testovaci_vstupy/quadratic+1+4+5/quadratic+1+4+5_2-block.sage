#---------------INPUTS---------------
#Name of the numeration system
name = 'Quadratic+1+4+5_2-block'

#Minimal polynomial of ring generator (use variable x)
minPol =' x^2 + 1 '

#Embedding (the closest root of minimal polynomial to this value is taken as the ring generator)
omegaCC= 1.00000000000000*I

#Alphabet (use 'omega' as ring generator)
alphabet = ' [0, 1, 2, 3, 4, omega - 6, omega - 5, omega - 4, omega - 3, omega - 2, omega, omega + 1, omega + 2, 3*omega - 10, 3*omega - 9, 3*omega - 8, 3*omega - 7, 3*omega - 6, 3*omega - 5, 3*omega - 4, 3*omega - 3, 3*omega - 2, -3*omega + 2, -3*omega + 3, -3*omega + 4, -3*omega + 5, -3*omega + 6, -3*omega + 7, -3*omega + 8, -3*omega + 9, -3*omega + 10, -omega - 1, -omega + 2, 2*omega - 2, -omega, -omega + 1, 2*omega - 8, 2*omega - 7, 2*omega - 6, 2*omega - 5, 2*omega - 4, 2*omega - 3, 2*omega - 1, 2*omega, -2*omega + 3, 4*omega - 12, 4*omega - 11, 4*omega - 10, 4*omega - 9, 4*omega - 8, 4*omega - 7, 4*omega - 6, 4*omega - 5, 4*omega - 4, -2*omega + 5, -2*omega + 4, -2*omega + 6, -4*omega + 4, -4*omega + 5, -4*omega + 6, -4*omega + 7, -4*omega + 8, -4*omega + 9, -4*omega + 10, -4*omega + 11, -4*omega + 12, omega - 1, -omega - 2, -2*omega, -2*omega + 1, -2*omega + 2, -omega + 3, -omega + 4, -omega + 5, -omega + 6, -2*omega + 7, -2*omega + 8, -1, -4, -3, -2] '

#Input alphabet (if empty, A + A is used)
inputAlphabet = ''

#Base (use 'omega' as ring generator)
base =' 3-4*omega '

#------------LIMITATIONS----------------
#maximum of iterations in searching weight coefficient set
max_iterations = 20

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
lattice_img=True

#save step-by-step images of phase 1
phase1_images=True

#save step-by-step images of phase 2
phase2_images=True
#for input
phase2_input='(omega,1,omega,1,omega,1,omega,1)'

