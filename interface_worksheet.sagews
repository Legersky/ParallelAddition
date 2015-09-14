︠1e5a7270-4dc7-4ed7-9e00-8f3566aef2d2s︠
load_attach_path('~/classes')
load('AlgorithmForParallelAddition.sage')
import time

#------------------Here you can set inputs---------------------------------------------------------------------

#Minimal polynomial of alphabet generator (use variable x):
minPol = 'x^2+x +1'

#Embedding (the closest root of minimal polynomial to this value is taken as the alphabet generator):
omegaCC = I

#Alphabet (use \'omega\' as alphabet generator)
alphabet =   '[0, -1,1, omega, omega+1, -omega-1,-omega]'
inputAlphabet='[]'

#Base (use \'omega\' as alphabet generator)
base = '2*omega+2'

#load('inputs/eisenstein.sage')

#Do you want to plot the set of weight coefficients?  Y/N
plotWeightCoefSet = 'N'

#Do you want to run the sanity check? Y/N
sanCheck= 'N'

#Do you want to save info about algorithm to .tex file? Y/N
infoTex= 'N'
#Enter the name of file:
name='Quadratic+1-2+4_complex_biggerQ'

#Do you want to save also weight function to .tex file? Y/N
weightFunctionTex= 'N'


#Press Shift+Enter to run the program

#---------------------------------------------------------------------------------------------------------------------
start=time.clock()

alg= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=True)

alg.check_alphabet_for_representatives_mod_base_minus_one()
alg.check_alphabet_for_representatives_mod_base()

#alg._findWeightCoefSet(20,method_number=3)
omega=alg.getRingGenerator()
alg._weightCoefSet=[0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -omega - 1, -omega - 2, -2*omega, -omega + 1, -1, -2*omega - 2, -2*omega - 1, -2]
alg._findWeightFunction(15,method_number=4)
#alg.findWeightFunction(20,15,method_weightCoefSet=3,method_weightFunSearch=4)
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



alg.saveInfoToTexFile(output_folder+filename+'/'+filename, header=True, shortInput=False)

alg.saveLog(output_folder+filename+'/'+filename)
︡7cf36792-6645-4c49-845e-ad5587134beb︡{"stdout":"Inicialization...\n"}︡{"stdout":"Numeration system: \n"}︡{"stdout":"Quadratic+1-2+4_complex_biggerQ\n"}︡{"stdout":"Alphabet: \n"}︡{"stdout":"[0, -1, 1, omega, omega + 1, -omega - 1, -omega]\n"}︡{"stdout":"Input alphabet: \n"}︡{"stdout":"[0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -2*omega - 1, -omega - 1, -2*omega, -omega + 1, -1, -2*omega - 2, -omega - 2, -2]\n"}︡{"stdout":"Minimal polynomial of ring generator: \n"}︡{"stdout":"t^2 + t + 1\n"}︡{"stdout":"Embedding: \n"}︡{"stdout":"-0.500000000000000 + 0.866025403784439*I\n"}︡{"stdout":"Base: \n"}︡{"stdout":"2*omega + 2\n"}︡{"stdout":"Minimal polynomial of base:\n"}︡{"stdout":"x^2 - 2*x + 4\n"}︡{"stdout":"Roots of minimal polynomial of base:\n"}︡{"stdout":"[1 - 1.732050807568878?*I, 1 + 1.732050807568878?*I]\n"}︡{"stdout":"With absolute values:\n"}︡{"stdout":"[2.000000000000000?, 2.000000000000000?]\n"}︡{"stdout":"Number of congruence classes mod base - 1 is: 3\n"}︡{"stdout":"There are all elements of the input alphabet mod base-1 in the alphabet.\n"}︡{"stdout":"Number of congruence classes mod base is: 4\n"}︡{"stdout":"Alphabet divided into congruence classes:\n"}︡{"stdout":"[[0], [-1, 1], [omega, -omega], [omega + 1, -omega - 1]]\n"}︡{"stdout":"=> There are all representatives mod base in the alphabet.\n"}︡{"stdout":"Checking one letter inputs...\n"}︡{"stdout":"The longest inputs are:"}︡{"stdout":"\n"}︡{"stdout":"[(1, 1, 1), (2, 2, 2), (-omega, -omega, -omega), (2*omega, 2*omega, 2*omega), (2*omega + 2, 2*omega + 2, 2*omega + 2), (omega, omega, omega), (omega + 1, omega + 1, omega + 1), (-omega - 1, -omega - 1, -omega - 1), (-2*omega, -2*omega, -2*omega), (-1, -1, -1), (-2*omega - 2, -2*omega - 2, -2*omega - 2), (-2, -2, -2)]\n"}︡{"stdout":"Length of one letter input: 3: \n"}︡{"stdout":"Number of letters with longest input: 12\n"}︡{"stdout":"Searching the Weight Function using method 4...\n"}︡{"stdout":"Length of the window: 1, Number of saved combinations of input digits: 0, To next iteration: 19"}︡{"stdout":"\n"}︡{"stdout":"Length of the window: 2, Number of saved combinations of input digits: 145, To next iteration: 216"}︡{"stdout":"\n"}︡{"stdout":"Length of the window: 3, Number of saved combinations of input digits: 3862, To next iteration: 242"}︡{"stdout":"\n"}︡{"stdout":"Length of the window: 4, Number of saved combinations of input digits: 4414, To next iteration: 184"}︡{"stdout":"\n"}︡{"stdout":"Length of the window: 5, Number of saved combinations of input digits: 3412, To next iteration: 84"}︡{"stdout":"\n"}︡{"stdout":"Length of the window: 6, Number of saved combinations of input digits: 1568, To next iteration: 28"}︡{"stdout":"\n"}︡{"stdout":"Length of the window: 7, Number of saved combinations of input digits: 532, To next iteration: 0"}︡{"stdout":"\n"}︡{"stdout":"Weight Coefficient Set is:\n"}︡{"html":"<div align='center'>[$\\displaystyle 0$, $\\displaystyle 1$, $\\displaystyle 2$, $\\displaystyle -\\omega$, $\\displaystyle 2\\omega$, $\\displaystyle 2\\omega + 1$, $\\displaystyle 2\\omega + 2$, $\\displaystyle \\omega - 1$, $\\displaystyle \\omega$, $\\displaystyle \\omega + 1$, $\\displaystyle \\omega + 2$, $\\displaystyle -\\omega - 1$, $\\displaystyle -\\omega - 2$, $\\displaystyle -2\\omega$, $\\displaystyle -\\omega + 1$, $\\displaystyle -1$, $\\displaystyle -2\\omega - 2$, $\\displaystyle -2\\omega - 1$, $\\displaystyle -2$]</div>"}︡{"stdout":"Number of elements:  19\n"}︡{"stdout":"Info about Weight Function for RingGenerator omega -0.500000000000000 + 0.866025403784439*I (root of t^2 + t + 1), alphabet [0, -1, 1, omega, omega + 1, -omega - 1, -omega] and input alphabet [0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -2*omega - 1, -omega - 1, -2*omega, -omega + 1, -1, -2*omega - 2, -omega - 2, -2]\nMaximal input length: 7\nNumber of inputs: 13933\n"}︡{"stdout":"[0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -omega - 1, -omega - 2, -2*omega, -omega + 1, -1, -2*omega - 2, -2*omega - 1, -2]"}︡{"stdout":"\n"}︡{"stdout":"Elapsed time: 56.077631\n"}︡{"stdout":"Info about algorithm for parallel addition saved to ./outputs/Quadratic+1-2+4_complex_biggerQ/Quadratic+1-2+4_complex_biggerQ.tex\n"}︡{"stdout":"Log saved to ./outputs/Quadratic+1-2+4_complex_biggerQ/Quadratic+1-2+4_complex_biggerQ_log.txt\n"}︡
︠54ee6110-45fd-4991-819a-4ff6bfe7b3f1︠
A=alg.getAlphabet()
beta=alg.getBase()
omega=alg.getRingGenerator()

