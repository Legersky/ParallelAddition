︠fac1a72d-5fed-4f1f-a65c-66a9f2f103c6i︠

︡ef049787-2781-4f96-831f-d53351c505bb︡
︠dfd01256-cf8e-4c9b-8176-0b05a951ec3fs︠
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
      minPol = input_box(default = setting_global['minPol_alpGen'], type = str, label = "Minimal polynomial of alphabet generator (use variable x):"),
      omegaCC= input_box(default = setting_global['embedding'], type = CC, label = "Embedding (the closest root of minimal polynomial to this value is taken as the alphabet generator):"),
      alphabet = input_box(default = setting_global['alphabet'], type = str, label = "Alphabet (use \'omega\' as alphabet generator):"),
      inputAlphabet = input_box(default = setting_global['inputAlphabet'], type = str, label = "Input alphabet (if empty, A + A is used):"),
      base = input_box(default = setting_global['base'], type = str, label = "Base (use \'omega\' as alphabet generator):"),
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
            alg= AlgorithmForParallelAddition(setting['minPol_alpGen'], setting['embedding'], setting['alphabet'], setting['base'], setting['name'], setting['inputAlphabet'],  printLog=True)
        else:
            alg= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=True)

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
      inp = input_box(default = '(omega,1,2)', type = str, label = "Input tuple of weight function (use \'omega\' as alphabet generator, zeros are appended if necessary):")):
    try:
        global alg
        global alg_update
        if not alg_update:
            raise RuntimeError("Weight function search must be updated first.")

        inp_alpRing=sage.misc.sage_eval.sage_eval(inp, locals={'omega':alg.getAlphabetGenerator()})
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

︡eb33b360-97e2-44ca-a769-9eecbfcb055b︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["frame_help",12,null]],[["name",12,null]],[["minPol",12,null]],[["omegaCC",12,null]],[["alphabet",12,null]],[["inputAlphabet",12,null]],[["base",12,null]],[["setting_name",12,null]],[["",12,null]],[["auto_update",2]]],"id":"8a2c3258-fe8a-4080-9591-0fa26d263452","controls":[{"default":"<h3>Load inputs: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"default":"(Run this cell again to get the previous setting.)","var":"frame_help","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":"ctyri","label":"Name of the numeration system:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"name","type":"<type 'str'>"},{"control_type":"input-box","default":"x - 1","label":"Minimal polynomial of alphabet generator (use variable x):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"minPol","type":"<type 'str'>"},{"control_type":"input-box","default":"1.00000000000000","label":"Embedding (the closest root of minimal polynomial to this value is taken as the alphabet generator):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"omegaCC","type":"Complex Field with 53 bits of precision"},{"control_type":"input-box","default":"[-2, -1, 0, 1, 2]","label":"Alphabet (use 'omega' as alphabet generator):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"alphabet","type":"<type 'str'>"},{"control_type":"input-box","default":"[0, 1, 2, 3, 4, -1, -4, -3, -2]","label":"Input alphabet (if empty, A + A is used):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"inputAlphabet","type":"<type 'str'>"},{"control_type":"input-box","default":"4","label":"Base (use 'omega' as alphabet generator):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"base","type":"<type 'str'>"},{"control_type":"input-box","default":"","label":"Or you can load setting from the file (in folder /examples):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"setting_name","type":"<type 'str'>"},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["frame_help",12,null]],[["info",12,null]],[["WFcsv",12,null]],[["localConversionCsv",12,null]],[["saveSetting",12,null]],[["saveLog",12,null]],[["saveUnsolved",12,null]],[["",12,null]],[["auto_update",2]]],"id":"f07133d6-c5b1-478e-8eec-30ac429b53df","controls":[{"default":"<h3>Find weight function: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"default":"Choose required outputs to save:","var":"frame_help","classes":null,"control_type":"text","label":""},{"default":true,"var":"info","readonly":false,"control_type":"checkbox","label":"General info to .tex file:"},{"default":true,"var":"WFcsv","readonly":false,"control_type":"checkbox","label":"Weight function to .csv file:"},{"default":false,"var":"localConversionCsv","readonly":false,"control_type":"checkbox","label":"Local conversion to .csv file:"},{"default":true,"var":"saveSetting","readonly":false,"control_type":"checkbox","label":"Inputs setting:"},{"default":true,"var":"saveLog","readonly":false,"control_type":"checkbox","label":"Log file:"},{"default":true,"var":"saveUnsolved","readonly":false,"control_type":"checkbox","label":"Unsolved inputs after interruption:"},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["inp",12,null]],[["",12,null]],[["auto_update",2]]],"id":"d09a77a8-2ef5-4994-986a-077a1899d2d2","controls":[{"default":"<h3>Weight function: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":"(omega,1,2)","label":"Input tuple of weight function (use 'omega' as alphabet generator, zeros are appended if necessary):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"inp","type":"<type 'str'>"},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["len_inp",12,null]],[["saveLog",12,null]],[["",12,null]],[["auto_update",2]]],"id":"1dd5dfea-0cc0-4b2d-a9e5-be57ad5bff57","controls":[{"default":"<h3>Sanity check: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":null,"label":"Number of digits for sanity check:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"len_inp","type":"<type 'sage.rings.integer.Integer'>"},{"default":true,"var":"saveLog","readonly":false,"control_type":"checkbox","label":"Save log file after sanity check:"},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡
︠69a6d829-8a26-452a-b42c-ef0f464a5da9︠
︠85df4655-3f50-4148-bb71-52dea0d823dci︠
︡be1ed3fd-9b51-4fd6-94af-8a5491e8d1ea︡
︠4ecbed0a-eb0e-4bd2-bbba-bcfb2b92d7b9︠











