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
    worksheet=sheet.worksheet('results')
except Exception, e:
    print "Some problem with google spreadsheet:"
    print e


alphabets=worksheet.col_values(3)[1:]
polynomials=worksheet.col_values(13)[1:]
lenghts=worksheet.range('E2:E2590')
m0s=worksheet.range('F2:F2590')
m1s=worksheet.range('G2:G2590')
minimals=worksheet.range('H2:H2590')

for i in range(0,len(lenghts)):
    size_A=len(sage.misc.sage_eval.sage_eval(alphabets[i].replace('omega','0')))
    m0=abs(sage.misc.sage_eval.sage_eval(polynomials[i].replace('x','0')))
    m1=abs(sage.misc.sage_eval.sage_eval(polynomials[i].replace('x','1')))
    minimal='no'
    if size_A == max(m0,m1):
        minimal='yes'
    lenghts[i].value=size_A
    m0s[i].value=m0
    m1s[i].value=m1
    minimals[i].value=minimal

worksheet.update_cells(lenghts)
worksheet.update_cells(m0s)
worksheet.update_cells(m1s)
worksheet.update_cells(minimals)

