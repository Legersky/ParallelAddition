import os
import inspect
import time
import sys

load_attach_path('classes')
load('AlgorithmForParallelAddition.sage')


alg=None
alg_update=False


try:
    alg= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=True)

    alg_update=False
    unsolved_saved=False

    filename=alg.getName()
    output_folder=folder_path

    if filename:
        d = os.path.dirname(output_folder+filename+'/')
        if not os.path.exists(d):
            os.makedirs(d)
    else:
        raise ValueError("Filename is missing.")

    print " "

    if alphabet_img:
        alg.saveImages([alg.plotAlphabet()],output_folder+ filename + '/img','alphabet')
        alg.saveImages([alg.plot(alg._inputAlphabet, color='blue')+alg.plotAlphabet()],output_folder+ filename + '/img','inputAlphabet')

    if lattice_img:
        alg.saveImages([alg.plotLattice()],output_folder+ filename + '/img','lattice')

    alg.addLog("Maximum iterations: " + str(max_iterations))
    alg.addLog("Maximum length of input of weight function: " + str(max_input_length))

    start=time.clock()
    alg.findWeightFunction(max_iterations,max_input_length)


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

    alg.saveResults(end-start)

    if info:
        alg.saveInfoToTexFile(output_folder+filename+'/'+filename, header=True, shortInput=False)

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