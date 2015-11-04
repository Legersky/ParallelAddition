︠1e5a7270-4dc7-4ed7-9e00-8f3566aef2d2s︠
load_attach_path('~/classes')
load('AlgorithmForParallelAddition.sage')
import time

#------------------Here you can set inputs---------------------------------------------------------------------

#Minimal polynomial of alphabet generator (use variable x):
minPol = 'x-1'

#Embedding (the closest root of minimal polynomial to this value is taken as the alphabet generator):
omegaCC = I

#Alphabet (use \'omega\' as alphabet generator)
alphabet =  '[0,1,2,-1,-2, 3, -3]' #'[0, -1,1, omega, omega+1, -omega-1,-omega]'
inputAlphabet='[]'

#Base (use \'omega\' as alphabet generator)
base = 'omega*6'

#load('inputs/eisenstein.sage')

#Do you want to plot the set of weight coefficients?  Y/N
plotWeightCoefSet = 'N'

#Do you want to run the sanity check? Y/N
sanCheck= 'N'

#Do you want to save info about algorithm to .tex file? Y/N
infoTex= 'N'
#Enter the name of file:
name='testing'

#Do you want to save also weight function to .tex file? Y/N
weightFunctionTex= 'N'


#Press Shift+Enter to run the program

#---------------------------------------------------------------------------------------------------------------------
try:
    start=time.clock()

    alg= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=True, verbose=0)

    #alg._findWeightCoefSet(20,method_number=3)
    omega=alg.getRingGenerator()
    #alg._weightCoefSet=[0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -omega - 1, -omega - 2, -2*omega, -omega + 1, -1, -2*omega - 2, -2*omega - 1, -2]
    #alg._findWeightFunction(15,method_number=4)
    alg.findWeightFunction(20,15)#,method_weightCoefSet=3,method_weightFunSearch=4)
    alg.printWeightCoefSet()
    if plotWeightCoefSet=='Y': alg.plot(alg.getWeightCoefSet())
    alg.printWeightFunctionInfo()
    alg.usedWeightCoefficients()

    if sanCheck=='Y':
        print "Sanity check:"
        print "Number of errors: %s" % alg.sanityCheck_conversion(alg.getWeightFunction().getMaxLength()+1)

    if infoTex== 'Y':
        alg.saveInfoToTexFile(filename)

    end=time.clock()

    alg.addLog("Elapsed time: "+ str(end-start))

    filename=alg.getName()
    output_folder='./outputs/'
    d = os.path.dirname(output_folder+filename+'/')
    if not os.path.exists(d):
        os.makedirs(d)
finally:
    alg.saveResults(str(end-start))

#alg.saveInfoToTexFile(output_folder+filename+'/'+filename, header=True, shortInput=False)

#alg.saveLog(output_folder+filename+'/'+filename)

