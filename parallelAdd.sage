load_attach_path('~/classes')
load('AlgorithmForParallelAddition.sage')

alg=None
alg_update=False


#Loading
name = 'eisenstein'                    #Name of the numeration system
minPol ='x^2 + x + 1'                    #Minimal polynomial of ring generator (use variable x)
omegaCC= -1/2 + I*sqrt(3)/2         #Embedding (the closest root of minimal polynomial to this value is taken as the ring generator)
alphabet =  '[0,1, -1,omega, -omega, omega^2, -omega^2]'     #Alphabet (use \'omega\' as ring generator)
inputAlphabet = ''               #Input alphabet (if empty, A + A is used)
base = 'omega-1'                 #Base (use \'omega\' as ring generator)
setting_name = 'ctyri'                #Or you can load setting from the file (in folder /examples):

info=True     #General info to .tex file
WFcsv=True      #Weight function to .csv file
localConversionCsv=False     #Local conversion to .csv file
saveSetting=True     #Inputs setting
saveLog=True     #Log file
saveUnsolved=True     #Unsolved inputs after interruption

sanityCheck=True
len_inp =  3     #Number of digits for sanity check
saveLog=True      #Save log file after sanity check

try:
    if setting_name:
        setting = load('./examples/'+ setting_name )
        print "The following setting was loaded from ./examples/" + setting_name
        print setting

        alg= AlgorithmForParallelAddition(setting['minPol_alpGen'], setting['embedding'], setting['alphabet'], setting['base'], setting['name'], setting['inputAlphabet'],  printLog=True)
    else:
        alg= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=True)

    alg_update=False

    save(alg.getDictOfSetting(), './examples/last')

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
        er=alg.sanityCheck_conversion(len_inp)


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









