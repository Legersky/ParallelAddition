load_attach_path('./classes')
load('AlgorithmForParallelAddition.sage')

load('input_sample.sage')

import sys
import time

alg=None
alg_update=False

load(sys.argv[1])

try:
    alg= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=True)

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

    if alphabet_img:
        alg.saveImages([alg.plotAlphabet()],'./outputs/'+ filename + '/img','alphabet')
        alg.saveImages([alg.plot(alg._inputAlphabet, color='blue')+alg.plotAlphabet()],'./outputs/'+ filename + '/img','inputAlphabet')

    if lattice_img:
        alg.saveImages([alg.plotLattice()],'./outputs/'+ filename + '/img','lattice')

    alg.addLog("Maximum iterations: " + str(max_iterations))
    alg.addLog("Maximum length of input of weight function: " + str(max_input_length))

    start=time.clock()
    alg.findWeightFunction(max_iterations,max_input_length)
    end=time.clock()
    alg.addLog("Elapsed time: "+ str(end-start))

    alg_update=True

    print '\n'

    print "Saving..."
    sys.stdout.flush()

    if WFcsv:
        alg.saveWeightFunctionToCsvFile("./outputs/"+filename+'/'+filename)

    if localConversionCsv:
        alg.saveLocalConversionToCsvFile("./outputs/"+filename+'/'+filename)

    if phase1_images:
        imgs1=alg.plotPhase1()
        alg.saveImages(imgs1,'./outputs/'+ filename + '/img','phase1')

    if weightCoefSet_img:
        alg.saveImages([alg.plotWeightCoefSet(estimation)],'./outputs/'+ filename + '/img','weightCoefficientsSet')

    if phase2_images:
        imgs2=alg.plotPhase2(sage.misc.sage_eval.sage_eval(phase2_input, locals={'omega':alg.getRingGenerator()}))
        alg.saveImages(imgs2,'./outputs/'+ filename + '/img','phase2')

    if sanityCheck:
        er=alg.sanityCheck_conversion(alg.getWeightFunction().getMaxLength()+1)

except KeyboardInterrupt:
    print "Keyboard Interrupt:"
    if saveUnsolved:
        alg.saveUnsolvedInputsToCsv("./outputs/"+filename+'/'+filename)
        unsolved_saved=True

except Exception, e:
    print "Error:"
    print e

finally:
    if info:
        alg.saveInfoToTexFile("./outputs/"+filename+'/'+filename, header=False, for_researchThesis=True)
    if saveLog:
        alg.saveLog("./outputs/"+filename+'/'+filename)
    if saveUnsolved and not alg_update and not unsolved_saved:
        alg.saveUnsolvedInputsToCsv("./outputs/"+filename+'/'+filename)
    print '--------------------------end of '+ filename +'---------------------------------------------'
