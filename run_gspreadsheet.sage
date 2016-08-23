#------------SANITY CHECK---------------
sanityCheck=False         #run sanity check

#------------SAVING---------------------
info=False                #save general info to .tex file
WFcsv=False              #save weight function to .csv file
localConversionCsv=False #save local conversion to .csv file
saveSetting=False        #save inputs setting as a dictionary
saveLog=False             #save log file

#------------IMAGES--------------------
alphabet_img=False        #save image of alphabet and input alphabet
phase1_images=False       #save step-by-step images of phase 1
weightCoefSet_img=False   #save image of the weight coefficient set
phase2_images=False       #save step-by-step images of phase 2
#for input:
phase2_input='(omega,1,omega,1,omega,1,omega,1)'

folder_path='./outputs/'
load_attach_path('./classes')

load('AlgorithmForParallelAddition.sage')
classes_loaded=True

try:
    sheet=getGoogleSpreadsheet()
    ws_name= 'inputs'
    worksheet=sheet.worksheet(ws_name)
    methods_phase1=sage.misc.sage_eval.sage_eval(worksheet.cell(1, 3).value)       #methods in the list are used. If empty, default method is used.
    methods_phase2=sage.misc.sage_eval.sage_eval(worksheet.cell(2, 3).value)        #methods in the list are used. If empty, default method is used.
except Exception, e:
    print "Some problem with google spreadsheet:"
    print e

rows_to_test=[]

first_col=worksheet.col_values(1)

for row in range(3,len(first_col)):
    if first_col[row] in compareWith:
        rows_to_test.append(row+1)

for row in rows_to_test:
    sheet=getGoogleSpreadsheet()
    worksheet=sheet.worksheet(ws_name)
    try:
        name = worksheet.cell(row, 2).value
        print name
        minPol =worksheet.cell(row, 6).value.replace('t','x')
        omegaCC= sage.misc.sage_eval.sage_eval(worksheet.cell(row, 5).value)
        alphabet = worksheet.cell(row, 3).value
        inputAlphabet = worksheet.cell(row, 4).value
        kblock = worksheet.cell(row, 8).value
        if kblock=='':
            kblock=1
        if inputAlphabet=='A+A':
            inputAlphabet=''
        base =worksheet.cell(row, 7).value
        if onlyComparePhase1:
            alg_test= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=False)
            print 'Same weight coefficients sets are found by these group(s) of methods:'
            print alg_test.compareMethodsPhase1(methods_phase1, general_note)
        else:
            load('ewm.sage')         #run extending window method

    except ExceptionParAdd, e:
        print e