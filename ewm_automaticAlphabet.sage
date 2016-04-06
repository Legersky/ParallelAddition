#-----------Methods Phase 1---------------------------------------
# 1 - chooses the smallest element (the embedding to CC is necessary here)
# 2 - takes first the only possible candidates and then chooses the smallest element (in absolute value, the embedding to CC is necessary here) - dependent on order of digits in alphabet!!!
# 3 - takes first the only possible candidates and then chooses the smallest element in the natural norm  - dependent on order of digits in alphabet!!!
# 4 - weight coefficients set given by bound (norm)
# 5 - weight coefficients set given by bound (abs)
# 6 - takes first the only possible candidates and all in non-covered lists
# 7 == 9, but A+A is taken even if the input alphabet is different
# 8 -  takes first the only possible candidates and then add all smallest elements (absolute value)
# 9 - takes first the only possible candidates and then add all smallest elements (natural norm) (default)

#-----------Methods Phase 2---------------------------------------
# 0 - add the first element in the first shortest list (implementation dependent)
# 1 - find the smallest covering coefficients from the shortest lists (really slow !!!)
# 2 - random from the shortest lists
# 3 - pick element from the shortest lists lexicographically according to coordinates in lattice
# 4 - pick element from the shortest list which is the closest (according to lattice) to rounded center of gravity of points in shortest lists (default)
# 5 - pick element from all resting list which is the closest (according to lattice) to rounded center of gravity of points in all resting lists
# 6 - find the smallest covering coefficients from all resting lists (really slow !!!)
# 7 - pick element from the shortest list which is the closest (in absolute value) to rounded center of gravity of points in shortest lists
# 8 - pick element from the shortest list which is the closest (in absolute value) to center of gravity of points in shortest lists
# 9 - pick element from all resting list which is the closest (in absolute value) to center of gravity of points in all resting lists
# 10 - each value covered separately by the point closest to point of gravity of covering values
# 11 - pick element from the shortest lists which is the smallest (in absolute value)
# 12 - pick element from the shortest lists which is the smallest (beta-norm)
# 13 - pick element from those with highest occurrencies, which is the closest to 0 in beta-norm
# 14 - pick element from those with highest occurrencies, which is the closest to the center of gravity of already added (in absolute value)
# 15 - pick element from the shortest lists which is closest to already added (absolute value)
# 16 - pick element from those with highest occurrencies, which is the closest to center of gravity of already added (in beta norm)
# 17 - pick element from all resting which is the closest (in beta norm) to the center of gravity of already
# 18 - pick element according to covering by alphabets
# 19 - pick more elements according to covering by alphabets
# 20 - another way to pick an element according to covering by alphabets

#------------EWM SETTING----------------
max_iterations = 20      #maximum of iterations in searching for the weight coefficient set
methods_phase1=[9]        #methods in the list are used. If empty, default method is used.
max_input_length = 100    #maximal length of the input of the weight function
methods_phase2=[21]        #methods in the list are used. If empty, default method is used.
#Cartesian product of lists methods_phase1 and methods_phase2 is computed

#------------SANITY CHECK---------------
sanityCheck=False         #run sanity check

#------------SAVING---------------------
info=False                #save general info to .tex file
WFcsv=False              #save weight function to .csv file
localConversionCsv=False #save local conversion to .csv file
saveSetting=False        #save inputs setting as a dictionary
saveLog=False             #save log file
saveUnsolved=False       #save unsolved combinations after interruption

#------------IMAGES--------------------
alphabet_img=False        #save image of alphabet and input alphabet
lattice_img=False         #save image of lattice with shifted alphabet
phase1_images=False       #save step-by-step images of phase 1
weightCoefSet_img=False   #save image of the weight coefficient set
#with estimation given by lemma:
estimation=False
phase2_images=False       #save step-by-step images of phase 2
#for input:
phase2_input='(omega,1,omega,1,omega,1,omega,1)'


folder_path='./outputs/'
load_attach_path('./classes')

load_attach_path('~')

load_attach_path('/home/legerjan/ParallelAddition')
load_attach_path('/home/legerjan/ParallelAddition/classes')

load('AlgorithmForParallelAddition.sage')
classes_loaded=True

folder_path='./'
#-----------------------------------------------------------------------
general_note='#A>|m(0)|'

max_coef=3
m=0
t=[]
P.<x> = ZZ[]
for i in range(0,2):
    t.append(range(-max_coef,max_coef+1))

skip=False#True
for x in cartesian_product_iterator(t):
    b=x[1]
    c=x[0]
    if c==1 and b==0:
        skip=False
    if abs(b)<=m and abs(c)<=m:
        pass
    elif skip:
        pass
    else:
        p= str(P([c,b,1]))
        print p
        name_gen = 'Quadratic_gen_'+str(p)+'_automaticAlphabet>m(0)_'
        minPol =p
        omegaCC= 1+ 1*I
        alphabet = 'oneMore'
        inputAlphabet = ''

        max_coef_base=3
        u=[]
        for i in range(0,2):
            u.append(range(-max_coef_base,max_coef_base+1))
        for y in cartesian_product_iterator(u):
            if y[0]:
                base =str(y[0])+'*omega'+'+('+str(y[1])+')'
                name = name_gen+base
                maximumOfInputs=1000000
                try:
                    load('ewm.sage')
                except ExceptionParAdd, e:
                    print e










