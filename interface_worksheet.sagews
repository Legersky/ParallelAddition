︠1e5a7270-4dc7-4ed7-9e00-8f3566aef2d2s︠
load_attach_path('~/classes')
load('AlgorithmForParallelAddition.sage')
import time

#------------------Here you can set inputs---------------------------------------------------------------------

#Minimal polynomial of alphabet generator (use variable x):
minPol = 'x^2+x+1'

#Embedding (the closest root of minimal polynomial to this value is taken as the alphabet generator):
omegaCC = I

#Alphabet (use \'omega\' as alphabet generator)
alphabet =  '[0, -1,1, omega, omega+1, -omega-1,-omega]' #'[0,1,2,-1,-2, 3, -3]'
inputAlphabet='[]'

#Base (use \'omega\' as alphabet generator)
base = 'omega-1'

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

start=time.clock()

alg= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=True, verbose=0)

#alg._findWeightCoefSet(20,method_number=3)
omega=alg.getRingGenerator()
#alg._weightCoefSet=[0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -omega - 1, -omega - 2, -2*omega, -omega + 1, -1, -2*omega - 2, -2*omega - 1, -2]
#alg._findWeightFunction(15,method_number=4)
alg.findWeightFunction(20,15,method_weightCoefSet=4,method_weightFunSearch=4)
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


#alg.saveInfoToTexFile(output_folder+filename+'/'+filename, header=True, shortInput=False)

#alg.saveLog(output_folder+filename+'/'+filename)

