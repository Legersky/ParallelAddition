︠d036622f-9a67-4df9-a2ac-e69ebcf258a9s︠
#------------INPUTS---------------------
#Name of the numeration system
name = 'Eisenstein_1-block_complex'
#Minimal polynomial of ring generator (use variable x)
minPol ='x^2 + x + 1'
#Embedding (the closest root of the minimal polynomial to this value is taken as the ring generator)
omegaCC= -0.5 + 0.8*I
#Alphabet (use 'omega' as ring generator)
alphabet = '' #'[0, 1, -1, omega, -omega, -omega - 1, omega + 1]'
#Input alphabet (if empty, A + A is used)
inputAlphabet = ''
#Base (use 'omega' as ring generator)
base ='omega - 1'

#------------EWM SETTING----------------
max_iterations = 20      #maximum of iterations in searching for the weight coefficient set
methods_phase1=[3]        #methods in the list are used. If empty, default method is used.
max_input_length = 10    #maximal length of the input of the weight function
methods_phase2=[15]        #methods in the list are used. If empty, default method is used.
#Cartesian product of lists methods_phase1 and methods_phase2 is computed

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


load_attach_path('~')

load_attach_path('/home/legerjan/ParallelAddition')
load_attach_path('/home/legerjan/ParallelAddition/classes')

