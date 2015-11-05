︠1e5a7270-4dc7-4ed7-9e00-8f3566aef2d2︠
load_attach_path('~/classes')
load('AlgorithmForParallelAddition.sage')
import time

#------------------Here you can set inputs---------------------------------------------------------------------

#Minimal polynomial of alphabet generator (use variable x):
minPol = 'x^2+x+1'

#Embedding (the closest root of minimal polynomial to this value is taken as the alphabet generator):
omegaCC = I

#Alphabet (use \'omega\' as alphabet generator)
alphabet =  '[0,1,2,-1,-2, 3, -3]' #'[0, -1,1, omega, omega+1, -omega-1,-omega]'
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

︡775ee361-93a7-45c1-bca2-57a16f6fe672︡︡{"stdout":"Inicialization...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Numeration system: \n","done":false}︡{"stdout":"testing\n","done":false}︡{"stdout":"Alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, -1, -2, 3, -3]\n","done":false}︡{"stdout":"Input alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, 3, 4, 5, 6, -2, -6, -5, -4, -3, -1]\n","done":false}︡{"stdout":"Ring generator: \n","done":false}︡{"stdout":"1/2*I*sqrt(3) - 1/2\n","done":false}︡{"stdout":"Minimal polynomial of ring generator: \n","done":false}︡{"stdout":"t^2 + t + 1","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Base: \n","done":false}︡{"stdout":"omega - 1 = 1/2*I*sqrt(3) - 3/2\n","done":false}︡{"stdout":"Minimal polynomial of base:\n","done":false}︡{"stdout":"x^2 + 3*x + 3\n","done":false}︡{"stdout":"Conjugates of base:\n","done":false}︡{"stdout":"[-1/2*I*sqrt(3) - 3/2, 1/2*I*sqrt(3) - 3/2]","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"With absolute values:\n","done":false}︡{"stdout":"[sqrt(3), sqrt(3)]\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base:\n","done":false}︡{"stdout":"Number of congruence classes mod base is: 3\n","done":false}︡{"stdout":"Alphabet divided into congruence classes:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[[0, 3, -3], [1, -2], [2, -1]]\n","done":false}︡{"stdout":"=> There are all representatives mod base in the alphabet.\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base-1:\n","done":false}︡{"stdout":"Number of congruence classes mod base - 1 is: 7\n","done":false}︡{"stdout":"There are all elements of the input alphabet mod base-1 in the alphabet.","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Phase 1 - Searching for the Weight Coefficient Set using method 2...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Starting Q_0:\n","done":false}︡{"stdout":"[0]\n","done":false}︡{"stdout":"Number of elements in Qk: 1","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-omega - 2, omega + 2]\n","done":false}︡{"stdout":"Number of elements in Qk: 3","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[2*omega + 3, -omega - 1, 1, -2*omega - 3, omega + 1, -1]\n","done":false}︡{"stdout":"Number of elements in Qk: 9","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[-omega, -2*omega - 4, 2, -2*omega - 2, -3*omega - 4, 3*omega + 4, omega, -2, -omega - 3, omega + 3, 2*omega + 4]\n","done":false}︡{"stdout":"Number of elements in Qk: 20","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[-omega + 1, 2*omega + 1, -3*omega - 5, -2*omega - 1, -3*omega - 3, 4*omega + 5, omega - 1, 3*omega + 5, -4*omega - 5]\n","done":false}︡{"stdout":"Number of elements in Qk: 29","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[2*omega, -2*omega, -3*omega - 2, -4*omega - 4, 4*omega + 4]\n","done":false}︡{"stdout":"Number of elements in Qk: 34","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-omega + 2, -omega - 4, -3, omega - 2, omega + 4]\n","done":false}︡{"stdout":"Number of elements in Qk: 39","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[2*omega + 5, -2*omega - 5]\n","done":false}︡{"stdout":"Number of elements in Qk: 41","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[4*omega + 6, -4*omega - 6]\n","done":false}︡{"stdout":"Number of elements in Qk: 43","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-5*omega - 6, 5*omega + 6]\n","done":false}︡{"stdout":"Number of elements in Qk: 45","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[5*omega + 5, 3*omega + 1, 2*omega - 1, -2*omega + 1, -3*omega - 1, -4*omega - 3, -5*omega - 5]\n","done":false}︡{"stdout":"Number of elements in Qk: 52","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[3]\n","done":false}︡{"stdout":"Number of elements in Qk: 53","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[]\n","done":false}︡{"stdout":"The Weight Coefficient Set is:\n","done":false}︡{"stdout":"[0, 1, 2, 3, -omega, -omega + 1, 2*omega - 1, 2*omega, 2*omega + 1, -omega - 1, 2*omega + 3, 2*omega + 4, 2*omega + 5, -3*omega - 2, omega - 1, omega, omega + 1, omega + 2, omega + 3, omega + 4, 4*omega + 4, 4*omega + 5, 4*omega + 6, 5*omega + 5, 5*omega + 6, 3*omega + 1, 3*omega + 4, 3*omega + 5, -4*omega - 6, -4*omega - 5, -4*omega - 4, -4*omega - 3, -3*omega - 5, -3*omega - 4, -3*omega - 3, -3*omega - 1, -5*omega - 6, -5*omega - 5, omega - 2, -2*omega - 5, -2*omega - 4, -2*omega - 3, -2*omega - 1, -2*omega, -2*omega + 1, -omega + 2, -3, -omega - 4, -1, -omega - 3, -omega - 2, -2*omega - 2, -2]\n","done":false}︡{"stdout":"Number of elements: 53\n","done":false}︡{"stdout":"Phase 2 is starting...\n","done":false}︡{"stdout":"Checking one letter inputs...\n","done":false}︡{"stdout":"There is no unique weight coefficient for finite input gained by repetition of letter 1 using method number 4","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"There is no unique weight coefficient for finite input gained by repetition of letter 2 using method number 4","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"There is no unique weight coefficient for finite input gained by repetition of letter 3 using method number 4","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"There is no unique weight coefficient for finite input gained by repetition of letter 6 using method number 4","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"There is no unique weight coefficient for finite input gained by repetition of letter -2 using method number 4","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"There is no unique weight coefficient for finite input gained by repetition of letter -6 using method number 4","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"There is no unique weight coefficient for finite input gained by repetition of letter -3 using method number 4","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"There is no unique weight coefficient for finite input gained by repetition of letter -1 using method number 4","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"The following results were saved to google spreadsheet ParallelAddition_results","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"['2015-11-04 22:54', 'testing', [0, 1, 2, -1, -2, 3, -3], 'A+A', 1/2*I*sqrt(3) - 1/2, t^2 + t + 1, 'omega - 1 = 1/2*I*sqrt(3) - 3/2', x^2 + 3*x + 3, [-1/2*I*sqrt(3) - 3/2, 1/2*I*sqrt(3) - 3/2], [sqrt(3), sqrt(3)], [[0, 3, -3], [1, -2], [2, -1]], [], [[0], [1], [2], [-1], [-2], [3], [-3]], [], 'yes', 2, 'OK', 53, [1, 3, 9, 20, 29, 34, 39, 41, 43, 45, 52, 53], 4, [1, 2, 3, 6, -2, -6, -3, -1], '-', 'x', '-', [], '-', '-5.035348']\n","done":false}︡{"done":false,"stderr":"Error in lines 27-54\n"}︡{"done":false,"stderr":"Traceback (most recent call last):\n  File \"/projects/sage/sage-6.9/local/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 905, in execute\n    exec compile(block+'\\n', '', 'single') in namespace, locals\n  File \"\", line 8, in <module>\n  File \"<string>\", line 256, in findWeightFunction\n  File \"<string>\", line 227, in _findWeightFunction\n  File \"<string>\", line 245, in check_one_letter_inputs\nRuntimeError: There is no unique weight coefficient for finite input gained by repetition of letters [1, 2, 3, 6, -2, -6, -3, -1] using method number 4\n"}︡{"done":true}
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









