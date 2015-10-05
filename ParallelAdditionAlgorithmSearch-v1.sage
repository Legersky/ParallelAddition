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

#------------LIMITATIONS----------------
max_iterations = 20      #maximum of iterations in searching for the weight coefficient set
max_input_length = 10    #maximal length of the input of the weight function

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
alphabet_img=False        #save image of alphabet and input alphabet
lattice_img=False         #save image of lattice with shifted alphabet
phase1_images=False       #save step-by-step images of phase 1
weightCoefSet_img=False   #save image of the weight coefficient set
#with estimation given by lemma:
estimation=False
phase2_images=False       #save step-by-step images of phase 2
#for input:
phase2_input='(omega,1,omega,1,omega,1,omega,1)'

load_attach_path('../')

folder_path=os.path.dirname(__file__)
load_attach_path('/home/legerjan/ParallelAddition')
load('ewm.sage')