#alg._weightFunSearch._Qw_w
show(alg.plotPhase2((2,2,2,2,2,2)))
︠799b3df0-bea9-42e6-80e2-8348d9eaed5b︠
wfs=alg._weightFunSearch
wfs._verbose=1

wfs._Qw_w[()]=wfs._weightCoefSet
longest=[()]
wfs._algForParallelAdd._problematicLetters=[]
for a in [4]:
    if wfs._verbose>=1: print "Processing input", a,',', a, '...'
    w_tuple=(a,)
    Qww=wfs._findQw(w_tuple)
    if wfs._verbose>=1:
        print Qww
        show(alg.plot(Qww))
    inp_len=1
    wfs._Qw_w[w_tuple]+=[-omega-2,-2*omega-2]
    print wfs._Qw_w[w_tuple]
    prevQww=Set(Qww)
    while len(Qww)>1:
#        if inp_len>=max_input_length:
 #           wfs._algForParallelAdd.addLog("Inputs are longer than the given maximum: %s" %(max_input_length))
  #          raise RuntimeError("Inputs are longer than the given maximum: %s" %(max_input_length))
        w_tuple = w_tuple+(a,)
        Qww=wfs._findQw(w_tuple)    #find Qww for the tuple and save weight coefficient if there is only one element in Qww
        if wfs._verbose>=1:
            print Qww
            show(alg.plot(Qww))
        if prevQww==Set(Qww):
            wfs._algForParallelAdd.addLog("There is no unique weight coefficient for finite input gained by repetition of letter %s using method number %s" %(a,wfs._method))
            wfs._algForParallelAdd._problematicLetters.append(a)
            break
        if len(Qww)==1:
            wfs._weightFunction.addWeightCoefToInput(w_tuple, Qww[0])
        inp_len+=1
        prevQww=Set(Qww)
    if len(w_tuple)>len(longest[0]):
        longest=[w_tuple]
    elif len(w_tuple)==len(longest[0]):
        longest.append(w_tuple)
if wfs._algForParallelAdd._problematicLetters:
    raise RuntimeError("There is no unique weight coefficient for finite input gained by repetition of letters %s using method number %s" %(wfs._algForParallelAdd._problematicLetters,wfs._method))
︠f8002e9e-6079-47fd-aaf5-e0ad1dc0e33es︠



len([0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -2*omega - 1, -omega - 2, -2*omega, -omega + 1, -1, -2*omega - 2, -omega - 1, -2])
︡29086692-35c0-49b9-ba05-7186df05577b︡{"stdout":"19\n"}︡
︠856b2f65-b4cb-4485-bf0e-5e62a7f53836︠









