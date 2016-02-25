︠d036622f-9a67-4df9-a2ac-e69ebcf258a9︠
#------------INPUTS---------------------
#Name of the numeration system
name = 'Penney_1-block_integer'
#Minimal polynomial of ring generator (use variable x)
minPol ='x^2 + 1'
#Embedding (the closest root of the minimal polynomial to this value is taken as the ring generator)
omegaCC= I
#Alphabet (use 'omega' as ring generator)
alphabet = '[0, 1, -1, 2, -2]'
#Input alphabet (if empty, A + A is used)
inputAlphabet = ''
#Base (use 'omega' as ring generator)
base ='omega-1'

#------------EWM SETTING----------------
max_iterations = 20      #maximum of iterations in searching for the weight coefficient set
methods_phase1=[2,3]        #methods in the list are used. If empty, default method is used.
max_input_length = 10    #maximal length of the input of the weight function
methods_phase2=[19]        #methods in the list are used. If empty, default method is used.
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

folder_path='./outputs/'
load('ewm.sage')
︡bee4bd7d-9baa-4646-a317-d7c5b9173007︡︡{"stdout":"Comparing different methods for Phase 1...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Same weight coefficients sets are found by these group(s) of methods:","done":false}︡{"stdout":"\n[[2, 3]]\nInicialization...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Numeration system: \n","done":false}︡{"stdout":"Penney_1-block_integer\n","done":false}︡{"stdout":"Alphabet: \n","done":false}︡{"stdout":"[0, 1, -1, 2, -2]\n","done":false}︡{"stdout":"Input alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, 3, 4, -1, -4, -3, -2]\n","done":false}︡{"stdout":"Ring generator: \n","done":false}︡{"stdout":"I\n","done":false}︡{"stdout":"Minimal polynomial of ring generator: \n","done":false}︡{"stdout":"t^2 + 1\n","done":false}︡{"stdout":"Base: \n","done":false}︡{"stdout":"omega - 1 = I - 1\n","done":false}︡{"stdout":"Minimal polynomial of base:\n","done":false}︡{"stdout":"x^2 + 2*x + 2\n","done":false}︡{"stdout":"Conjugates of base:\n","done":false}︡{"stdout":"[-I - 1, I - 1]\n","done":false}︡{"stdout":"With absolute values:\n","done":false}︡{"stdout":"[sqrt(2), sqrt(2)]\n","done":false}︡{"stdout":" \nMaximum iterations: 20\n","done":false}︡{"stdout":"Maximum length of input of weight function: 10\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base:\n","done":false}︡{"stdout":"Number of congruence classes mod base is: 2\n","done":false}︡{"stdout":"Alphabet divided into congruence classes:\n","done":false}︡{"stdout":"[[0, 2, -2], [1, -1]]\n","done":false}︡{"stdout":"=> There are all representatives mod base in the alphabet.\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base-1:\n","done":false}︡{"stdout":"Number of congruence classes mod base - 1 is: 5\n","done":false}︡{"stdout":"There are all elements of the input alphabet mod base-1 in the alphabet.","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Phase 1 - Searching for the Weight Coefficient Set using method 2...\n","done":false}︡{"stdout":"Starting Q_0:\n","done":false}︡{"stdout":"[0]\n","done":false}︡{"stdout":"Number of elements in Qk: 1\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-omega - 1, omega + 1]\n","done":false}︡{"stdout":"Number of elements in Qk: 3","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[1, -omega, -2*omega - 1, omega, 2*omega + 1, -1]\n","done":false}︡{"stdout":"Number of elements in Qk: 9","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-2*omega - 2, 2, -omega + 1, -2*omega, -3*omega - 1, omega + 2, 3*omega + 1, omega - 1, -2, -omega - 2, 2*omega + 2]\n","done":false}︡{"stdout":"Number of elements in Qk: 20","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[3*omega + 2, 3*omega, 2*omega - 1, -omega + 2, omega - 2, -3*omega - 2, -2*omega + 1, -3*omega]\n","done":false}︡{"stdout":"Number of elements in Qk: 28","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[4*omega + 1, 3, -3, -omega - 3, -2*omega - 3, omega + 3, -4*omega - 1, 2*omega + 3]\n","done":false}︡{"stdout":"Number of elements in Qk: 36","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[2*omega - 2, omega - 3, -3*omega - 3, -2*omega + 2, -4*omega - 2, 4*omega + 2, -omega + 3, -3*omega + 1, -4*omega, 3*omega + 3, 4*omega]\n","done":false}︡{"stdout":"Number of elements in Qk: 47","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[]\n","done":false}︡{"stdout":"The Weight Coefficient Set is:\n","done":false}︡{"stdout":"[0, 1, 2, 3, 2*omega - 1, -2*omega, -omega + 1, -omega + 2, 2*omega - 2, 2*omega + 1, 2*omega + 2, 2*omega + 3, -3*omega - 1, omega - 3, omega - 1, omega, omega + 1, omega + 2, omega + 3, 4*omega, 4*omega + 1, 4*omega + 2, 3*omega, 3*omega + 1, 3*omega + 2, 3*omega + 3, -4*omega - 1, -4*omega, -3*omega - 3, -3*omega - 2, -3*omega, -3*omega + 1, omega - 2, -3, -omega - 1, -4*omega - 2, -omega - 3, -omega - 2, -omega, -2*omega + 1, -2*omega + 2, -omega + 3, -1, -2*omega - 3, -2*omega - 1, -2*omega - 2, -2]\n","done":false}︡{"stdout":"Number of elements: 47\n","done":false}︡{"stdout":"Phase 2 is starting...\n","done":false}︡{"stdout":"Checking one letter inputs...\n","done":false}︡{"stdout":"There is no unique weight coefficient for finite input gained by repetition of letter 0 using method number 19","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"There is no unique weight coefficient for finite input gained by repetition of letter 3 using method number 19","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Error:","done":false}︡{"stdout":"\nThere is no unique weight coefficient for finite input gained by repetition of letters [0, 3] using method number 19\n","done":false}︡{"stdout":"Elapsed time: 10.258596\n","done":false}︡{"stdout":"The following row was added to google spreadsheet ParallelAddition_results, worksheet: results","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"['2016-02-24 22:23', 'Penney_1-block_integer', [0, 1, -1, 2, -2], 'A+A', I, t^2 + 1, 'omega - 1 = I - 1', x^2 + 2*x + 2, [-I - 1, I - 1], [sqrt(2), sqrt(2)], [[0, 2, -2], [1, -1]], [], [[0], [1], [-1], [2], [-2]], [], 'yes', 2, 'OK', 47, [1, 3, 9, 20, 28, 36, 47], 19, [0, 3], '-', 'x', '-', [], '-', 10.258596, 'There is no unique weight coefficient for finite input gained by repetition of letters [0, 3] using method number 19', 'Same weight coefficients sets are found by these group(s) of methods:[[2, 3]]']\n","done":false}︡{"stdout":"Info about algorithm for parallel addition saved to ./outputs/Penney_1-block_integer/methods_2-19/Penney_1-block_integer.tex\n","done":false}︡{"stdout":"Log saved to ./outputs/Penney_1-block_integer/methods_2-19/Penney_1-block_integer_log.txt\n","done":false}︡{"stdout":"--------------------------end of Penney_1-block_integer---------------------------------------------\n","done":false}︡{"done":true}
︠6b4ccdb8-15c4-43db-af9a-9380a8cc0703s︠






