︠d036622f-9a67-4df9-a2ac-e69ebcf258a9s︠
#------------INPUTS---------------------
#Name of the numeration system
name = 'x^2 + x + 2_automaticAlphabet'
#Minimal polynomial of ring generator (use variable x)
minPol ='x^2 + x + 2'
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
methods_phase2=[16]        #methods in the list are used. If empty, default method is used.
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
︡9ecd3d11-8f8b-44d8-b03b-abf91e68ea2a︡︡{"done":false,"stderr":"<string>:225: DeprecationWarning: CartesianProduct is deprecated. Use cartesian_product instead\nSee http://trac.sagemath.org/18411 for details.\n"}︡{"stdout":"Inicialization...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Numeration system: \n","done":false}︡{"stdout":"x^2 + x + 2_automaticAlphabet\n","done":false}︡{"stdout":"Alphabet: \n","done":false}︡{"stdout":"[0, omega + 1, 1, -1]\n","done":false}︡{"stdout":"Input alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, omega, omega + 1, omega + 2, -1, 2*omega + 2, -2]\n","done":false}︡{"stdout":"Ring generator: \n","done":false}︡{"stdout":"1/2*I*sqrt(7) - 1/2\n","done":false}︡{"stdout":"Minimal polynomial of ring generator: \n","done":false}︡{"stdout":"t^2 + t + 2\n","done":false}︡{"stdout":"Base: \n","done":false}︡{"stdout":"omega = 1/2*I*sqrt(7) - 1/2\n","done":false}︡{"stdout":"Minimal polynomial of base:\n","done":false}︡{"stdout":"x^2 + x + 2\n","done":false}︡{"stdout":"Conjugates of base:\n","done":false}︡{"stdout":"[-1/2*I*sqrt(7) - 1/2, 1/2*I*sqrt(7) - 1/2]\n","done":false}︡{"stdout":"With absolute values:\n","done":false}︡{"stdout":"[sqrt(2), sqrt(2)]\n","done":false}︡{"stdout":" \nMaximum iterations: 20\n","done":false}︡{"stdout":"Maximum length of input of weight function: 10\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base:\n","done":false}︡{"stdout":"Number of congruence classes mod base is: 2\n","done":false}︡{"stdout":"Alphabet divided into congruence classes:\n","done":false}︡{"stdout":"[[0], [omega + 1, 1, -1]]\n","done":false}︡{"stdout":"=> There are all representatives mod base in the alphabet.\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base-1:\n","done":false}︡{"stdout":"Number of congruence classes mod base - 1 is: 4\n","done":false}︡{"stdout":"There are all elements of the input alphabet mod base-1 in the alphabet.\n","done":false}︡{"stdout":"Phase 1 - Searching for the Weight Coefficient Set using method 3...\n","done":false}︡{"stdout":"Starting Q_0:\n","done":false}︡{"stdout":"[0]\n","done":false}︡{"stdout":"Number of elements in Qk: 1","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-omega - 1, 1, -omega, -omega + 1, omega + 1]\n","done":false}︡{"stdout":"Number of elements in Qk: 6\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-1, -omega - 2, omega]\n","done":false}︡{"stdout":"Number of elements in Qk: 9\n","done":false}︡{"stdout":"Added coefficients:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[2, omega + 2, 2*omega + 1, -omega + 2]\n","done":false}︡{"stdout":"Number of elements in Qk: 13\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-2*omega - 2, -2*omega - 1, -2*omega - 3, -2*omega + 1, -2*omega]\n","done":false}︡{"stdout":"Number of elements in Qk: 18","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[2*omega, -2, -omega - 3, omega - 1]\n","done":false}︡{"stdout":"Number of elements in Qk: 22","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[3, omega + 3, 2*omega + 2, -omega + 3]\n","done":false}︡{"stdout":"Number of elements in Qk: 26","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-2*omega + 2]\n","done":false}︡{"stdout":"Number of elements in Qk: 27","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-2*omega - 4]\n","done":false}︡{"stdout":"Number of elements in Qk: 28","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[3*omega + 1]\n","done":false}︡{"stdout":"Number of elements in Qk: 29","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[]\n","done":false}︡{"stdout":"The Weight Coefficient Set is:\n","done":false}︡{"stdout":"[0, 1, 2, 3, -2*omega, -2*omega + 1, -2*omega - 2, -2*omega + 2, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, omega + 3, -2*omega - 4, -2*omega - 3, -2*omega - 1, -omega, -omega + 1, -omega + 2, -omega + 3, -2, 3*omega + 1, -omega - 3, -omega - 2, -omega - 1, -1]\n","done":false}︡{"stdout":"Number of elements: 29\n","done":false}︡{"stdout":"Phase 2 is starting...\n","done":false}︡{"stdout":"Checking one letter inputs...\n","done":false}︡{"stdout":"The longest inputs are:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[(1, 1, 1, 1, 1, 1), (omega + 1, omega + 1, omega + 1, omega + 1, omega + 1, omega + 1)]\n","done":false}︡{"stdout":"Length of one letter input: 6: \n","done":false}︡{"stdout":"Number of letters with longest input: 2\n","done":false}︡{"stdout":"Searching the Weight Function using method 16...\n","done":false}︡{"stdout":"Length of the window: 1, Number of saved combinations of input digits: 0, To next iteration: 9","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 2, Number of saved combinations of input digits: 0, To next iteration: 81","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Elapsed time: 6.408224","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"The following row was added to google spreadsheet ParallelAddition_results, worksheet: results","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"['2016-02-24 15:02', 'x^2 + x + 2_automaticAlphabet', [0, omega + 1, 1, -1], 'A+A', 1/2*I*sqrt(7) - 1/2, t^2 + t + 2, 'omega = 1/2*I*sqrt(7) - 1/2', x^2 + x + 2, [-1/2*I*sqrt(7) - 1/2, 1/2*I*sqrt(7) - 1/2], [sqrt(2), sqrt(2)], [[0], [omega + 1, 1, -1]], [], [[0], [omega + 1], [1], [-1]], [], 'yes', 3, 'OK', 29, [1, 6, 9, 13, 18, 22, 26, 27, 28, 29], 16, 'OK', 6, 'x', '-', [0, 0], '-', 6.40822399999999, \"unsupported operand parent(s) for '-': 'Vector space of dimension 2 over Rational Field' and 'Ambient free module of rank 1 over the principal ideal domain Integer Ring'\", '']\n","done":false}︡{"stdout":"Info about algorithm for parallel addition saved to ./outputs/x^2 + x + 2_automaticAlphabet/methods_3-16/x^2 + x + 2_automaticAlphabet.tex\n","done":false}︡{"stdout":"Log saved to ./outputs/x^2 + x + 2_automaticAlphabet/methods_3-16/x^2 + x + 2_automaticAlphabet_log.txt\n","done":false}︡{"stdout":"--------------------------end of x^2 + x + 2_automaticAlphabet---------------------------------------------\n","done":false}︡{"done":false,"stderr":"Error in lines 43-43\n"}︡{"done":false,"stderr":"Traceback (most recent call last):\n  File \"/projects/sage/sage-6.10/local/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 905, in execute\n    exec compile(block+'\\n', '', 'single') in namespace, locals\n  File \"\", line 1, in <module>\n  File \"/projects/sage/sage-6.10/local/lib/python2.7/site-packages/smc_sagews/sage_salvus.py\", line 3232, in load\n    exec 'salvus.namespace[\"%s\"] = sage.structure.sage_object.load(*__args, **__kwds)'%t in salvus.namespace, {'__args':other_args, '__kwds':kwds}\n  File \"<string>\", line 1, in <module>\n  File \"sage/structure/sage_object.pyx\", line 1018, in sage.structure.sage_object.load (/projects/sage/sage-6.10/src/build/cythonized/sage/structure/sage_object.c:11434)\n    sage.repl.load.load(filename, globals())\n  File \"/projects/sage/sage-6.10/local/lib/python2.7/site-packages/sage/repl/load.py\", line 290, in load\n    exec(preparse_file(open(fpath).read()) + \"\\n\", globals)\n  File \"<string>\", line 73, in <module>\n  File \"<string>\", line 346, in findWeightFunction\n  File \"<string>\", line 325, in _findWeightFunction\n  File \"<string>\", line 292, in findWeightFunction\n  File \"<string>\", line 44, in _find_weightCoef_for_comb_B\n  File \"<string>\", line 237, in _findQw\n  File \"<string>\", line 427, in _pick_element_closest_to_point_betaNorm\n  File \"sage/structure/element.pyx\", line 1337, in sage.structure.element.ModuleElement.__sub__ (/projects/sage/sage-6.10/src/build/cythonized/sage/structure/element.c:11613)\n    return coercion_model.bin_op(left, right, sub)\n  File \"sage/structure/coerce.pyx\", line 1069, in sage.structure.coerce.CoercionModel_cache_maps.bin_op (/projects/sage/sage-6.10/src/build/cythonized/sage/structure/coerce.c:9736)\n    raise TypeError(arith_error_message(x,y,op))\nTypeError: unsupported operand parent(s) for '-': 'Vector space of dimension 2 over Rational Field' and 'Ambient free module of rank 1 over the principal ideal domain Integer Ring'\n"}︡{"done":true}
︠6b4ccdb8-15c4-43db-af9a-9380a8cc0703︠









