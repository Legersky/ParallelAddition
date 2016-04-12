import os
import inspect
import time
import sys

try:
    classes_loaded
except:
    load_attach_path('classes')
    load('AlgorithmForParallelAddition.sage')


alg=None
alg_update=False
images=0#True

if methods_phase1==[]:
    methods_phase1=[None]
if methods_phase2==[]:
    methods_phase2=[None]

alg_test= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=False)
try:
    note=general_note+', '
except:
    note=''

methods_phase1_original=copy(methods_phase1)
if len(methods_phase1)>1:
    print 'Comparing different methods for Phase 1...'
    sys.stdout.flush()

    same_methods=alg_test.compareMethodsPhase1(methods_phase1,note)
    print 'Same weight coefficients sets are found by these group(s) of methods:'
    print same_methods
    note+='Same weight coefficients sets are found by these group(s) of methods:' + str(same_methods)
    methods_phase1=[]
    for group in same_methods:
        methods_phase1.append(group[0])


for method1 in methods_phase1:
    for method2 in methods_phase2:
        try:
            start=time.clock()

            try:
                verbosity
            except:
                verbosity=0

            try:
                alg= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=True, verbose=verbosity, maxInputs=maximumOfInputs)
            except:
                alg= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=True, verbose=verbosity)



            alg_update=False
            unsolved_saved=False

            filename=alg.getName()
            output_folder=folder_path+filename
            if method1!=None or method2!=None:
                output_folder+='/methods_'+str(method1)+'-'+str(method2)

            #output_folder+='/'

            if filename:
                d = os.path.dirname(output_folder+'/')
                if not os.path.exists(d):
                    os.makedirs(d)
            else:
                raise ValueErrorParAdd("Filename is missing.")

            print " "

            if images:
                if alphabet_img:
                    alg.saveImages([alg.plotAlphabet()],output_folder+'/img','alphabet')
                    alg.saveImages([alg.plot(alg._inputAlphabet, color='blue')+alg.plotAlphabet()],output_folder+'/img','inputAlphabet')

                if lattice_img:
                    alg.saveImages([alg.plotLattice()],output_folder+'/img','lattice')

            alg.addLog("Maximum iterations: " + str(max_iterations))
            alg.addLog("Maximum length of input of weight function: " + str(max_input_length))


            alg.findWeightFunction(max_iterations,max_input_length, method_weightCoefSet=method1, method_weightFunSearch=method2)


            alg_update=True

            print '\n'

            print "Saving..."
            sys.stdout.flush()

            if WFcsv:
                alg.saveWeightFunctionToCsvFile(output_folder+ '/'+filename)

            if localConversionCsv:
                alg.saveLocalConversionToCsvFile(output_folder+ '/'+filename)

            if sanityCheck:
                er=alg.sanityCheck_conversion(alg.getWeightFunction().getMaxLength()+1)
            message='successfull'

        except KeyboardInterrupt:
            print "Keyboard Interrupt:"
            if saveUnsolved:
                alg.saveUnsolvedInputsToCsv(output_folder+ '/'+filename)
                unsolved_saved=True
            message='Keyboard Interrupt'

        except ExceptionParAdd, e:
            print "Error:"
            alg.addLog(e)
            message=str(e)

  #      except Exception, e:
   #         print "Error:"
    #        alg.addLog(e)
     #       message=str(e)

        finally:
            end=time.clock()
            alg.addLog("Elapsed time: "+ str(end-start))

            try:
                message
            except:
                message='some error'

            alg.saveResults(end-start, message,note)

            if info:
                alg.saveInfoToTexFile(output_folder+ '/'+filename, header=True, shortInput=False)

            if saveLog:
                alg.saveLog(output_folder+ '/'+filename)

            if images:
                try:
                    weightCoefSet_img
                except:
                    weightCoefSet_img=False
                if alg._weightCoefSet:
                    if phase1_images:
                        imgs1=alg.plotPhase1()
                        alg.saveImages(imgs1,output_folder+'/img','phase1')

                    if weightCoefSet_img:
                        alg.saveImages([alg.plotWeightCoefSet(estimation)],output_folder+'/img','weightCoefficientsSet')

                if phase2_images and alg._weightFunction:
                    imgs2=alg.plotPhase2(sage.misc.sage_eval.sage_eval(phase2_input, locals={'omega':alg.getRingGenerator()}))
                    alg.saveImages(imgs2,output_folder+'/img','phase2')

            if saveUnsolved and not alg_update and not unsolved_saved:
                alg.saveUnsolvedInputsToCsv(output_folder+ '/'+filename)
            print '--------------------------end of '+ filename +'---------------------------------------------'

methods_phase1=copy(methods_phase1_original)