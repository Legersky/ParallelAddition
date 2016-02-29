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
methods_phase1=[6]        #methods in the list are used. If empty, default method is used.
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
︡59278654-a1a3-47b8-a046-26943c05c5be︡︡{"stdout":"Inicialization...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Numeration system: \n","done":false}︡{"stdout":"Penney_1-block_integer\n","done":false}︡{"stdout":"Alphabet: \n","done":false}︡{"stdout":"[0, 1, -1, 2, -2]\n","done":false}︡{"stdout":"Input alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, 3, 4, -1, -4, -3, -2]\n","done":false}︡{"stdout":"Ring generator: \n","done":false}︡{"stdout":"I\n","done":false}︡{"stdout":"Minimal polynomial of ring generator: \n","done":false}︡{"stdout":"t^2 + 1\n","done":false}︡{"stdout":"Base: \n","done":false}︡{"stdout":"omega - 1 = I - 1\n","done":false}︡{"stdout":"Minimal polynomial of base:\n","done":false}︡{"stdout":"x^2 + 2*x + 2\n","done":false}︡{"stdout":"Conjugates of base:\n","done":false}︡{"stdout":"[-I - 1, I - 1]\n","done":false}︡{"stdout":"With absolute values:\n","done":false}︡{"stdout":"[sqrt(2), sqrt(2)]\n","done":false}︡{"stdout":" \nMaximum iterations: 20\n","done":false}︡{"stdout":"Maximum length of input of weight function: 10\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base:\n","done":false}︡{"stdout":"Number of congruence classes mod base is: 2\n","done":false}︡{"stdout":"Alphabet divided into congruence classes:\n","done":false}︡{"stdout":"[[0, 2, -2], [1, -1]]\n","done":false}︡{"stdout":"=> There are all representatives mod base in the alphabet.\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base-1:\n","done":false}︡{"stdout":"Number of congruence classes mod base - 1 is: 5\n","done":false}︡{"stdout":"There are all elements of the input alphabet mod base-1 in the alphabet.","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Phase 1 - Searching for the Weight Coefficient Set using method 6...\n","done":false}︡{"stdout":"Starting Q_0:\n","done":false}︡{"stdout":"[0]\n","done":false}︡{"stdout":"Number of elements in Qk: 1\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-omega - 1, -2*omega - 2, 3*omega + 3, 2*omega + 2, omega + 1]\n","done":false}︡{"stdout":"Number of elements in Qk: 6","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[2, -omega + 1, omega + 3, omega, -1, omega - 1, -2, -omega - 3, -2*omega, -3*omega - 1, 1, 2*omega + 3, omega + 2, -2*omega - 1, -omega, 3, -2*omega + 1, -omega + 2, -4*omega - 1, -3*omega, 5*omega + 3, 4*omega + 2, 3*omega + 1, 2*omega + 1, 4*omega + 3, 3*omega + 2]\n","done":false}︡{"stdout":"Number of elements in Qk: 32","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[3*omega - 1, 2*omega - 2, -3*omega - 3, -4*omega - 4, 5*omega + 2, 4*omega + 1, 3*omega, -omega + 4, -3*omega + 2, -2*omega + 3, -4*omega + 1, -5*omega, -2*omega + 2, -omega + 3, -3*omega - 2, -4*omega - 3, -3*omega + 1, -4*omega, -5*omega - 1, -6*omega - 2, -4*omega - 2, -5*omega - 3, 5*omega + 1, 4*omega, omega - 2, 2*omega - 1, -omega - 4, -3, -2*omega - 3, -omega - 2, -3*omega - 4, omega - 3, -4]\n","done":false}︡{"stdout":"Number of elements in Qk: 65","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[7*omega + 1, 6*omega, 5*omega - 1, 4*omega - 2, 3*omega - 3, 7*omega + 2, 6*omega + 1, 5*omega, -2*omega - 4, -3*omega - 5, 4*omega - 1, 3*omega - 2, -5, 2*omega - 3, omega - 4]\n","done":false}︡{"stdout":"Number of elements in Qk: 80","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-6*omega + 1, -5*omega + 2, -4*omega + 2, -5*omega + 1, 3*omega + 5, 2*omega + 4, 3*omega + 4, 4*omega + 5, -2*omega + 5, -omega + 6, -3*omega + 4, omega + 5, 4, 2*omega + 6, -2*omega + 4, -omega + 5, -3*omega + 3, 3*omega + 6, 2*omega + 5, omega + 4, 5*omega + 5, 4*omega + 4]\n","done":false}︡{"stdout":"Number of elements in Qk: 102","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-3*omega - 6, -2*omega - 5, 2*omega - 4, omega - 5, -4*omega - 5, -5*omega - 6, -7*omega - 2, -6*omega - 1, -5*omega - 2, -6*omega - 3]\n","done":false}︡{"stdout":"Keyboard Interrupt:","done":false}︡{"stdout":"\nElapsed time: 2.925247\n","done":false}︡{"stdout":"The following row was added to google spreadsheet ParallelAddition_results, worksheet: results","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"['2016-02-29 11:44', 'Penney_1-block_integer', [0, 1, -1, 2, -2], 'A+A', I, t^2 + 1, 'omega - 1 = I - 1', x^2 + 2*x + 2, [-I - 1, I - 1], [sqrt(2), sqrt(2)], [[0, 2, -2], [1, -1]], [], [[0], [1], [-1], [2], [-2]], [], 'yes', 6, 'x', '-', [1, 6, 32, 65, 80, 102], 'Keyboard Interrupt', AttributeError(\"'AlgorithmForParallelAddition' object has no attribute '_weightFunSearch'\",)]\n","done":false}︡{"stdout":"Info about algorithm for parallel addition saved to ./outputs/Penney_1-block_integer/methods_6-19/Penney_1-block_integer.tex\n","done":false}︡{"stdout":"Log saved to ./outputs/Penney_1-block_integer/methods_6-19/Penney_1-block_integer_log.txt\n","done":false}︡{"stdout":"--------------------------end of Penney_1-block_integer---------------------------------------------\n","done":false}︡{"done":true}
︠6b4ccdb8-15c4-43db-af9a-9380a8cc0703︠
for a in range(1,4):
    print range(-a+1,a+1)
    print range(-a,a+1)
︡202c0240-f148-47f8-b0c4-55f8bacbc790︡︡{"stdout":"[0, 1]\n[-1, 0, 1]\n[-1, 0, 1, 2]\n[-2, -1, 0, 1, 2]\n[-2, -1, 0, 1, 2, 3]\n[-3, -2, -1, 0, 1, 2, 3]\n","done":false}︡{"done":true}
︠7067db39-53b0-4710-bf89-4f4e5df78dbd︠
Set([0, 1, 2, 3, 2*omega - 1, -2*omega, -omega + 1, -omega + 2, 2*omega - 2, 2*omega + 1, 2*omega + 2, 2*omega + 3, -3*omega - 1, omega - 3, omega - 1, omega, omega + 1, omega + 2, omega + 3, 4*omega, 4*omega + 1, 4*omega + 2, 3*omega, 3*omega + 1, 3*omega + 2, 3*omega + 3, -4*omega - 1, -4*omega, -3*omega - 3, -3*omega - 2, -3*omega, -3*omega + 1, omega - 2, -3, -omega - 1, -4*omega - 2, -omega - 3, -omega - 2, -omega, -2*omega + 1, -2*omega + 2, -omega + 3, -1, -2*omega - 3, -2*omega - 1, -2*omega - 2, -2]).difference(Set([0, 1, 2, 3, -2*omega, -omega + 1, -omega + 2, 2*omega - 2, 2*omega + 1, 2*omega + 2, 2*omega + 3, -3*omega - 1, omega - 3, omega - 1, omega, omega + 1, omega + 2, omega + 3, 4*omega, 4*omega + 1, 4*omega + 2, 3*omega, 3*omega + 1, 3*omega + 2, 3*omega + 3, -4*omega - 1, -4*omega, -3*omega - 3, -3*omega - 2, -3*omega, -3*omega + 1, omega - 2, -3, -omega - 2, -4*omega - 2, -2*omega - 3, -2*omega - 1, -omega, -2*omega + 1, -2*omega + 2, -omega + 3, -1, -omega - 3, -omega - 1, -2*omega - 2, -2]))
︡975fc7fa-13c0-4f72-a57b-59f1d047c7ee︡︡{"stdout":"{2*omega - 1}\n","done":false}︡{"done":true}
︠cd3d393d-4755-47fb-aa74-e5b7b145fd86︠
omega=alg._ringGenerator
︡3682e25c-dbaf-4a73-82a5-ae0a2bc8b033︡︡{"done":true}
︠ee1cdbb6-f090-4d32-9211-9027daba0a92︠




#------------EWM SETTING----------------
max_iterations = 20      #maximum of iterations in searching for the weight coefficient set
methods_phase1=[3]        #methods in the list are used. If empty, default method is used.
max_input_length = 100    #maximal length of the input of the weight function
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


folder_path='./outputs/'
load_attach_path('./classes')

load_attach_path('~')

load_attach_path('/home/legerjan/ParallelAddition')
load_attach_path('/home/legerjan/ParallelAddition/classes')

folder_path='./'
#-----------------------------------------------------------------------
max_coef=5
m=0
t=[]
P.<x> = ZZ[]
for i in range(0,2):
    t.append(range(-max_coef,max_coef+1))

skip=False
for x in cartesian_product_iterator(t):
    if abs(x[0])<=m and abs(x[1])<=m:
        pass
    elif skip:
        pass
    else:
        p= str(P(list(x)+[1]))
        print p
        name = 'Quadratic_gen_'+str(p)+'_automaticAlphabet_'
        minPol =p
        omegaCC= 1+ 1*I
        alphabet = ''
        inputAlphabet = ''

        max_coef_base=3
        u=[]
        for i in range(0,2):
            u.append(range(-max_coef_base,max_coef_base+1))
        for y in cartesian_product_iterator(u):
            base =str(y[0])+'*omega'+'+('+str(y[1])+')'
            name = 'Quadratic_gen_'+str(p)+'_automaticAlphabet_'+base
            try:
                load('ewm.sage')
            except ExceptionParAdd, e:
                print e
︠91e27250-1787-462b-a948-338a8845b077︠












