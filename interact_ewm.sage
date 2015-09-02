load_attach_path('~/classes')
load('AlgorithmForParallelAddition.sage')
import time

alg=None
alg_update=False

if not os.path.exists('./examples/'):
    os.makedirs('./examples/')

try:
    setting_global=load('./examples/last')
except:
    setting_global={'name': 'eisenstein', 'inputAlphabet': '', 'alphabet': '[0, 1, -1, omega, -omega, -omega - 1, omega + 1]', 'base': 'omega - 1', 'minPol_alpGen': 'x^2 + x + 1', 'embedding': -0.500000000000000 + 0.866025403784439*I}


#-----------------Loading-------------------------------------------------------------------
@interact(auto_update=False)
def _(frame_label=text_control('<h3>Load inputs: </h3>', label=''),
     # frame_help=text_control('(Run this cell again to get the previous setting.)', label=''),
      name = input_box(default = setting_global['name'], type = str, label = "Name of the numeration system:"),
      minPol = input_box(default = setting_global['minPol_alpGen'], type = str, label = "Minimal polynomial of ring generator (use variable x):"),
      omegaCC= input_box(default = setting_global['embedding'], type = CC, label = "Embedding (the closest root of minimal polynomial to this value is taken as the ring generator):"),
      alphabet = input_box(default = setting_global['alphabet'], type = str, label = "Alphabet (use \'omega\' as ring generator):"),
      inputAlphabet = input_box(default = setting_global['inputAlphabet'], type = str, label = "Input alphabet (if empty, A + A is used):"),
      base = input_box(default = setting_global['base'], type = str, label = "Base (use \'omega\' as ring generator):"),
      setting_name = input_box(default='', type = str , label = "Or you can load setting from the file (in folder /examples):")
     ):
    try:
        global alg
        global alg_update

        if setting_name:
            setting = load('./examples/'+ setting_name )
            print "The following setting was loaded from ./examples/" + setting_name
            if not 'inputAlphabet' in setting:
                setting['inputAlphabet']=''
            if not 'name' in setting:
                setting['name']=setting_name
            print setting
            global setting_global
            setting_global=setting
            alg= AlgorithmForParallelAddition(setting['minPol_alpGen'], setting['embedding'], setting['alphabet'], setting['base'], setting['name'], setting['inputAlphabet'],  printLog=True, printLogLatex=True)
        else:
            alg= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=True, printLogLatex=True, verbose=0)


        alg_update=False

        save(alg.getDictOfSetting(), './examples/last')

    except Exception, e:
        print "Error:"
        print e

#------------------------main algorithm-----------------------------------------------------
@interact(auto_update=False)
def _(frame_label=text_control('<h3>Find weight function: </h3>', label=''),
      max_iterations= input_box(default = '20', type = Integer, label = "Maximum of iterations to get Weight coefficient set:"),
      max_input_len= input_box(default = '8', type = Integer, label = "Maximal length of weight function input:"),
      frame_help=text_control('Choose required outputs to save:', label=''),
     info=checkbox(default=True, label='General info to .tex file:'),
     WFcsv=checkbox(default=False, label='Weight function to .csv file:'),
     localConversionCsv=checkbox(default=False, label='Local conversion to .csv file:'),
     saveSetting=checkbox(default=True, label='Inputs setting:'),
     saveLog=checkbox(default=True, label='Log file:'),
     saveUnsolved=checkbox(default=False, label='Unsolved inputs after interruption:')
     ):
    try:
        global alg
        global alg_update
        alg_update=False
        unsolved_saved=False

        filename=alg.getName()
        if filename:
            d = os.path.dirname('./outputs/'+filename+'/')
            if not os.path.exists(d):
                os.makedirs(d)
        else:
            raise ValueError("Filename is missing.")

        if saveSetting:
            setting=alg.getDictOfSetting()
            print "The following setting was saved to ./examples/" + filename
            print setting
            save(setting,'./examples/'+ filename )

        print " "
        start=time.clock()
        alg.findWeightFunction(max_iterations,max_input_len)
        end=time.clock()
        alg.addLog("Elapsed time: "+ str(end-start))
        alg_update=True


        print ' '


        print "Saving..."
        sys.stdout.flush()
        if WFcsv:
            alg.saveWeightFunctionToCsvFile("./outputs/"+filename+'/'+filename)
        if localConversionCsv:
            alg.saveLocalConversionToCsvFile("./outputs/"+filename+'/'+filename)

    except KeyboardInterrupt:
        print "Keyboard Interrupt:"
        alg.saveUnsolvedInputsToCsv("./outputs/"+filename+'/'+filename)
        unsolved_saved=True

    except Exception, e:
        print "Error:"
        print e

    finally:
        if info:
            alg.saveInfoToTexFile("./outputs/"+filename+'/'+filename, header=False)
        if saveUnsolved and (not alg_update) and (not unsolved_saved):
            alg.saveUnsolvedInputsToCsv("./outputs/"+filename+'/'+filename)
        if saveLog:
            alg.saveLog("./outputs/"+filename+'/'+filename)


