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
    ws_vybrane=sheet.worksheet('successful')
    ws_results=sheet.worksheet('results_zpracovane')
except Exception, e:
    print "Some problem with google spreadsheet:"
    print e


chosen_inputs=ws_vybrane.col_values(2)[1:]

chosen_inputs_category=ws_vybrane.col_values(1)[1:]

category='integer'

col_titles=['Ring generator','Minimal polynomial of generator omega', 'Base', 'Minimal polynomial of base','Real conjugates of base greater than 1','#A', 'Is alphabet minimal?',   'Size of weight coefficients set',  'One letter inputs (problematic letters)', 'Phase 2', 'Length of maximal input of weight function','Phase 1', 'Alphabet', 'Input alphabet','Numbers of saved combinations','Phase 1 - method No.','Phase 2 - method No.']#'Name',,
columns={}
#columns={'Real conjugates of base greater than 1': 15, 'Phase 1': 22, '#A': 4, 'Size of weight coefficients set': 23, 'Minimal polynomial of generator omega': 9, 'Phase 2': 28, 'Base': 10, 'Length of maximal input of weight function': 29, 'Ring generator': 8, 'Minimal polynomial of base': 12, 'One letter inputs (problematic letters)': 26, 'Is alphabet minimal?': 7}

if not columns:
    col_titles_ws=ws_results.row_values(1)
    print col_titles_ws
    for col_title in col_titles:
        columns[col_title]=col_titles_ws.index(col_title)


print columns

def setLatexBraces(_list):
    return _list.replace('\left[','\{').replace('right]','}')

rows=[ws_results.row_values(1)]
ind=0
for _input in chosen_inputs_category:
    if _input==category:
        rows.append(ws_results.row_values(ws_results.find(chosen_inputs[ind]).row))
    ind+=1

print rows

col_titles_table={'Real conjugates of base greater than 1':'conj.',
                  'Name': 'Name',
                  'Phase 1': 'Phase 1',
                  '#A': '$\\#\\A$',
                  'Size of weight coefficients set': '$\\#\\Q$',
                  'Ring generator': '$\\omega$',
                  'Phase 2': 'Phase 2',
                  'Phase 1 - method No.': 'No.',
                  'Base': '$\\beta$',
                  'Length of maximal input of weight function': '$m$',
                  'Phase 2 - method No.': 'No.',
                  'Numbers of saved combinations': 'Numbers of saved combinations',
                  'Minimal polynomial of generator omega': '$m_\\omega$',
                  'Minimal polynomial of base': '$m_\\beta$',
                  'One letter inputs (problematic letters)': '$bb\\dots b$',
                  'Is alphabet minimal?': 'min.'}


def getVal(_key,row):
    if _key in ['Is alphabet minimal?', 'Is alphabet minimal?']:
        return row[columns[_key]]
    elif _key in ['Minimal polynomial of base','Minimal polynomial of generator omega']:
        return '$'+row[columns[_key]]+'$'
    elif _key=='Real conjugates of base greater than 1':
        if row[columns[_key]]:
            return 'yes'
        else:
            return 'no'
    elif _key in ['Phase 1', 'Phase 2']:
        if row[columns[_key]]=='OK':
            return '\\checkmark'
        else:
            return '\\xmark'
    elif _key=='One letter inputs (problematic letters)':
        if row[columns[_key]]=='OK':
            return '\\checkmark'
        else:
            return '\\xmark'
    elif _key=='Input alphabet' and row[columns[_key]]=='A+A':
        return '$\\A+\\A$'
    elif _key=='Length of maximal input of weight function':
        return row[columns[_key]]
    else:
        return ('$'+latex(sage.misc.sage_eval.sage_eval(row[columns[_key]], locals={'omega':omega}))+'$').replace('omega','\\omega')

_alphabet=['A','B','C','D','E', 'F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V', 'W', 'X','Y', 'Z']
ex_code=iter(cartesian_product([_alphabet,_alphabet]))


filename='result_'+category

shortInput=False
with open(filename+".txt", 'w') as fp:
    stdout = sys.stdout
    sys.stdout = fp

    rows_tex=[]
    for row in rows[1:]:
        minPol=sage.misc.sage_eval.sage_eval(row[9],locals={'t':x}, cmds='P.<x>=ZZ[]')
            #evaluation of minimal polynomial
        N.<ratRingGenator> = NumberField(minPol, embedding=sage.misc.sage_eval.sage_eval(row[8]))
            # Rational Polynomials with variable ratRingGenerator mod minPol, beta is the closest root of minPol to embd
        IntegerPolynomials.<t> = PolynomialRing(ZZ)
            #Integer polynomials with variable t
        Zomega.<omega> = PolynomialQuotientRing(IntegerPolynomials,IntegerPolynomials(N.polynomial()) )
        code=next(ex_code)
        row_tex='\\ref{ex:'+category+code[0]+code[1]+'} & '
        for col in col_titles[0:-6]:
            row_tex+=str(getVal(col,row))+' & '
        rows_tex.append(row_tex[0:-2]+'\\\\')


        print '\\begin{exmp}'
        print "\\label{ex:"+category+code[0]+code[1]+'}\n'
        if not shortInput:
            print 'Parameters:'
            print '\\begin{itemize}'
            print "    \item Minimal polynomial of $\\omega$: "+ getVal('Minimal polynomial of generator omega',row)
            print "    \item Base $\\beta=" +getVal('Base',row)[1:]
            print "    \item Minimal polynomial of base: " + getVal('Minimal polynomial of base',row)
            print "    \item Alphabet $\\mathcal{A} ="  + setLatexBraces(getVal('Alphabet',row))[1:]
            print "    \item Input alphabet $\\mathcal{B} =" + setLatexBraces(getVal('Input alphabet',row))[1:]
            print '\\end{itemize}\n'
        else:
            print "    \item Alphabet $\\mathcal{A} ="  + setLatexBraces(getVal('Alphabet',row))[1:]
            print "    \item Input alphabet $\\mathcal{B} =" + setLatexBraces(getVal('Input alphabet',row))[1:]

        print 'The result of the extending window method is:'
        print '\\begin{enumerate}'
        if row[columns['Phase 1']]=='OK':
            print '    \item Phase 1 was successful.'
            print "The number of elements in the weight coefficient set $\\mathcal{Q}$ is " + getVal('Size of weight coefficients set',row)+ '.\n'
            if row[columns['One letter inputs (problematic letters)']]=='OK':
                print '    \item There is a unique weight coefficient for input $b,b,\\dots,b$ for all $b\\in\\mathcal{B}$.\n'
                if  row[columns['Phase 2']]=='OK':
                    print '    \item Phase 2 was successful.'
                    print 'The length of window $m$ of the weight function $q$ is ', getVal('Length of maximal input of weight function',row) + '.'
                else:
                    print '    \item Phase 2 was not successful.\n'
            else:
                print '    \item There is a not unique weight coefficient for input $b,b,\\dots,b$ for $b\in'+ setLatexBraces(row[columns['One letter inputs (problematic letters)']])[1:]+ ' for some fixed length of window. Thus Phase 2 does not converge.\n'
        else:
            print '    \item Phase 1 was not successful. \n'
        print '\\end{enumerate}'
        print '\\end{exmp}'



    print '\\begin{tabular}{l|c cc| c c c c c c c c c c c c}'
    title='Ex. &'
    for col in col_titles[0:-6]:
        title+= col_titles_table[col]+ ' & '
    print title[0:-2], ' \\\\ \\hline'
    for row in rows_tex:
        print row
    print '\\end{tabular}'

    sys.stdout = stdout