︡8bddb06f-c9a2-4f02-9a72-4fd8c31a3265︡︡{"stdout":"Inicialization...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Numeration system: \n","done":false}︡{"stdout":"testing\n","done":false}︡{"stdout":"Alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, -1, -2, 3, -3]\n","done":false}︡{"stdout":"Input alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, 3, 4, 5, 6, -2, -6, -5, -4, -3, -1]\n","done":false}︡{"stdout":"Ring generator: \n","done":false}︡{"stdout":"1","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Minimal polynomial of ring generator: \n","done":false}︡{"stdout":"t - 1\n","done":false}︡{"stdout":"Base: \n","done":false}︡{"stdout":"6 = 6\n","done":false}︡{"stdout":"Minimal polynomial of base:\n","done":false}︡{"stdout":"x - 6\n","done":false}︡{"stdout":"Conjugates of base:\n","done":false}︡{"stdout":"[6]\n","done":false}︡{"stdout":"With absolute values:\n","done":false}︡{"stdout":"[6]\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base:\n","done":false}︡{"stdout":"Number of congruence classes mod base is: 6","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Alphabet divided into congruence classes:\n","done":false}︡{"stdout":"[[0], [1], [2], [-1], [-2], [3, -3]]\n","done":false}︡{"stdout":"=> There are all representatives mod base in the alphabet.","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base-1:\n","done":false}︡{"stdout":"Number of congruence classes mod base - 1 is: 5\n","done":false}︡{"stdout":"There are all elements of the input alphabet mod base-1 in the alphabet.","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Phase 1 - Searching for the Weight Coefficient Set using method 2...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Starting Q_0:\n","done":false}︡{"stdout":"[0]\n","done":false}︡{"stdout":"Number of elements in Qk: 1","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[1, -1]\n","done":false}︡{"stdout":"Number of elements in Qk: 3","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[]\n","done":false}︡{"stdout":"The Weight Coefficient Set is:\n","done":false}︡{"stdout":"[0, 1, -1]\n","done":false}︡{"stdout":"Number of elements: 3\n","done":false}︡{"stdout":"Phase 2 is starting...\n","done":false}︡{"stdout":"Checking one letter inputs...\n","done":false}︡{"stdout":"The longest inputs are:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[(3, 3), (-3, -3)]\n","done":false}︡{"stdout":"Length of one letter input: 2: \n","done":false}︡{"stdout":"Number of letters with longest input: 2\n","done":false}︡{"stdout":"Searching the Weight Function using method 5...\n","done":false}︡{"stdout":"Length of the window: 1, Number of saved combinations of input digits: 11, To next iteration: 2","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 2, Number of saved combinations of input digits: 26, To next iteration: 0","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Info about Weight Function:\n","done":false}︡{"stdout":"Maximal input length: 2\n","done":false}︡{"stdout":"Number of inputs: 37\n","done":false}︡{"stdout":"Output of weight function for the input 0,0,...,0: 0\n","done":false}︡{"stdout":"All elements of the weight coefficient set are used.\n","done":false}︡{"stdout":"Instance of WeightFunction\nWeight Coefficient Set is:\n","done":false}︡{"html":"<div align='center'>[$\\displaystyle 0$, $\\displaystyle 1$, $\\displaystyle -1$]</div>","done":false}︡{"stdout":"Number of elements:  3\nInfo about Weight Function for RingGenerator omega 1.00000000000000 (root of t - 1), alphabet [0, 1, 2, -1, -2, 3, -3] and input alphabet [0, 1, 2, 3, 4, 5, 6, -2, -6, -5, -4, -3, -1]\nMaximal input length: 2\nNumber of inputs: 37\n[0, 1, -1]\nElapsed time: 0.704112\n","done":false}︡{"stdout":"The following results were saved to google spreadsheet ParallelAddition_results","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"['2015-11-04 22:38', 'testing', [0, 1, 2, -1, -2, 3, -3], 'A+A', 1, t - 1, '6 = 6', x - 6, [6], [6], [[0], [1], [2], [-1], [-2], [3, -3]], [], [[0], [1], [2, -3], [-1], [-2, 3]], [], 'yes', 2, 'OK', 3, [1, 3], 5, 'OK', 2, 'OK', 2, [11, 26], [], '0.704112']\n","done":false}︡{"done":true}
︠0e03b2d9-2c34-4148-8ce8-9eaa7506191a︠
R.<x> = QQ[]
f=alg._base.minpoly()
f.parent
f.roots(SR, multiplicities=False)
︡6cceaba5-0ce4-4501-bb21-0c20665e3063︡︡{"stdout":"<built-in method parent of sage.rings.polynomial.polynomial_integer_dense_flint.Polynomial_integer_dense_flint object at 0x7fe7ff258a78>\n","done":false}︡{"stdout":"[-I - 1, I - 1]","done":false}︡{"stdout":"\n","done":false}︡{"done":true}
︠dd8aa65f-700f-4310-b63f-b4f1b6af5fad︠