#-----------------sanity check------------------------------------------------------------
@interact(auto_update=False)
def _(frame_label=text_control('<h3>Sanity check: </h3>', label=''),
      len_inp = input_box(default=None, type = Integer , label = "Number of digits for sanity check:"),
     saveLog=checkbox(default=True, label='Save log file after sanity check:')):
    try:
        global alg
        global alg_update
        if not alg_update:
            raise RuntimeError("Weight function search must be updated first.")

        alg.sanityCheck_conversion(len_inp)
        if alg_update and saveLog:
            alg.saveLog("./outputs/"+alg.getName()+'/'+alg.getName())

    except Exception, e:
        print "Error:"
        print e


#-----------------weight function------------------------------------------------------------
@interact(auto_update=False)
def _(frame_label=text_control('<h3>Weight function: </h3>', label=''),
      inp = input_box(default = '(omega,1,2)', type = str, label = "Input tuple of weight function (use \'omega\' as ring generator, zeros are appended if necessary):")):
    try:
        global alg
        global alg_update
        if not alg_update:
            raise RuntimeError("Weight function search must be updated first.")

        inp_alpRing=sage.misc.sage_eval.sage_eval(inp, locals={'omega':alg.getRingGenerator()})
        show("Weight coefficient for input tuple $(x_j, \dots, x_{j-%s}) = " %(len(inp_alpRing)-1) , latex(inp_alpRing) , "$ is: $" ,
             latex(alg.getWeightFunction()(inp_alpRing)),'$')
    except Exception, e:
        print "Error:"
        print e

#-----------------phase 1 plot-----------------------------------------------------------
@interact(auto_update=False)
def _(frame_label=text_control('<h3>Construction of the weight coefficients set: </h3>', label=''),
      folder = input_box(default = 'img', type = str, label = "Save to folder:"),
      _size = input_box(default = 7, type = int, label = "Size of image:")
     ):
    try:
        global alg
        global alg_update

        imgs=alg.plotPhase1()
        show(imgs)
        if folder:
            alg.saveImages(imgs,'./outputs/'+alg.getName()+ '/'+ folder,'phase1',img_size=_size)

    except Exception, e:
        print "Error:"
        print e

#-----------------phase 2 plot-----------------------------------------------------------
@interact(auto_update=False)
def _(frame_label=text_control('<h3>Construction of the weight function: </h3>', label=''),
      inp = input_box(default = '(omega,1,2)', type = str, label = "Tuple of digits from the input alphabet (use \'omega\' as ring generator):"),
     folder = input_box(default = 'img', type = str, label = "Save to folder:"),
      _size = input_box(default = 7, type = int, label = "Size of image:"),
     _legend_xshift= input_box(default = '4', label = "Legend x-shift:"),
     _legend_yshift=  input_box(default = '0', label = "Legend y-shift:"),
     _legend_distance_factor= input_box(default = '1', label = "Legend distance factor:")):
    try:
        global alg
        global alg_update
        if not alg_update:
            raise RuntimeError("Weight function search must be updated first.")

        inp_alpRing=sage.misc.sage_eval.sage_eval(inp, locals={'omega':alg.getRingGenerator()})

        imgs=alg.plotPhase2(inp_alpRing, legend_xshift=_legend_xshift, legend_yshift=_legend_yshift,legend_distance_factor=_legend_distance_factor )
        show(imgs)
        if folder:
            alg.saveImages(imgs,'./outputs/'+alg.getName()+ '/'+ folder,'phase2',img_size=_size)

    except Exception, e:
        print "Error:"
        print e