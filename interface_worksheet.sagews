︠d036622f-9a67-4df9-a2ac-e69ebcf258a9rs︠
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
︡406f4d82-ae93-4f9a-9adf-d47ac95f5fcd︡︡{"stdout":"Inicialization...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Numeration system: \n","done":false}︡{"stdout":"Penney_1-block_integer\n","done":false}︡{"stdout":"Alphabet: \n","done":false}︡{"stdout":"[0, 1, -1, 2, -2]\n","done":false}︡{"stdout":"Input alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, 3, 4, -1, -4, -3, -2]\n","done":false}︡{"stdout":"Ring generator: \n","done":false}︡{"stdout":"I\n","done":false}︡{"stdout":"Minimal polynomial of ring generator: \n","done":false}︡{"stdout":"t^2 + 1\n","done":false}︡{"stdout":"Base: \n","done":false}︡{"stdout":"omega - 1 = I - 1\n","done":false}︡{"stdout":"Minimal polynomial of base:\n","done":false}︡{"stdout":"x^2 + 2*x + 2\n","done":false}︡{"stdout":"Conjugates of base:\n","done":false}︡{"stdout":"[-I - 1, I - 1]\n","done":false}︡{"stdout":"With absolute values:\n","done":false}︡{"stdout":"[sqrt(2), sqrt(2)]\n","done":false}︡{"stdout":" \nMaximum iterations: 20\n","done":false}︡{"stdout":"Maximum length of input of weight function: 10\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base:\n","done":false}︡{"stdout":"Number of congruence classes mod base is: 2\n","done":false}︡{"stdout":"Alphabet divided into congruence classes:\n","done":false}︡{"stdout":"[[0, 2, -2], [1, -1]]\n","done":false}︡{"stdout":"=> There are all representatives mod base in the alphabet.\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base-1:\n","done":false}︡{"stdout":"Number of congruence classes mod base - 1 is: 5\n","done":false}︡{"stdout":"There are all elements of the input alphabet mod base-1 in the alphabet.\n","done":false}︡{"stdout":"Phase 1 - Searching for the Weight Coefficient Set using method 6...\n","done":false}︡{"stdout":"Starting Q_0:\n","done":false}︡{"stdout":"[0]\n","done":false}︡{"stdout":"Number of elements in Qk: 1\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-omega - 1, -2*omega - 2, 3*omega + 3, 2*omega + 2, omega + 1]\n","done":false}︡{"stdout":"Number of elements in Qk: 6","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[2, -omega + 1, omega + 3, omega, -1, omega - 1, -2, -omega - 3, -2*omega, -3*omega - 1, 1, 2*omega + 3, omega + 2, -2*omega - 1, -omega, 3, -2*omega + 1, -omega + 2, -4*omega - 1, -3*omega, 5*omega + 3, 4*omega + 2, 3*omega + 1, 2*omega + 1, 4*omega + 3, 3*omega + 2]\n","done":false}︡{"stdout":"Number of elements in Qk: 32","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[3*omega - 1, 2*omega - 2, -3*omega - 3, -4*omega - 4, 5*omega + 2, 4*omega + 1, 3*omega, -omega + 4, -3*omega + 2, -2*omega + 3, -4*omega + 1, -5*omega, -2*omega + 2, -omega + 3, -3*omega - 2, -4*omega - 3, -3*omega + 1, -4*omega, -5*omega - 1, -6*omega - 2, -4*omega - 2, -5*omega - 3, 5*omega + 1, 4*omega, omega - 2, 2*omega - 1, -omega - 4, -3, -2*omega - 3, -omega - 2, -3*omega - 4, omega - 3, -4]\n","done":false}︡{"stdout":"Number of elements in Qk: 65","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[7*omega + 1, 6*omega, 5*omega - 1, 4*omega - 2, 3*omega - 3, 7*omega + 2, 6*omega + 1, 5*omega, -2*omega - 4, -3*omega - 5, 4*omega - 1, 3*omega - 2, -5, 2*omega - 3, omega - 4]\n","done":false}︡{"stdout":"Number of elements in Qk: 80","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-6*omega + 1, -5*omega + 2, -4*omega + 2, -5*omega + 1, 3*omega + 5, 2*omega + 4, 3*omega + 4, 4*omega + 5, -2*omega + 5, -omega + 6, -3*omega + 4, omega + 5, 4, 2*omega + 6, -2*omega + 4, -omega + 5, -3*omega + 3, 3*omega + 6, 2*omega + 5, omega + 4, 5*omega + 5, 4*omega + 4]\n","done":false}︡{"stdout":"Number of elements in Qk: 102","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-3*omega - 6, -2*omega - 5, 2*omega - 4, omega - 5, -4*omega - 5, -5*omega - 6, -7*omega - 2, -6*omega - 1, -5*omega - 2, -6*omega - 3]\n","done":false}︡{"stdout":"Number of elements in Qk: 112","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[7*omega, 6*omega - 1, 5*omega - 2, 4*omega - 3, 3*omega - 4, 2*omega - 5, 7*omega + 3, 6*omega + 2, 7*omega + 4, 6*omega + 3]\n","done":false}︡{"stdout":"Number of elements in Qk: 122","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[omega + 6, 5, -6*omega, -7*omega - 1, -7*omega, -8*omega - 1]\n","done":false}︡{"stdout":"Number of elements in Qk: 128","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[6*omega - 2, 5*omega - 3, 4*omega - 4, -5*omega - 4, -6*omega - 5, 3*omega - 5, 2*omega - 6]\n","done":false}︡{"stdout":"Number of elements in Qk: 135","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[]\n","done":false}︡{"stdout":"The Weight Coefficient Set is:\n","done":false}︡{"stdout":"[0, 1, 2, 3, 4, 5, -8*omega - 1, omega - 5, omega - 4, omega - 3, omega - 1, omega, omega + 1, omega + 2, omega + 3, omega + 4, omega + 5, omega + 6, 5*omega - 3, 5*omega - 1, 5*omega, 5*omega + 1, 5*omega + 2, 5*omega + 3, 5*omega + 5, -3*omega - 6, -3*omega - 5, -3*omega - 4, -3*omega - 3, -3*omega - 1, -3*omega, -3*omega + 1, -3*omega + 2, -3*omega + 3, -3*omega + 4, -6*omega - 1, -2*omega - 3, -omega - 1, -4*omega - 2, -4*omega + 1, -7*omega - 1, -7*omega, 4*omega - 4, 4*omega - 3, 4*omega - 2, 4*omega, 4*omega + 1, 4*omega + 2, 4*omega + 3, 4*omega + 4, 4*omega + 5, omega - 2, 7*omega, 7*omega + 1, 7*omega + 2, 7*omega + 3, 7*omega + 4, -2*omega - 5, -omega - 4, -omega - 3, -omega - 2, -2*omega, -omega + 1, -omega + 2, -2*omega + 3, -omega + 4, -2*omega + 5, -omega + 6, 6*omega - 1, 3*omega - 2, -6*omega - 5, -6*omega - 3, -6*omega - 2, 5*omega - 2, -6*omega, -6*omega + 1, -2*omega - 1, 3*omega - 5, 3*omega - 4, 3*omega - 3, 3*omega - 1, 3*omega, 3*omega + 1, 3*omega + 2, 3*omega + 3, 3*omega + 4, 3*omega + 5, 3*omega + 6, -5*omega - 6, -5*omega - 4, -5*omega - 3, -5*omega - 2, -5*omega, -5*omega + 1, -5*omega + 2, -2*omega - 4, 6*omega - 2, 6*omega, 6*omega + 1, 6*omega + 2, 6*omega + 3, -2*omega - 2, -2*omega + 2, 2*omega - 1, -omega, -2*omega + 1, 2*omega - 6, 2*omega - 5, 2*omega - 4, 2*omega - 3, 2*omega - 2, -7*omega - 2, 2*omega + 1, 2*omega + 2, -omega + 3, 2*omega + 4, 2*omega + 5, 2*omega + 6, -3*omega - 2, -2*omega + 4, 2*omega + 3, -omega + 5, -4*omega - 5, -4*omega - 4, -4*omega - 3, -4*omega - 1, -4*omega, -5*omega - 1, -4*omega + 2, 4*omega - 1, -1, -5, -4, -3, -2]\n","done":false}︡{"stdout":"Number of elements: 135\n","done":false}︡{"stdout":"Phase 2 is starting...\n","done":false}︡{"stdout":"Checking one letter inputs...\n","done":false}
︠6b4ccdb8-15c4-43db-af9a-9380a8cc0703︠






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
︠bbfa0fbe-2fef-4612-a674-a0ff2bb09684︠