︡6de843fe-8ebf-4158-81d5-6cfba04a02fa︡︡{"stdout":"Inicialization...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Numeration system: \n","done":false}︡{"stdout":"testing\n","done":false}︡{"stdout":"Alphabet: \n","done":false}︡{"stdout":"[0, -1, 1, omega, omega + 1, -omega - 1, -omega]\n","done":false}︡{"stdout":"Input alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -2*omega - 1, -omega - 1, -2*omega, -omega + 1, -1, -2*omega - 2, -omega - 2, -2]\n","done":false}︡{"stdout":"Ring generator: \n","done":false}︡{"stdout":"1/2*I*sqrt(3) - 1/2\n","done":false}︡{"stdout":"Minimal polynomial of ring generator: \n","done":false}︡{"stdout":"t^2 + t + 1\n","done":false}︡{"stdout":"Base: \n","done":false}︡{"stdout":"omega - 1 = 1/2*I*sqrt(3) - 3/2\n","done":false}︡{"stdout":"Minimal polynomial of base:\n","done":false}︡{"stdout":"x^2 + 3*x + 3\n","done":false}︡{"stdout":"Conjugates of base:\n","done":false}︡{"stdout":"[-1/2*I*sqrt(3) - 3/2, 1/2*I*sqrt(3) - 3/2]\n","done":false}︡{"stdout":"With absolute values:\n","done":false}︡{"stdout":"[sqrt(3), sqrt(3)]\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base:\n","done":false}︡{"stdout":"Number of congruence classes mod base is: 3\n","done":false}︡{"stdout":"Alphabet divided into congruence classes:\n","done":false}︡{"stdout":"[[0], [-1, omega + 1, -omega], [1, omega, -omega - 1]]\n","done":false}︡{"stdout":"=> There are all representatives mod base in the alphabet.\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base-1:\n","done":false}︡{"stdout":"Number of congruence classes mod base - 1 is: 7\n","done":false}︡{"stdout":"There are all elements of the input alphabet mod base-1 in the alphabet.\n","done":false}︡{"stdout":"Phase 1 - Searching for the Weight Coefficient Set using method 4...\n","done":false}︡{"stdout":"The Weight Coefficient Set is:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[-omega - 2, -2, omega - 2, 2*omega - 2, -2*omega - 1, -omega - 1, -1, omega - 1, 2*omega - 1, -2*omega, -omega, 0, omega, 2*omega, -2*omega + 1, -omega + 1, 1, omega + 1, 2*omega + 1, -2*omega + 2, -omega + 2, 2, omega + 2]\n","done":false}︡{"stdout":"Number of elements: 23\n","done":false}︡{"stdout":"Phase 2 is starting...\n","done":false}︡{"stdout":"Checking one letter inputs...\n","done":false}︡{"stdout":"The longest inputs are:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[(2*omega, 2*omega, 2*omega, 2*omega), (omega + 2, omega + 2, omega + 2, omega + 2), (-2*omega, -2*omega, -2*omega, -2*omega), (-omega - 2, -omega - 2, -omega - 2, -omega - 2)]\n","done":false}︡{"stdout":"Length of one letter input: 4: \n","done":false}︡{"stdout":"Number of letters with longest input: 4\n","done":false}︡{"stdout":"Searching the Weight Function using method 4...\n","done":false}︡{"stdout":"Length of the window: 1, Number of saved combinations of input digits: 0, To next iteration: 19","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 2, Number of saved combinations of input digits: 2, To next iteration: 359","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 3, Number of saved combinations of input digits: 5960, To next iteration: 861","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 4, Number of saved combinations of input digits: 16181, To next iteration: 178","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 5, Number of saved combinations of input digits: 3382, To next iteration: 0","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Info about Weight Function:\n","done":false}︡{"stdout":"Maximal input length: 5\n","done":false}︡{"stdout":"Number of inputs: 25525\n","done":false}︡{"stdout":"Output of weight function for the input 0,0,...,0: 0\n","done":false}︡{"stdout":"Used weight coefficients are following:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[0, 1, 2, -omega, 2*omega, 2*omega + 1, omega - 1, omega, omega + 1, omega + 2, -2*omega - 1, -2*omega, -omega + 1, -1, -omega - 2, -omega - 1, -2]","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"The following elements of the weigth coefficient set are not used:\n","done":false}︡{"stdout":"[omega - 2, -omega + 2, 2*omega - 2, 2*omega - 1, -2*omega + 1, -2*omega + 2]","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Instance of WeightFunction\n","done":false}︡{"stdout":"Weight Coefficient Set is:\n","done":false}︡{"html":"<div align='center'>[$\\displaystyle -\\omega - 2$, $\\displaystyle -2$, $\\displaystyle \\omega - 2$, $\\displaystyle 2\\omega - 2$, $\\displaystyle -2\\omega - 1$, $\\displaystyle -\\omega - 1$, $\\displaystyle -1$, $\\displaystyle \\omega - 1$, $\\displaystyle 2\\omega - 1$, $\\displaystyle -2\\omega$, $\\displaystyle -\\omega$, $\\displaystyle 0$, $\\displaystyle \\omega$, $\\displaystyle 2\\omega$, $\\displaystyle -2\\omega + 1$, $\\displaystyle -\\omega + 1$, $\\displaystyle 1$, $\\displaystyle \\omega + 1$, $\\displaystyle 2\\omega + 1$, $\\displaystyle -2\\omega + 2$, $\\displaystyle -\\omega + 2$, $\\displaystyle 2$, $\\displaystyle \\omega + 2$]</div>","done":false}︡{"stdout":"Number of elements:  23\n","done":false}︡{"stdout":"Info about Weight Function for RingGenerator omega -0.500000000000000 + 0.866025403784439*I (root of t^2 + t + 1), alphabet [0, -1, 1, omega, omega + 1, -omega - 1, -omega] and input alphabet [0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -2*omega - 1, -omega - 1, -2*omega, -omega + 1, -1, -2*omega - 2, -omega - 2, -2]\nMaximal input length: 5\nNumber of inputs: 25525\n","done":false}︡{"stdout":"[0, 1, 2, -omega, 2*omega, 2*omega + 1, omega - 1, omega, omega + 1, omega + 2, -2*omega - 1, -2*omega, -omega + 1, -1, -omega - 2, -omega - 1, -2]","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Elapsed time: 140.313388\n","done":false}︡{"done":true}
︠0e03b2d9-2c34-4148-8ce8-9eaa7506191a︠
R.<x> = QQ[]
f=alg._base.minpoly()
f.parent
f.roots(SR, multiplicities=False)
︡6cceaba5-0ce4-4501-bb21-0c20665e3063︡︡{"stdout":"<built-in method parent of sage.rings.polynomial.polynomial_integer_dense_flint.Polynomial_integer_dense_flint object at 0x7fe7ff258a78>\n","done":false}︡{"stdout":"[-I - 1, I - 1]","done":false}︡{"stdout":"\n","done":false}︡{"done":true}
︠dd8aa65f-700f-4310-b63f-b4f1b6af5fad︠



k=abs(-1/2*I*sqrt(3) - 3/2)
︡13884857-bebf-4a78-bd88-a3a6567b96c9︡︡{"done":false,"stderr":"Error in lines 1-1\nTraceback (most recent call last):\n  File \"/projects/sage/sage-6.9/local/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 905, in execute\n    exec compile(block+'\\n', '', 'single') in namespace, locals\n  File \"\", line 1, in <module>\nTypeError: eval() arg 1 must be a string or code object\n"}︡{"done":true}
︠2aff999f-4821-4664-9104-c1605e0405f4︠




0, 1, 2, 3, -omega, -omega + 1, 2*omega - 1, 2*omega, 2*omega + 1, -omega - 1, 2*omega + 3, 2*omega + 4, 2*omega + 5, -3*omega - 2, omega - 1, omega, omega + 1, omega + 2, omega + 3, omega + 4, 4*omega + 4, 4*omega + 5, 4*omega + 6, 5*omega + 5, 5*omega + 6, 3*omega + 1, 3*omega + 4, 3*omega + 5, -4*omega - 6, -4*omega - 5, -4*omega - 4, -4*omega - 3, -3*omega - 5, -3*omega - 4, -3*omega - 3, -3*omega - 1, -5*omega - 6, -5*omega - 5, omega - 2, -2*omega - 5, -2*omega - 4, -2*omega - 3, -2*omega - 1, -2*omega, -2*omega + 1, -omega + 2, -3, -omega - 4, -1, -omega - 3, -omega - 2, -2*omega - 2, -2
0, 1, 2, 3, -omega, -omega + 1, 2*omega - 1, 2*omega, 2*omega + 1, -omega - 1, 2*omega + 3, 2*omega + 4, 2*omega + 5, -3*omega - 2, omega - 1, omega, omega + 2, omega + 3, omega + 4, 4*omega + 4, 4*omega + 5, 4*omega + 6, 5*omega + 5, 5*omega + 6, 3*omega + 1, 3*omega + 4, 3*omega + 5, -4*omega - 6, -4*omega - 5, -4*omega - 4, -4*omega - 3, -3*omega - 5, -3*omega - 4, -3*omega - 3, -3*omega - 1, -5*omega - 6, -5*omega - 5, omega - 2, -2*omega - 5, -2*omega - 4, -2*omega - 3, -omega - 2, -2*omega, -2*omega + 1, -omega + 2, -3, -omega - 4, -1, -omega- 3, -2*omega - 2, -2*omega - 1, -2









