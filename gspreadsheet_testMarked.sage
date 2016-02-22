folder_path='./outputs/'
load_attach_path('./classes')


#------------EWM SETTING----------------
max_iterations = 20      #maximum of iterations in searching for the weight coefficient set
methods_phase1=[3]        #methods in the list are used. If empty, default method is used.
max_input_length = 10    #maximal length of the input of the weight function
methods_phase2=[14]        #methods in the list are used. If empty, default method is used.
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

try:
    import json
    import gspread         #https://gspread.readthedocs.org/en/latest/#gspread.Spreadsheet.add_worksheet
    import warnings
    with warnings.catch_warnings():
        warnings.simplefilter("ignore")
        from oauth2client.client import SignedJwtAssertionCredentials
        warnings.resetwarnings()
    try:
        json_key = json.load(open('vysledkyParallel-b1ae50e4c6ea.json'))
    except Exception, e:
        json_key = json.load(open('/home/legerjan/ParallelAddition/vysledkyParallel-b1ae50e4c6ea.json'))
    scope = ['https://spreadsheets.google.com/feeds']
    credentials = SignedJwtAssertionCredentials(json_key['client_email'], json_key['private_key'].encode(), scope)
    gc = gspread.authorize(credentials)
    sheet=gc.open("ParallelAddition_results")
    worksheet=sheet.worksheet('inputs')
except Exception, e:
    print "Some problem with google spreadsheet:"

for row in range(2,worksheet.row_count):
    try:
        if worksheet.cell(row, 1).value=='y':
            name = worksheet.cell(row, 2).value
            print name
            minPol =worksheet.cell(row, 6).value.replace('t','x')
            omegaCC= sage.misc.sage_eval.sage_eval(worksheet.cell(row, 5).value)
            alphabet = worksheet.cell(row, 3).value
            inputAlphabet = worksheet.cell(row, 4).value
            if inputAlphabet=='A+A':
                inputAlphabet=''
            base =worksheet.cell(row, 7).value

            load('ewm.sage')         #run extending window method
    except Exception, e:
        print e