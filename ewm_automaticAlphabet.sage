
#------------EWM SETTING----------------
max_iterations = 20      #maximum of iterations in searching for the weight coefficient set
methods_phase1=[3]        #methods in the list are used. If empty, default method is used.
max_input_length = 10    #maximal length of the input of the weight function
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

#-----------------------------------------------------------------------
max_coef=5
m=2
t=[]
P.<x> = ZZ[]
for i in range(0,2):
    t.append(range(-max_coef,max_coef+1))

iterat=cartesian_product_iterator(t)
for x in iterat:
    if x[0]==3 and x[1]==4:
        break

for x in iterat:
    if abs(x[0])<=m and abs(x[1])<=m:
        pass
    else:
        p= str(P(list(x)+[1]))
        print p
        try:
            name = 'Quadratic_'+str(p)+'_automaticAlphabet'
            minPol =p
            omegaCC= 1+ 1*I
            alphabet = ''
            inputAlphabet = ''
            base ='omega'

            load('ewm.sage')
        except ExceptionParAdd, e:
            print e









