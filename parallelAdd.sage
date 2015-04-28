load_attach_path('./classes')
load('AlgorithmForParallelAddition.sage')


import sys

alg=None
alg_update=False

load(sys.argv[1])

try:
    if setting_name:
        setting = load('./examples/'+ setting_name )
        print "The following setting was loaded from ./examples/" + setting_name
        print setting

        alg= AlgorithmForParallelAddition(setting['minPol_alpGen'], setting['embedding'], setting['alphabet'], setting['base'], setting['name'], setting['inputAlphabet'],  printLog=True)
    else:
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

    if sanityCheck:
        er=alg.sanityCheck_conversion(alg.getWeightFunction().getMaxLength()+1)


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
    print '--------------------------end of '+ filename +'---------------------------------------------'








