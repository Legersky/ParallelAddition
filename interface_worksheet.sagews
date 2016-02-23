︠d036622f-9a67-4df9-a2ac-e69ebcf258a9r︠
#------------INPUTS---------------------
#Name of the numeration system
name = 'x^2 - x + 2_automaticAlphabet'
#Minimal polynomial of ring generator (use variable x)
minPol ='x^2 - x + 2'
#Embedding (the closest root of the minimal polynomial to this value is taken as the ring generator)
omegaCC= I
#Alphabet (use 'omega' as ring generator)
alphabet = ''
#Input alphabet (if empty, A + A is used)
inputAlphabet = ''
#Base (use 'omega' as ring generator)
base ='omega'

#------------EWM SETTING----------------
max_iterations = 20      #maximum of iterations in searching for the weight coefficient set
methods_phase1=[3]        #methods in the list are used. If empty, default method is used.
max_input_length = 10    #maximal length of the input of the weight function
methods_phase2=[10,11,12,13,14,15]        #methods in the list are used. If empty, default method is used.
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
︡f23004d6-b730-425d-b04e-703146ece155︡︡{"done":false,"stderr":"<string>:224: DeprecationWarning: CartesianProduct is deprecated. Use cartesian_product instead\nSee http://trac.sagemath.org/18411 for details.\n"}︡{"stdout":"Inicialization...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Numeration system: \n","done":false}︡{"stdout":"x^2 - x + 2_automaticAlphabet\n","done":false}︡{"stdout":"Alphabet: \n","done":false}︡{"stdout":"[0]\n","done":false}︡{"stdout":"Input alphabet: \n","done":false}︡{"stdout":"[0]\n","done":false}︡{"stdout":"Ring generator: \n","done":false}︡{"stdout":"1/2*I*sqrt(7) + 1/2\n","done":false}︡{"stdout":"Minimal polynomial of ring generator: \n","done":false}︡{"stdout":"t^2 - t + 2\n","done":false}︡{"stdout":"Base: \n","done":false}︡{"stdout":"omega = 1/2*I*sqrt(7) + 1/2\n","done":false}︡{"stdout":"Minimal polynomial of base:\n","done":false}︡{"stdout":"x^2 - x + 2\n","done":false}︡{"stdout":"Conjugates of base:\n","done":false}︡{"stdout":"[-1/2*I*sqrt(7) + 1/2, 1/2*I*sqrt(7) + 1/2]\n","done":false}︡{"stdout":"With absolute values:\n","done":false}︡{"stdout":"[sqrt(2), sqrt(2)]\n","done":false}︡{"stdout":" \nMaximum iterations: 20\n","done":false}︡{"stdout":"Maximum length of input of weight function: 10\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base:\n","done":false}︡{"stdout":"Number of congruence classes mod base is: 2\n","done":false}︡{"stdout":"Alphabet divided into congruence classes:\n","done":false}︡{"stdout":"[[0]]\n","done":false}︡{"done":false,"stderr":"<string>:442: DeprecationWarning: CartesianProduct is deprecated. Use cartesian_product instead\nSee http://trac.sagemath.org/18411 for details.\n"}︡{"stdout":"=> There are not all representatives mod base in the alphabet. The following congruence classes are missing:\n","done":false}︡{"stdout":"[[omega + 1]]\n","done":false}︡{"stdout":"Error:\nThere are not all representatives mod base in the alphabet. The following congruence classes are missing: [[omega + 1]]\n","done":false}︡{"stdout":"Elapsed time: 0.173223\n","done":false}︡{"stdout":"The following row was added to google spreadsheet ParallelAddition_results, worksheet: results","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"['2016-02-23 13:00', 'x^2 - x + 2_automaticAlphabet', [0], 'A+A', 1/2*I*sqrt(7) + 1/2, t^2 - t + 2, 'omega = 1/2*I*sqrt(7) + 1/2', x^2 - x + 2, [-1/2*I*sqrt(7) + 1/2, 1/2*I*sqrt(7) + 1/2], [sqrt(2), sqrt(2)], [[0]], [[omega + 1]], [[0]], '-', 'yes', 'There are not all representatives mod base in the alphabet. The following congruence classes are missing: [[omega + 1]]', AttributeError(\"'NoneType' object has no attribute '_method'\",)]\n","done":false}
︠afdda438-9b83-49a0-b9bb-dcc2756ff9fa︠