folder_path='./'
load('ewm.sage')
︡8f0ac06e-24af-427a-ba2f-ab992b229d59︡︡{"stdout":"Inicialization...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Numeration system: \n","done":false}︡{"stdout":"Eisenstein_1-block_complex\n","done":false}︡{"stdout":"Alphabet: \n","done":false}︡{"stdout":"[0, omega + 1, -omega - 1, 1, -1, omega, -omega]\n","done":false}︡{"stdout":"Input alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -2*omega - 2, -omega - 2, -2*omega, -omega + 1, -1, -2*omega - 1, -omega - 1, -2]\n","done":false}︡{"stdout":"Ring generator: \n","done":false}︡{"stdout":"1/2*I*sqrt(3) - 1/2\n","done":false}︡{"stdout":"Minimal polynomial of ring generator: \n","done":false}︡{"stdout":"t^2 + t + 1\n","done":false}︡{"stdout":"Base: \n","done":false}︡{"stdout":"omega - 1 = 1/2*I*sqrt(3) - 3/2\n","done":false}︡{"stdout":"Minimal polynomial of base:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"x^2 + 3*x + 3\n","done":false}︡{"stdout":"Conjugates of base:\n","done":false}︡{"stdout":"[-1/2*I*sqrt(3) - 3/2, 1/2*I*sqrt(3) - 3/2]\n","done":false}︡{"stdout":"With absolute values:\n","done":false}︡{"stdout":"[sqrt(3), sqrt(3)]\n","done":false}︡{"stdout":" \nMaximum iterations: 20\n","done":false}︡{"stdout":"Maximum length of input of weight function: 10\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base:\n","done":false}︡{"stdout":"Number of congruence classes mod base is: 3\n","done":false}︡{"stdout":"Alphabet divided into congruence classes:\n","done":false}︡{"stdout":"[[0], [omega + 1, -1, -omega], [-omega - 1, 1, omega]]\n","done":false}︡{"stdout":"=> There are all representatives mod base in the alphabet.\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base-1:\n","done":false}︡{"stdout":"Number of congruence classes mod base - 1 is: 7\n","done":false}︡{"stdout":"There are all elements of the input alphabet mod base-1 in the alphabet.","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Phase 1 - Searching for the Weight Coefficient Set using method 3...\n","done":false}︡{"stdout":"Starting Q_0:\n","done":false}︡{"stdout":"[0]\n","done":false}︡{"stdout":"Number of elements in Qk: 1","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-omega, 1, -omega - 1, -1, omega, omega + 1]\n","done":false}︡{"stdout":"Number of elements in Qk: 7","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-omega - 2, 2*omega + 1, omega - 1, -omega + 1, -2*omega - 1, omega + 2]\n","done":false}︡{"stdout":"Number of elements in Qk: 13","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[2*omega, 2, -2*omega - 2, 2*omega + 2, -2*omega, -2]\n","done":false}︡{"stdout":"Number of elements in Qk: 19","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[]\n","done":false}︡{"stdout":"The Weight Coefficient Set is:\n","done":false}︡{"stdout":"[0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -omega - 1, -omega - 2, -2*omega, -omega + 1, -1, -2*omega - 2, -2*omega - 1, -2]\n","done":false}︡{"stdout":"Number of elements: 19\n","done":false}︡{"stdout":"Phase 2 is starting...\n","done":false}︡{"stdout":"Checking one letter inputs...\n","done":false}︡{"stdout":"The longest inputs are:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[(1, 1, 1), (2, 2, 2), (-omega, -omega, -omega), (2*omega, 2*omega, 2*omega), (2*omega + 1, 2*omega + 1, 2*omega + 1), (2*omega + 2, 2*omega + 2, 2*omega + 2), (omega - 1, omega - 1, omega - 1), (omega, omega, omega), (omega + 1, omega + 1, omega + 1), (omega + 2, omega + 2, omega + 2), (-2*omega - 2, -2*omega - 2, -2*omega - 2), (-omega - 2, -omega - 2, -omega - 2), (-2*omega, -2*omega, -2*omega), (-omega + 1, -omega + 1, -omega + 1), (-1, -1, -1), (-2*omega - 1, -2*omega - 1, -2*omega - 1), (-omega - 1, -omega - 1, -omega - 1), (-2, -2, -2)]\n","done":false}︡{"stdout":"Length of one letter input: 3: \n","done":false}︡{"stdout":"Number of letters with longest input: 18\n","done":false}︡{"stdout":"Searching the Weight Function using method 15...\n","done":false}︡{"stdout":"Length of the window: 1, Number of saved combinations of input digits: 0, To next iteration: 19","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 2, Number of saved combinations of input digits: 43, To next iteration: 318","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Error:\n'WeightFunctionSearch' object has no attribute 'naturalNorm_vect'\n","done":false}︡{"stdout":"Elapsed time: 9.576268\n","done":false}︡{"stdout":"The following row was added to google spreadsheet ParallelAddition_results, worksheet: results","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"['2016-02-22 23:32', 'Eisenstein_1-block_complex', [0, omega + 1, -omega - 1, 1, -1, omega, -omega], 'A+A', 1/2*I*sqrt(3) - 1/2, t^2 + t + 1, 'omega - 1 = 1/2*I*sqrt(3) - 3/2', x^2 + 3*x + 3, [-1/2*I*sqrt(3) - 3/2, 1/2*I*sqrt(3) - 3/2], [sqrt(3), sqrt(3)], [[0], [omega + 1, -1, -omega], [-omega - 1, 1, omega]], [], [[0], [omega + 1], [-omega - 1], [1], [-1], [omega], [-omega]], [], 'yes', 3, 'OK', 19, [1, 7, 13, 19], 15, 'OK', 3, 'x', '-', [0, 43], '-', 9.576267999999999, \"'WeightFunctionSearch' object has no attribute 'naturalNorm_vect'\", '']\n","done":false}︡{"stdout":"Info about algorithm for parallel addition saved to ./Eisenstein_1-block_complex/methods_3-15/Eisenstein_1-block_complex.tex\n","done":false}︡{"stdout":"Log saved to ./Eisenstein_1-block_complex/methods_3-15/Eisenstein_1-block_complex_log.txt\n","done":false}︡{"stdout":"--------------------------end of Eisenstein_1-block_complex---------------------------------------------\n","done":false}︡{"done":true}
︠afdda438-9b83-49a0-b9bb-dcc2756ff9fa︠









