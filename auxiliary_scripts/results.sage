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
    ws_vybrane=sheet.worksheet('vybrane')
    ws_results=sheet.worksheet('results_vybrane')
except Exception, e:
    print "Some problem with google spreadsheet:"
    print e

chosen_inputs=[]
chosen_inputs=['Eisenstein_1-block_complex', 'Penney_1-block_complex', 'Quadratic+1+0-21_integer', 'Quadratic+1+2+3_complex', 'Quadratic+1+3+5_complex1', 'Quadratic+1+0-17_integer_bigger', 'Quadratic+1+0-17_integer']

if not chosen_inputs:
    chosen_inputs=ws_vybrane.col_values(2)[1:]
    print chosen_inputs

chosen_inputs_category=[]
chosen_inputs_category=['t', 't', 't', 't', 't', 't', 't']
if not chosen_inputs_category:
    chosen_inputs_category=ws_vybrane.col_values(1)[1:]
    print chosen_inputs_category

col_titles=['Name','Ring generator','Minimal polynomial of generator omega', 'Base', 'Minimal polynomial of base','Real conjugates of base greater than 1','#A', 'Is alphabet minimal?', 'Size of weight coefficients set',  'One letter inputs (problematic letters)', 'Phase 2','Length of maximal input of weight function','Phase 2 - method No.','Numbers of saved combinations', 'Elapsed time','Sizes of intermediate weight coefficients sets','Phase 1', 'Alphabet', 'Input alphabet','Phase 1 - method No.', 'Error', 'Base (explicit)','Alphabet dividied into congruence classes mod base -1', 'Alphabet dividied into congruence classes mod base']#

col_titles_tab=['Ring generator', 'Base', 'Minimal polynomial of base','Real conjugates of base greater than 1','#A', 'Is alphabet minimal?',   'Size of weight coefficients set',  'One letter inputs (problematic letters)', 'Phase 2', 'Length of maximal input of weight function']#'Name',,,'Phase 1', 'Alphabet', 'Input alphabet','Numbers of saved combinations','Phase 1 - method No.','Phase 2 - method No.','Minimal polynomial of generator omega'

columns={}
columns={'Elapsed time': 33, 'Alphabet': 3, 'Input alphabet': 4, 'Length of maximal input of weight function': 30, 'Ring generator': 9, 'Name': 2, 'Alphabet dividied into congruence classes mod base': 17, 'Size of weight coefficients set': 24, 'Numbers of saved combinations': 31, 'Base': 11, 'Alphabet dividied into congruence classes mod base -1': 19, 'One letter inputs (problematic letters)': 27, 'Real conjugates of base greater than 1': 16, 'Minimal polynomial of generator omega': 10, 'Error': 34, 'Sizes of intermediate weight coefficients sets': 25, 'Minimal polynomial of base': 13, '#A': 5, 'Base (explicit)': 12, 'Phase 2': 29, 'Phase 1 - method No.': 22, 'Phase 1': 23, 'Phase 2 - method No.': 26, 'Is alphabet minimal?': 8}


if not columns:
    col_titles_ws=ws_results.row_values(1)
    for col_title in col_titles:
        columns[col_title]=col_titles_ws.index(col_title)+1

    print columns

col_titles_table={'Real conjugates of base greater than 1':'conj.',
                  'Name': 'Name',
                  'Phase 1': 'Phase 1',
                  '#A': '$\\#\\A$',
                  'Size of weight coefficients set': '$\\#\\Q$',
                  'Ring generator': '$\\omega$',
                  'Phase 2': 'Phase 2',
                  'Phase 1 - method No.': 'No.',
                  'Base': '$\\beta$',
                  'Length of maximal input of weight function': '$r$',
                  'Phase 2 - method No.': 'No.',
                  'Numbers of saved combinations': 'Numbers of saved combinations',
                  'Minimal polynomial of generator omega': '$m_\\omega$',
                  'Minimal polynomial of base': '$m_\\beta$',
                  'One letter inputs (problematic letters)': '$bb\\dots b$',
                  'Is alphabet minimal?': 'min.',
                  'Sizes of intermediate weight coefficients sets':'Sizes'}


data={}

data=load('cele')


if not data:
    try:
        for col_title in col_titles:
            data[col_title]=ws_results.col_values(columns[col_title])
        save(data,'cele')
    except e:
        print 'problem!!!!!!!!'
        print e
        save(data,'cele')

print data.keys()


var('omega')
var('t')

def getVal(_key,ind):
    if _key in ['Is alphabet minimal?', 'Is alphabet minimal?']:
        return data[_key][ind]
    #elif _key in ['Minimal polynomial of base','Minimal polynomial of generator omega']:
     #   return '$'+data[_key][ind]+'$'
    elif _key=='Real conjugates of base greater than 1':
        if data[_key][ind]==None:
            return '?'
        elif data[_key][ind]!='-':
            return 'yes'
        else:
            return 'no'
    elif _key in ['Phase 1', 'Phase 2']:
        if data[_key][ind]=='OK':
            return '\\checkmark'
        else:
            return '\\xmark'
    elif _key=='One letter inputs (problematic letters)':
        if data[_key][ind]=='OK':
            return '\\checkmark'
        else:
            return '\\xmark'
    elif _key=='Input alphabet' and data[_key][ind]=='A+A':
        return '$\\A+\\A$'
    elif _key in ['Length of maximal input of weight function','Phase 2 - method No.','Phase 1 - method No.']:
        return data[_key][ind]
    elif _key=='Name':
        return data[_key][ind].replace('_','\\_').replace('-','--')
    elif _key=='Elapsed time':
        return data[_key][ind]
    elif _key=='Error':
        return data[_key][ind].replace('omega','\\omega').replace('[','$(').replace(']',')$').replace('*','')
    else:
        try:
            return '$'+latex(sage.misc.sage_eval.sage_eval(data[_key][ind],locals={'omega':omega, 't':t, 'x':x}))+'$'
        except:
            return data[_key][ind]

