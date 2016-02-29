
#------------EWM SETTING----------------
max_iterations = 20      #maximum of iterations in searching for the weight coefficient set
methods_phase1=[3]        #methods in the list are used. If empty, default method is used.
max_input_length = 100    #maximal length of the input of the weight function
methods_phase2=[15]        #methods in the list are used. If empty, default method is used.
#Cartesian product of lists methods_phase1 and methods_phase2 is computed

#------------SANITY CHECK---------------
sanityCheck=False         #run sanity check

#------------SAVING---------------------
info=True                #save general info to .tex file
WFcsv=False              #save weight function to .csv file
localConversionCsv=False #save local conversion to .csv file
saveSetting=False        #save inputs setting as a dictionary
saveLog=True             #save log file
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

folder_path='./'
#-----------------------------------------------------------------------
max_coef=3
m=0
t=[]
P.<x> = ZZ[]
for i in range(0,2):
    t.append(range(-max_coef,max_coef+1))

skip=False#True
for x in cartesian_product_iterator(t):
    if abs(x[0])<=m and abs(x[1])<=m:
        pass
    elif skip:
        pass
    else:
        p= str(P(list(x)+[1]))
        print p
        name = 'Quadratic_gen_'+str(p)+'_automaticIntegerAlphabet_'
        minPol =p
        omegaCC= 1+ 1*I
        alphabet = 'integer'
        inputAlphabet = ''

        max_coef_base=3
        u=[]
        for i in range(0,2):
            u.append(range(-max_coef_base,max_coef_base+1))
        for y in cartesian_product_iterator(u):
            base =str(y[0])+'*omega'+'+('+str(y[1])+')'
            name = 'Quadratic_gen_'+str(p)+'_automaticIntegerAlphabet_'+base
            try:
                load('ewm.sage')
            except ExceptionParAdd, e:
                print e
    if x[0]==4 and x[1]==1:
        skip=False