max_coef=5
m=2
t=[]
P.<x> = ZZ[]
for i in range(0,2):
    t.append(range(-max_coef,max_coef+1))

iterat=cartesian_product_iterator(t)
for x in iterat:
    p= str(P(list(x)+[1]))
    print p
    if x[0]==3 and x[1]==4:
        print 'rrrrrrrrrrr'

skip=True
print 'sdsdddddddddddddddddddddddddddddd'
for x in iterat:
    if x[0]==3 and x[1]==4:
        skip=False
    if abs(x[0])<=m and abs(x[1])<=m:
        pass
    elif skip:
        pass
    else:
        p= str(P(list(x)+[1]))
        print p
︡3c34d35d-fbea-4482-9c1c-a01f4bf1609f︡︡{"stdout":"x^2 - 5*x - 5\nx^2 - 4*x - 5\nx^2 - 3*x - 5\nx^2 - 2*x - 5\nx^2 - x - 5\nx^2 - 5\nx^2 + x - 5\nx^2 + 2*x - 5\nx^2 + 3*x - 5\nx^2 + 4*x - 5\nx^2 + 5*x - 5\nx^2 - 5*x - 4\nx^2 - 4*x - 4\nx^2 - 3*x - 4\nx^2 - 2*x - 4\nx^2 - x - 4\nx^2 - 4\nx^2 + x - 4\nx^2 + 2*x - 4\nx^2 + 3*x - 4\nx^2 + 4*x - 4\nx^2 + 5*x - 4\nx^2 - 5*x - 3\nx^2 - 4*x - 3\nx^2 - 3*x - 3\nx^2 - 2*x - 3\nx^2 - x - 3\nx^2 - 3\nx^2 + x - 3\nx^2 + 2*x - 3\nx^2 + 3*x - 3\nx^2 + 4*x - 3\nx^2 + 5*x - 3\nx^2 - 5*x - 2\nx^2 - 4*x - 2\nx^2 - 3*x - 2\nx^2 - 2*x - 2\nx^2 - x - 2\nx^2 - 2\nx^2 + x - 2\nx^2 + 2*x - 2\nx^2 + 3*x - 2\nx^2 + 4*x - 2\nx^2 + 5*x - 2\nx^2 - 5*x - 1\nx^2 - 4*x - 1\nx^2 - 3*x - 1\nx^2 - 2*x - 1\nx^2 - x - 1\nx^2 - 1\nx^2 + x - 1\nx^2 + 2*x - 1\nx^2 + 3*x - 1\nx^2 + 4*x - 1\nx^2 + 5*x - 1\nx^2 - 5*x\nx^2 - 4*x\nx^2 - 3*x\nx^2 - 2*x\nx^2 - x\nx^2\nx^2 + x\nx^2 + 2*x\nx^2 + 3*x\nx^2 + 4*x\nx^2 + 5*x\nx^2 - 5*x + 1\nx^2 - 4*x + 1\nx^2 - 3*x + 1\nx^2 - 2*x + 1\nx^2 - x + 1\nx^2 + 1\nx^2 + x + 1\nx^2 + 2*x + 1\nx^2 + 3*x + 1\nx^2 + 4*x + 1\nx^2 + 5*x + 1\nx^2 - 5*x + 2\nx^2 - 4*x + 2\nx^2 - 3*x + 2\nx^2 - 2*x + 2\nx^2 - x + 2\nx^2 + 2\nx^2 + x + 2\nx^2 + 2*x + 2\nx^2 + 3*x + 2\nx^2 + 4*x + 2\nx^2 + 5*x + 2\nx^2 - 5*x + 3\nx^2 - 4*x + 3\nx^2 - 3*x + 3\nx^2 - 2*x + 3\nx^2 - x + 3\nx^2 + 3\nx^2 + x + 3\nx^2 + 2*x + 3\nx^2 + 3*x + 3\nx^2 + 4*x + 3\nrrrrrrrrrrr\nx^2 + 5*x + 3\nx^2 - 5*x + 4\nx^2 - 4*x + 4\nx^2 - 3*x + 4\nx^2 - 2*x + 4\nx^2 - x + 4\nx^2 + 4\nx^2 + x + 4\nx^2 + 2*x + 4\nx^2 + 3*x + 4\nx^2 + 4*x + 4\nx^2 + 5*x + 4\nx^2 - 5*x + 5\nx^2 - 4*x + 5\nx^2 - 3*x + 5\nx^2 - 2*x + 5\nx^2 - x + 5\nx^2 + 5\nx^2 + x + 5\nx^2 + 2*x + 5\nx^2 + 3*x + 5\nx^2 + 4*x + 5\nx^2 + 5*x + 5\n","done":false}︡{"stdout":"sdsdddddddddddddddddddddddddddddd\n","done":false}︡{"stdout":"x^2 + 4*x + 3\nx^2 + 5*x + 3\nx^2 - 5*x + 4\nx^2 - 4*x + 4\nx^2 - 3*x + 4\nx^2 - 2*x + 4\nx^2 - x + 4\nx^2 + 4\nx^2 + x + 4\nx^2 + 2*x + 4\nx^2 + 3*x + 4\nx^2 + 4*x + 4\nx^2 + 5*x + 4\nx^2 - 5*x + 5\nx^2 - 4*x + 5\nx^2 - 3*x + 5\nx^2 - 2*x + 5\nx^2 - x + 5\nx^2 + 5\nx^2 + x + 5\nx^2 + 2*x + 5\nx^2 + 3*x + 5\nx^2 + 4*x + 5\nx^2 + 5*x + 5\n","done":false}︡{"done":true}
︠bbfa0fbe-2fef-4612-a674-a0ff2bb09684︠











