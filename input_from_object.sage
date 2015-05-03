load_attach_path('~/classes')
load('AlgorithmForParallelAddition.sage')


import sys

setting = load(sys.argv[1] )
print "The following setting was loaded from " + sys.argv[1]
print setting

alg= AlgorithmForParallelAddition(setting['minPol_alpGen'], setting['embedding'], setting['alphabet'], setting['base'], setting['name'], setting['inputAlphabet'],  printLog=True, printLogLatex=False)

alg.inputSettingToSageFile('./inputs/new/' + alg.getName())