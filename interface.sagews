︠2d27af7a-83da-4b3c-b1ce-38ab00c52867︠
︠dfd01256-cf8e-4c9b-8176-0b05a951ec3fs︠
load_attach_path('~/classes')
load('AlgorithmForParallelAddition.sage')
import time

alg=None
alg_update=False
try:
    setting_global=load('./examples/last')
except:
    setting_global=load('./examples/default')

if not 'inputAlphabet' in setting_global:
                setting_global['inputAlphabet']=''

#-----------------Loading-------------------------------------------------------------------
@interact(auto_update=False)
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
            alg= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=True, printLogLatex=True, verbose=0)


        alg_update=False

        save(alg.getDictOfSetting(), './examples/last')

    except Exception, e:
        print "Error:"
        print e

#------------------------main algorithm-----------------------------------------------------
@interact(auto_update=False)
def _(frame_label=text_control('<h3>Find weight function: </h3>', label=''),
      max_iterations= input_box(default = '100', type = Integer, label = "Maximum of iterations to get Weight coefficient set:"),
      max_input_len= input_box(default = '10', type = Integer, label = "Maximal length of weight function input:"),
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
        start=time.clock()
        alg.findWeightFunction(max_iterations,max_input_len, method_weightFunSearch=4)
        end=time.clock()
        alg.addLog("Elapsed time: "+ str(end-start))
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
def _(frame_label=text_control('<h3>Construction of the set of weight coefficients: </h3>', label=''),
      folder = input_box(default = 'img', type = str, label = "Save to folder:")
     ):
    try:
        global alg
        global alg_update

        imgs=alg.plotPhase1()
        show(imgs)
        if folder:
            alg.saveImages(imgs,'./outputs/'+alg.getName()+ '/'+ folder,'phase1')

    except Exception, e:
        print "Error:"
        print e

#-----------------phase 2 plot-----------------------------------------------------------
@interact(auto_update=False)
def _(frame_label=text_control('<h3>Construction of the weight function: </h3>', label=''),
      inp = input_box(default = '(omega,1,2)', type = str, label = "Tuple of digits from the input alphabet (use \'omega\' as ring generator):"),
     folder = input_box(default = 'img', type = str, label = "Save to folder:"),
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
            alg.saveImages(imgs,'./outputs/'+alg.getName()+ '/'+ folder,'phase2')

    except Exception, e:
        print "Error:"
        print e

︡e348518c-619f-4950-990e-eca1ba4be85e︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["frame_help",12,null]],[["name",12,null]],[["minPol",12,null]],[["omegaCC",12,null]],[["alphabet",12,null]],[["inputAlphabet",12,null]],[["base",12,null]],[["setting_name",12,null]],[["",12,null]],[["auto_update",2]]],"id":"56e7f2e0-2fd4-4099-8253-db6ba297487b","controls":[{"default":"<h3>Load inputs: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"default":"(Run this cell again to get the previous setting.)","var":"frame_help","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":"eisenstein","label":"Name of the numeration system:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"name","type":"<type 'str'>"},{"control_type":"input-box","default":"x^2 + x + 1","label":"Minimal polynomial of ring generator (use variable x):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"minPol","type":"<type 'str'>"},{"control_type":"input-box","default":"-0.500000000000000 + 0.866025403784439*I","label":"Embedding (the closest root of minimal polynomial to this value is taken as the ring generator):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"omegaCC","type":"Complex Field with 53 bits of precision"},{"control_type":"input-box","default":"[0, 1, -1, omega, -omega, -omega - 1, omega + 1]","label":"Alphabet (use 'omega' as ring generator):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"alphabet","type":"<type 'str'>"},{"control_type":"input-box","default":"[0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -omega - 1, -omega - 2, -2*omega, -omega + 1, -1, -2*omega - 1, -2*omega - 2, -2]","label":"Input alphabet (if empty, A + A is used):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"inputAlphabet","type":"<type 'str'>"},{"control_type":"input-box","default":"omega - 1","label":"Base (use 'omega' as ring generator):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"base","type":"<type 'str'>"},{"control_type":"input-box","default":"","label":"Or you can load setting from the file (in folder /examples):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"setting_name","type":"<type 'str'>"},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["max_iterations",12,null]],[["max_input_len",12,null]],[["frame_help",12,null]],[["info",12,null]],[["WFcsv",12,null]],[["localConversionCsv",12,null]],[["saveSetting",12,null]],[["saveLog",12,null]],[["saveUnsolved",12,null]],[["",12,null]],[["auto_update",2]]],"id":"8719d379-53eb-48ee-a007-d4a70c98a4b8","controls":[{"default":"<h3>Find weight function: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":"100","label":"Maximum of iterations to get Weight coefficient set:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"max_iterations","type":"<type 'sage.rings.integer.Integer'>"},{"control_type":"input-box","default":"10","label":"Maximal length of weight function input:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"max_input_len","type":"<type 'sage.rings.integer.Integer'>"},{"default":"Choose required outputs to save:","var":"frame_help","classes":null,"control_type":"text","label":""},{"default":true,"var":"info","readonly":false,"control_type":"checkbox","label":"General info to .tex file:"},{"default":true,"var":"WFcsv","readonly":false,"control_type":"checkbox","label":"Weight function to .csv file:"},{"default":false,"var":"localConversionCsv","readonly":false,"control_type":"checkbox","label":"Local conversion to .csv file:"},{"default":true,"var":"saveSetting","readonly":false,"control_type":"checkbox","label":"Inputs setting:"},{"default":true,"var":"saveLog","readonly":false,"control_type":"checkbox","label":"Log file:"},{"default":true,"var":"saveUnsolved","readonly":false,"control_type":"checkbox","label":"Unsolved inputs after interruption:"},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["len_inp",12,null]],[["saveLog",12,null]],[["",12,null]],[["auto_update",2]]],"id":"5f7510c9-12e5-4f08-92b9-2be8d1bd0a11","controls":[{"default":"<h3>Sanity check: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":null,"label":"Number of digits for sanity check:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"len_inp","type":"<type 'sage.rings.integer.Integer'>"},{"default":true,"var":"saveLog","readonly":false,"control_type":"checkbox","label":"Save log file after sanity check:"},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["inp",12,null]],[["",12,null]],[["auto_update",2]]],"id":"e3743d8d-6f64-4782-94f8-1338e36bf6cb","controls":[{"default":"<h3>Weight function: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":"(omega,1,2)","label":"Input tuple of weight function (use 'omega' as ring generator, zeros are appended if necessary):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"inp","type":"<type 'str'>"},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["folder",12,null]],[["",12,null]],[["auto_update",2]]],"id":"eef230c8-88b1-47a1-93aa-5c667ce6dc15","controls":[{"default":"<h3>Construction of the set of weight coefficients: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":"img","label":"Save to folder:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"folder","type":"<type 'str'>"},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡{"interact":{"style":"None","flicker":false,"layout":[[["frame_label",12,null]],[["inp",12,null]],[["folder",12,null]],[["_legend_xshift",12,null]],[["_legend_yshift",12,null]],[["_legend_distance_factor",12,null]],[["",12,null]],[["auto_update",2]]],"id":"286f393e-e0fe-4be7-84f5-95417e114073","controls":[{"default":"<h3>Construction of the weight function: </h3>","var":"frame_label","classes":null,"control_type":"text","label":""},{"control_type":"input-box","default":"(omega,1,2)","label":"Tuple of digits from the input alphabet (use 'omega' as ring generator):","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"inp","type":"<type 'str'>"},{"control_type":"input-box","default":"img","label":"Save to folder:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"folder","type":"<type 'str'>"},{"control_type":"input-box","default":"4","label":"Legend x-shift:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"_legend_xshift","type":null},{"control_type":"input-box","default":"0","label":"Legend y-shift:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"_legend_yshift","type":null},{"control_type":"input-box","default":"1","label":"Legend distance factor:","nrows":1,"width":null,"readonly":false,"submit_button":null,"var":"_legend_distance_factor","type":null},{"control_type":"button","default":"Update","label":null,"width":null,"classes":null,"var":"auto_update","icon":null}]}}︡
︠6ce5bb86-9eda-4029-80ac-735ddd66b263︠

︠88d12faf-2ba6-44ce-aaa4-0e750ca6c356s︠



c=alg.plotWeightCoefSet(estimation=True)
len(c)
len(alg.plot(alg.getInputAlphabet()))
︡f8a3809a-0daa-4a24-a77b-b645aca657bd︡{"stdout":"21\n"}︡{"stdout":"20\n"}︡
︠52f6e566-beff-43ac-9747-bfe6232971cfs︠

save(c, './obr.png', figsize=10)
︡3855d57b-500a-4b67-bad8-76118fabf2dc︡
︠a874539b-d693-4776-9b41-38da64fbd296︠









