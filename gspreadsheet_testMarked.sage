folder_path='./outputs/'
load_attach_path('./classes')


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
    methods_phase1=sage.misc.sage_eval.sage_eval(worksheet.cell(1, 3).value)       #methods in the list are used. If empty, default method is used.
    methods_phase2=sage.misc.sage_eval.sage_eval(worksheet.cell(2, 3).value)        #methods in the list are used. If empty, default method is used.
except Exception, e:
    print "Some problem with google spreadsheet:"

for row in range(3,worksheet.row_count):
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