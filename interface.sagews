︠fac1a72d-5fed-4f1f-a65c-66a9f2f103c6i︠
︠dfd01256-cf8e-4c9b-8176-0b05a951ec3f︠
load_attach_path('~/classes')
load('AlgorithmForParallelAddition.sage')

alg=None
alg_update=False
try:
    setting_global=load('./examples/last')
except:
    setting_global=load('./examples/default')

if not 'inputAlphabet' in setting_global:
                setting_global['inputAlphabet']=''

@interact(auto_update=False)        #Loading
def _(frame_label=text_control('<h3>Load inputs: </h3>', label=''),
      frame_help=text_control('(Run this cell again to get the previous setting.)', label=''),
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
            alg= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=True, printLogLatex=True)

        alg_update=False

        save(alg.getDictOfSetting(), './examples/last')

    except Exception, e:
        print "Error:"
        print e

@interact(auto_update=False)    #main algorithm
def _(frame_label=text_control('<h3>Find weight function: </h3>', label=''),
      frame_help=text_control('Choose required outputs to save:', label=''),
     info=checkbox(default=True, label='General info to .tex file:'),
     WFcsv=checkbox(default=True, label='Weight function to .csv file:'),
     localConversionCsv=checkbox(default=False, label='Local conversion to .csv file:'),
     saveSetting=checkbox(default=True, label='Inputs setting:'),
     saveLog=checkbox(default=True, label='Log file:'),
     saveUnsolved=checkbox(default=True, label='Unsolved inputs after interruption:')
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
        alg.findWeightFunction()
        alg_update=True


        print '\n'

        print "Saving..."
        sys.stdout.flush()
        if info:
            alg.saveInfoToTexFile("./outputs/"+filename+'/'+filename)
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
        if saveLog:
            alg.saveLog("./outputs/"+filename+'/'+filename)
        if saveUnsolved and not alg_update and not unsolved_saved:
            alg.saveUnsolvedInputsToCsv("./outputs/"+filename+'/'+filename)

@interact(auto_update=False)    #weight function
def _(frame_label=text_control('<h3>Weight function: </h3>', label=''),
      inp = input_box(default = '(omega,1,2)', type = str, label = "Input tuple of weight function (use \'omega\' as ring generator, zeros are appended if necessary):")):
    try:
        global alg
        global alg_update
        if not alg_update:
            raise RuntimeError("Weight function search must be updated first.")

        inp_alpRing=sage.misc.sage_eval.sage_eval(inp, locals={'omega':alg.getRingGenerator()})
        show("Weight coefficient for input tuple $(x_j, \dots, x_{j-%s}) = " %(len(inp_alpRing)-1) , latex(inp_alpRing) , "$ is: $" , latex(alg.getWeightFunction()(inp_alpRing)),'$')
    except Exception, e:
        print "Error:"
        print e


@interact(auto_update=False)        #sanity check
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











