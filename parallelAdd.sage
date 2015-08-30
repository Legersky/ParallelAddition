load_attach_path('./classes')
load('AlgorithmForParallelAddition.sage')

load('input_sample.sage')
no_images=False

import sys
import time

alg=None
alg_update=False

load(sys.argv[1])

if no_images:
    alphabet_img=False        #save image of alphabet and input alphabet
    lattice_img=False         #save image of lattice with shifted alphabet
    phase1_images=False       #save step-by-step images of phase 1
    weightCoefSet_img=False   #save image of the weight coefficient set
    phase2_images=False       #save step-by-step images of phase 2

try:
    alg= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=True, verbose=0)

    alg_update=False
    unsolved_saved=False

    filename=alg.getName()
    output_folder='./outputs_WFmethod_'+ str(sys.argv[2])+'/'

    if filename:
        d = os.path.dirname(output_folder+filename+'/')
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

    if alphabet_img:
        alg.saveImages([alg.plotAlphabet()],output_folder+ filename + '/img','alphabet')
        alg.saveImages([alg.plot(alg._inputAlphabet, color='blue')+alg.plotAlphabet()],output_folder+ filename + '/img','inputAlphabet')

    if lattice_img:
        alg.saveImages([alg.plotLattice()],output_folder+ filename + '/img','lattice')

    alg.addLog("Maximum iterations: " + str(max_iterations))
    alg.addLog("Maximum length of input of weight function: " + str(max_input_length))

    start=time.clock()
    alg.findWeightFunction(max_iterations,max_input_length,method_weightFunSearch=int(sys.argv[2]))


    alg_update=True

    print '\n'

    print "Saving..."
    sys.stdout.flush()

    if WFcsv:
        alg.saveWeightFunctionToCsvFile(output_folder+filename+'/'+filename)

    if localConversionCsv:
        alg.saveLocalConversionToCsvFile(output_folder+filename+'/'+filename)

    if sanityCheck:
        er=alg.sanityCheck_conversion(alg.getWeightFunction().getMaxLength()+1)

except KeyboardInterrupt:
    print "Keyboard Interrupt:"
    if saveUnsolved:
        alg.saveUnsolvedInputsToCsv(output_folder+filename+'/'+filename)
        unsolved_saved=True

except Exception, e:
    print "Error:"
    alg.addLog(e)

finally:
    end=time.clock()
    alg.addLog("Elapsed time: "+ str(end-start))

    if info:
        alg.saveInfoToTexFile(output_folder+filename+'/'+filename, header=False, shortInput=True)

    if saveLog:
        alg.saveLog(output_folder+filename+'/'+filename)

    if alg._weightCoefSet:
        if phase1_images:
            imgs1=alg.plotPhase1()
            alg.saveImages(imgs1,output_folder+ filename + '/img','phase1')

        if weightCoefSet_img:
            alg.saveImages([alg.plotWeightCoefSet(estimation)],output_folder+ filename + '/img','weightCoefficientsSet')

    if phase2_images and alg._weightFunction:
        imgs2=alg.plotPhase2(sage.misc.sage_eval.sage_eval(phase2_input, locals={'omega':alg.getRingGenerator()}))
        alg.saveImages(imgs2,output_folder+ filename + '/img','phase2')

    if saveUnsolved and not alg_update and not unsolved_saved:
        alg.saveUnsolvedInputsToCsv(output_folder+filename+'/'+filename)
    print '--------------------------end of '+ filename +'---------------------------------------------'