rows=[]
category='t'
for ind,_input in enumerate(chosen_inputs_category):
    if _input==category:
        for r,_name in enumerate(data['Name']):
            if _name==chosen_inputs[ind] and data['Phase 2 - method No.'][r] in ['15','21']:
                rows.append(r)

_alphabet=['A','B','C','D','E', 'F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V', 'W', 'X','Y', 'Z']
ex_code=iter(cartesian_product([_alphabet,_alphabet]))


filename='results_'+category

def setBraces(s):
    return s.replace('[','\\{').replace(']','\\}')

shortInput=False
with open(filename+".tex", 'w') as fp:
    stdout = sys.stdout
    sys.stdout = fp

    rows_tex=[]
    for row in rows:
        code=next(ex_code)
        row_tex='\\ref{ex:'+category+code[0]+code[1]+'} & '
        row_tex=''
        for col in col_titles_tab:
            row_tex+=getVal(col,row)+' & '
        rows_tex.append(row_tex[0:-2]+'\\\\')

        print '\\begin{exmp}'
        print "\\label{ex:"+category+code[0]+code[1]+'}\n'

        print '\n\\rule{0cm}{0cm}\n'
        print '\\begin{tabular}{ll}'
        print '$\\omega=', getVal('Ring generator',row)[1:], ' & $\\beta=' +getVal('Base',row)[1:-1]+'='+getVal('Base (explicit)',row)[1:]+ '\\\\'
        print '$m_\\omega(t)=',getVal('Minimal polynomial of generator omega',row)[1:],' & '+ '$m_\\beta(x)=',getVal('Minimal polynomial of base',row)[1:]+'\\\\'
        print 'Real conjugate of $\\beta$ greater than 1: ',' & ', getVal('Real conjugates of base greater than 1',row), '\\\\ \\hline'
        print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth}\\begin{dmath*}\\A ="  + setBraces(getVal('Alphabet',row)[1:-1])+' \\end{dmath*}\\end{minipage} }\\\\'
        if data['Is alphabet minimal?'][row]=='yes':
            print '$\\#\\A=',getVal('#A',row),'$ & \\A is minimal. \\\\'
        else:
            print '$\\#\\A=',getVal('#A',row),'$ & \\A is not minimal. \\\\'
        print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth}\\begin{dmath*}\\B ="  + setBraces(getVal('Input alphabet',row)[1:-1])+' \\end{dmath*}\\end{minipage} }\\\\[10pt]'
        print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth}$\A$ divided into congruence classes modulo $\\beta$: \\begin{dmath*}"  + setBraces(getVal('Alphabet dividied into congruence classes mod base',row))[1:-1]+' \\end{dmath*}\\end{minipage} }\\\\[10pt]'
        print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth}$\A$ divided into congruence classes modulo $\\beta-1$: \\begin{dmath*}"  + setBraces(getVal('Alphabet dividied into congruence classes mod base -1',row))[1:-1]+' \\end{dmath*}\\end{minipage} }\\\\'
        print ' & \\\\ \\hline'
        print ' & \\\\'
        print 'Phase 1 (method ',str(getVal('Phase 1 - method No.',row))+'): &'
        if data['Phase 1'][row]=='OK':
            print '\\checkmark, $\\#\\mathcal{Q} =' + getVal('Size of weight coefficients set',row)+ '$ \\\\ '
            if data['One letter inputs (problematic letters)'][row]=='OK':
                print '$b,b,\\dots,b$ inputs: & \\checkmark \\\\'
                if  data['Phase 2'][row]=='OK':
                    print 'Phase 2 (method ',str(getVal('Phase 2 - method No.',row))+'): & \\checkmark , $r=', getVal('Length of maximal input of weight function',row) + '$ \\\\'
                else:
                    print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth} Phase 2 (method ",str(getVal('Phase 2 - method No.',row))+') fails because ', getVal('Error',row).replace('The', 'the') + '\\end{minipage} }\\\\'
            else:
                print 'Failing $b,b,\\dots,b$ inputs: & '+ setBraces(data['One letter inputs (problematic letters)'][row])+ '\\\\'
        else:
            print '\\xmark \\\\'
        print '\\end{tabular}\n'

        print '\\end{exmp}'
        print '\n'
        print '\n'

    print '\\begin{tabular}{l|c|c c c| c c| c| c c c }'
    title='Ex. &'
    title=''
    for col in col_titles_tab:
        title+= col_titles_table[col]+ ' & '
    print title[0:-2], ' \\\\ \\hline'
    for row in rows_tex:
        print row
    print '\\end{tabular}'

    sys.stdout = stdout
