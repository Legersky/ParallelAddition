︠5ce8151c-d904-4ab7-b637-8806b9058175s︠
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
    ws_results=sheet.worksheet('prezentace')
except Exception, e:
    print "Some problem with google spreadsheet:"
    print e


chosen_inputs=ws_vybrane.col_values(2)[1:]
chosen_inputs_category=ws_vybrane.col_values(1)[1:]
category='integer'

col_titles=['Ring generator','Minimal polynomial of generator omega', 'Base', 'Minimal polynomial of base','Real conjugates of base greater than 1','#A', 'Is alphabet minimal?',   'Size of weight coefficients set',  'One letter inputs (problematic letters)', 'Phase 2', 'Length of maximal input of weight function']#'Name',,'Numbers of saved combinations''Phase 1 - method No.','Phase 2 - method No.', 'Phase 1',
columns={}
col_titles_ws=ws_results.row_values(1)
for col_title in col_titles:
    columns[col_title]=col_titles_ws.index(col_title)

print columns

columns['Alphabet']=2
columns['inputAlphabet']=3

def setLatexBraces(_list):
    return _list.replace('\left[','\{').replace('right]','}')

rows=[ws_results.row_values(1)]
ind=0
for _input in chosen_inputs:
    if chosen_inputs_category[ind]==category:
        rows.append(ws_results.row_values(ws_results.find(_input).row))
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
    elif _key=='inputAlphabet' and row[columns[_key]]=='A+A':
        return '$\\A+\\A$'
    else:
        return ('$'+latex(sage.misc.sage_eval.sage_eval(row[columns[_key]], locals={'omega':omega}))+'$').replace('omega','\\omega')


_alphabet=['A','B','C','D','E', 'F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V', 'W', 'X','Y', 'Z']
ex_code=iter(cartesian_product([_alphabet,_alphabet]))





shortInput=False

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
    row_tex='\\ref{ex:'+code[0]+code[1]+'} & '
    for col in col_titles:
        row_tex+=str(getVal(col,row))+' & '
    rows_tex.append(row_tex[0:-2]+'\\\\')


    print '\\begin{exmp}'
    print "\\label{ex:"+code[0]+code[1]+'}\n'
    if not shortInput:
        print 'Parameters:'
        print '\\begin{itemize}'
        print "    \item Minimal polynomial of $\\omega$: "+ getVal('Minimal polynomial of generator omega',row)
        print "    \item Base $\\beta=" +getVal('Base',row)[1:]
        print "    \item Minimal polynomial of base: " + getVal('Minimal polynomial of base',row)
        print "    \item Alphabet $\\mathcal{A} ="  + setLatexBraces(getVal('Alphabet',row))[1:]
        print "    \item Input alphabet $\\mathcal{B} =" + setLatexBraces(getVal('inputAlphabet',row))[1:]
        print '\\end{itemize}\n'
    else:
        print "    \item Alphabet $\\mathcal{A} ="  + setLatexBraces(getVal('Alphabet',row))[1:]
        print "    \item Input alphabet $\\mathcal{B} =" + setLatexBraces(getVal('inputAlphabet',row))[1:]

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
for col in col_titles:
    title+= col_titles_table[col]+ ' & '
print title[0:-2], ' \\\\ \\hline'
for row in rows_tex:
    print row
print '\\end{tabular}'
#lenghts=worksheet.range('E2:E2590')

#for i in range(0,len(lenghts)):
    #size_A=len(sage.misc.sage_eval.sage_eval(alphabets[i].replace('omega','0')))
    #lenghts[i].value=size_A

#worksheet.update_cells(lenghts)
︡58715da5-f486-48b2-ba1c-81972148b810︡︡{"stdout":"{'Real conjugates of base greater than 1': 15, 'Size of weight coefficients set': 23, '#A': 4, 'Minimal polynomial of generator omega': 9, 'Phase 2': 28, 'Base': 10, 'Length of maximal input of weight function': 29, 'Ring generator': 8, 'Minimal polynomial of base': 12, 'One letter inputs (problematic letters)': 26, 'Is alphabet minimal?': 7}\n"}︡{"stderr":"Error in lines 37-40\n"}︡{"stderr":"Traceback (most recent call last):\n  File \"/projects/sage/sage-6.10/local/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 904, in execute\n    exec compile(block+'\\n', '', 'single') in namespace, locals\n  File \"\", line 2, in <module>\nIndexError: list index out of range\n"}︡{"done":true}
︠073869ef-a391-401c-b71c-3156bf08a146︠






#columns={'Real conjugates of base greater than 1': 15, 'Name': 1, 'Phase 1': 22, '#A': 4, 'Size of weight coefficients set': 23, 'Ring generator': 8, 'Phase 2': 28, 'Phase 1 - method No.': 21, 'Base': 10, 'Length of maximal input of weight function': 29, 'Phase 2 - method No.': 25, 'Numbers of saved combinations': 30, 'Minimal polynomial of generator omega': 9, 'Minimal polynomial of base': 12, 'One letter inputs (problematic letters)': 26, 'Is alphabet minimal?': 7}

#len(columns)

rows=[[None, 'Name', 'Alphabet', 'Input alphabet', '#A', 'm(0)', 'm(1)', 'Is alphabet minimal?', 'Ring generator', 'Minimal polynomial of generator omega', 'Base', 'Base (explicit)', 'Minimal polynomial of base', 'Conjugates of base', 'Absolute values', 'Real conjugates of base greater than 1', 'Alphabet dividied into congruence classes mod base', 'Missing representatives mod base', 'Alphabet dividied into congruence classes mod base -1', 'Missing representatives mod base -1', 'Base is expanding', 'Phase 1 - method No.', 'Phase 1', 'Size of weight coefficients set', 'Sizes of intermediate weight coefficients sets', 'Phase 2 - method No.', 'One letter inputs (problematic letters)', 'Maximal length of one letter inputs', 'Phase 2', 'Length of maximal input of weight function', 'Numbers of saved combinations', 'Not used elements of weight coefficient set', 'Elapsed time', 'Error', 'Note', 'Computer', 'saved to inputs'], ['23.2.2016 13:24:00', 'Quadratic_x^2 + x + 2_automaticAlphabet', '[0, omega + 1, 1, -1]', 'A+A', '4', '2', '4', 'yes', '1/2*I*sqrt(7) - 1/2', 't^2 + t + 2', 'omega', '1/2*I*sqrt(7) - 1/2', 'x^2 + x + 2', '[-1/2*I*sqrt(7) - 1/2, 1/2*I*sqrt(7) - 1/2]', '[sqrt(2), sqrt(2)]', None, '[[0], [omega + 1, 1, -1]]', '[]', '[[0], [omega + 1], [1], [-1]]', '[]', 'yes', '3', 'OK', '29', '[1, 6, 9, 13, 18, 22, 26, 27, 28, 29]', '15', 'OK', '6', 'OK', '8', '[0, 0, 0, 0, 43431, 126069, 126882, 31995]', '[]', '1198.863144', 'successfull', None, None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base'], ['23.2.2016 15:21:00', 'Quadratic_x^2 + x + 2_automaticAlphabet', '[0, omega + 1, 1, -1]', 'A+A', '4', '2', '4', 'yes', '1/2*I*sqrt(7) - 1/2', 't^2 + t + 2', 'omega', '1/2*I*sqrt(7) - 1/2', 'x^2 + x + 2', '[-1/2*I*sqrt(7) - 1/2, 1/2*I*sqrt(7) - 1/2]', '[sqrt(2), sqrt(2)]', None, '[[0], [omega + 1, 1, -1]]', '[]', '[[0], [omega + 1], [1], [-1]]', '[]', 'yes', '3', 'OK', '29', '[1, 6, 9, 13, 18, 22, 26, 27, 28, 29]', '15', 'OK', '6', 'OK', '8', '[0, 0, 0, 0, 43431, 126069, 126882, 31995]', '[]', '953.222523', 'successfull', None, None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base'], ['23.2.2016 13:03:00', 'Quadratic_x^2 + 2_automaticAlphabet', '[0, omega + 1, -omega - 1]', 'A+A', '3', '2', '3', 'yes', 'I*sqrt(2)', 't^2 + 2', 'omega', 'I*sqrt(2)', 'x^2 + 2', '[-I*sqrt(2), I*sqrt(2)]', '[sqrt(2), sqrt(2)]', None, '[[0], [omega + 1, -omega - 1]]', '[]', '[[0], [omega + 1], [-omega - 1]]', '[]', 'yes', '3', 'OK', '9', '[1, 3, 9]', '15', 'OK', '4', 'OK', '4', '[0, 9, 30, 250]', '[]', '1.190007', 'successfull', None, None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base'], ['23.2.2016 14:20:00', 'x^2 + 2', '[0, 1, -1]', 'A+A', '3', '2', '3', 'yes', 'I*sqrt(2)', 't^2 + 2', 'omega', 'I*sqrt(2)', 'x^2 + 2', '[-I*sqrt(2), I*sqrt(2)]', '[sqrt(2), sqrt(2)]', None, '[[0], [1, -1]]', '[]', '[[0], [1], [-1]]', '[]', 'yes', '1', 'OK', '9', '[1, 3, 9]', '4', 'OK', '4', 'OK', '4', '[0, 9, 30, 250]', '[]', '1.186854', 'successfull', 'Same weight coefficients sets are found by these group(s) of methods:[[1], [4]]', None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base']]#, ['23.2.2016 14:20:00', 'x^2 + 2', '[0, 1, -1]', 'A+A', '3', '2', '3', 'yes', 'I*sqrt(2)', 't^2 + 2', 'omega', 'I*sqrt(2)', 'x^2 + 2', '[-I*sqrt(2), I*sqrt(2)]', '[sqrt(2), sqrt(2)]', None, '[[0], [1, -1]]', '[]', '[[0], [1], [-1]]', '[]', 'yes', '1', 'OK', '9', '[1, 3, 9]', '4', 'OK', '4', 'OK', '4', '[0, 9, 30, 250]', '[]', '1.186854', 'successfull', 'Same weight coefficients sets are found by these group(s) of methods:[[1], [4]]', None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base'], ['23.2.2016 14:50:00', 'Quadratic_x^2 + 2_automaticAlphabet', '[0, omega + 1, -omega - 1]', 'A+A', '3', '2', '3', 'yes', 'I*sqrt(2)', 't^2 + 2', 'omega', 'I*sqrt(2)', 'x^2 + 2', '[-I*sqrt(2), I*sqrt(2)]', '[sqrt(2), sqrt(2)]', None, '[[0], [omega + 1, -omega - 1]]', '[]', '[[0], [omega + 1], [-omega - 1]]', '[]', 'yes', '3', 'OK', '9', '[1, 3, 9]', '15', 'OK', '4', 'OK', '4', '[0, 9, 30, 250]', '[]', '1.133134', 'successfull', None, None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base'], ['23.2.2016 18:17:00', 'x^2 + 2', '[0, 1, -1]', 'A+A', '3', '2', '3', 'yes', 'I*sqrt(2)', 't^2 + 2', 'omega', 'I*sqrt(2)', 'x^2 + 2', '[-I*sqrt(2), I*sqrt(2)]', '[sqrt(2), sqrt(2)]', None, '[[0], [1, -1]]', '[]', '[[0], [1], [-1]]', '[]', 'yes', '4', 'OK', '173', '[173]', '14', 'OK', '8', 'OK', '9', '[0, 0, 0, 0, 0, 409, 11580, 304300, 91000]', '[3, 4, 5, 6, 7, omega - 7, omega - 6, omega - 5, omega - 4, omega - 3, omega + 3, omega + 4, 5*omega - 7, 5*omega - 6, 5*omega - 5, 5*omega - 4, 5*omega - 3, 5*omega - 1, 5*omega, 5*omega + 1, 5*omega + 2, 5*omega + 3, -3*omega - 5, -3*omega - 4, -3*omega - 3, -3*omega - 2, -3*omega, -3*omega + 1, -3*omega + 2, -3*omega + 3, -3*omega + 4, -3*omega + 5, -3*omega + 6, -3*omega + 7, -6*omega - 2, -4*omega - 1, -7*omega, -7*omega + 1, -7*omega + 2, -7*omega + 3, -7*omega + 4, -7*omega + 5, 4*omega - 7, 4*omega - 6, 4*omega - 5, 4*omega - 4, 4*omega - 3, 4*omega - 2, 4*omega, 4*omega + 1, 4*omega + 2, 4*omega + 3, 4*omega + 4, 7*omega - 5, 7*omega - 4, 7*omega - 3, 7*omega - 1, 7*omega, -2*omega - 6, -2*omega - 5, -omega - 4, -2*omega - 3, -2*omega + 3, -2*omega + 4, -omega + 5, -2*omega + 6, -2*omega + 7, omega + 6, 6*omega - 1, 3*omega - 1, -6*omega - 1, 5*omega - 2, -6*omega, -6*omega + 1, -6*omega + 2, -6*omega + 3, -6*omega + 4, -6*omega + 5, -6*omega + 6, -5*omega - 1, 3*omega - 7, 3*omega - 6, 3*omega - 5, 3*omega - 4, 3*omega - 3, 3*omega - 2, 3*omega, 3*omega + 1, 3*omega + 2, 3*omega + 3, 3*omega + 4, 3*omega + 5, 7*omega - 2, -5*omega - 3, -5*omega - 2, -5*omega, -5*omega + 1, -5*omega + 2, -5*omega + 3, -5*omega + 4, -5*omega + 5, omega + 5, -5*omega + 7, -omega - 6, -omega - 5, 6*omega - 6, 6*omega - 5, 6*omega - 4, -2*omega - 4, 6*omega - 2, 6*omega, 6*omega + 1, 6*omega + 2, -omega - 3, 2*omega - 7, 2*omega - 6, 2*omega - 5, 2*omega - 4, 2*omega - 3, -omega + 3, 2*omega + 4, 2*omega + 5, 2*omega + 6, -3*omega - 1, -omega + 4, 2*omega + 3, -2*omega + 5, -omega + 6, -omega + 7, 6*omega - 3, -4*omega - 4, -4*omega - 3, -4*omega - 2, -4*omega, -4*omega + 1, -4*omega + 2, -4*omega + 3, -4*omega + 4, -4*omega + 5, -4*omega + 6, -4*omega + 7, 4*omega - 1, -5*omega + 6, -7, -6, -5, -4, -3]', '1391.840259', 'successfull', 'Same weight coefficients sets are found by these group(s) of methods:[[1], [4]]', None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base'], ['23.2.2016 18:17:00', 'x^2 + 2', '[0, 1, -1]', 'A+A', '3', '2', '3', 'yes', 'I*sqrt(2)', 't^2 + 2', 'omega', 'I*sqrt(2)', 'x^2 + 2', '[-I*sqrt(2), I*sqrt(2)]', '[sqrt(2), sqrt(2)]', None, '[[0], [1, -1]]', '[]', '[[0], [1], [-1]]', '[]', 'yes', '4', 'OK', '173', '[173]', '14', 'OK', '8', 'OK', '9', '[0, 0, 0, 0, 0, 409, 11580, 304300, 91000]', '[3, 4, 5, 6, 7, omega - 7, omega - 6, omega - 5, omega - 4, omega - 3, omega + 3, omega + 4, 5*omega - 7, 5*omega - 6, 5*omega - 5, 5*omega - 4, 5*omega - 3, 5*omega - 1, 5*omega, 5*omega + 1, 5*omega + 2, 5*omega + 3, -3*omega - 5, -3*omega - 4, -3*omega - 3, -3*omega - 2, -3*omega, -3*omega + 1, -3*omega + 2, -3*omega + 3, -3*omega + 4, -3*omega + 5, -3*omega + 6, -3*omega + 7, -6*omega - 2, -4*omega - 1, -7*omega, -7*omega + 1, -7*omega + 2, -7*omega + 3, -7*omega + 4, -7*omega + 5, 4*omega - 7, 4*omega - 6, 4*omega - 5, 4*omega - 4, 4*omega - 3, 4*omega - 2, 4*omega, 4*omega + 1, 4*omega + 2, 4*omega + 3, 4*omega + 4, 7*omega - 5, 7*omega - 4, 7*omega - 3, 7*omega - 1, 7*omega, -2*omega - 6, -2*omega - 5, -omega - 4, -2*omega - 3, -2*omega + 3, -2*omega + 4, -omega + 5, -2*omega + 6, -2*omega + 7, omega + 6, 6*omega - 1, 3*omega - 1, -6*omega - 1, 5*omega - 2, -6*omega, -6*omega + 1, -6*omega + 2, -6*omega + 3, -6*omega + 4, -6*omega + 5, -6*omega + 6, -5*omega - 1, 3*omega - 7, 3*omega - 6, 3*omega - 5, 3*omega - 4, 3*omega - 3, 3*omega - 2, 3*omega, 3*omega + 1, 3*omega + 2, 3*omega + 3, 3*omega + 4, 3*omega + 5, 7*omega - 2, -5*omega - 3, -5*omega - 2, -5*omega, -5*omega + 1, -5*omega + 2, -5*omega + 3, -5*omega + 4, -5*omega + 5, omega + 5, -5*omega + 7, -omega - 6, -omega - 5, 6*omega - 6, 6*omega - 5, 6*omega - 4, -2*omega - 4, 6*omega - 2, 6*omega, 6*omega + 1, 6*omega + 2, -omega - 3, 2*omega - 7, 2*omega - 6, 2*omega - 5, 2*omega - 4, 2*omega - 3, -omega + 3, 2*omega + 4, 2*omega + 5, 2*omega + 6, -3*omega - 1, -omega + 4, 2*omega + 3, -2*omega + 5, -omega + 6, -omega + 7, 6*omega - 3, -4*omega - 4, -4*omega - 3, -4*omega - 2, -4*omega, -4*omega + 1, -4*omega + 2, -4*omega + 3, -4*omega + 4, -4*omega + 5, -4*omega + 6, -4*omega + 7, 4*omega - 1, -5*omega + 6, -7, -6, -5, -4, -3]', '1391.840259', 'successfull', 'Same weight coefficients sets are found by these group(s) of methods:[[1], [4]]', None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base'], ['23.2.2016 20:04:00', 'x^2 + 2', '[0, 1, -1]', 'A+A', '3', '2', '3', 'yes', 'I*sqrt(2)', 't^2 + 2', 'omega', 'I*sqrt(2)', 'x^2 + 2', '[-I*sqrt(2), I*sqrt(2)]', '[sqrt(2), sqrt(2)]', None, '[[0], [1, -1]]', '[]', '[[0], [1], [-1]]', '[]', 'yes', '4', 'OK', '173', '[173]', '15', 'OK', '8', 'OK', '9', '[0, 0, 0, 0, 0, 409, 11580, 304300, 91000]', '[3, 4, 5, 6, 7, omega - 7, omega - 6, omega - 5, omega - 4, omega - 3, omega + 3, omega + 4, 5*omega - 7, 5*omega - 6, 5*omega - 5, 5*omega - 4, 5*omega - 3, 5*omega - 1, 5*omega, 5*omega + 1, 5*omega + 2, 5*omega + 3, -3*omega - 5, -3*omega - 4, -3*omega - 3, -3*omega - 2, -3*omega, -3*omega + 1, -3*omega + 2, -3*omega + 3, -3*omega + 4, -3*omega + 5, -3*omega + 6, -3*omega + 7, -6*omega - 2, -4*omega - 1, -7*omega, -7*omega + 1, -7*omega + 2, -7*omega + 3, -7*omega + 4, -7*omega + 5, 4*omega - 7, 4*omega - 6, 4*omega - 5, 4*omega - 4, 4*omega - 3, 4*omega - 2, 4*omega, 4*omega + 1, 4*omega + 2, 4*omega + 3, 4*omega + 4, 7*omega - 5, 7*omega - 4, 7*omega - 3, 7*omega - 1, 7*omega, -2*omega - 6, -2*omega - 5, -omega - 4, -2*omega - 3, -2*omega + 3, -2*omega + 4, -omega + 5, -2*omega + 6, -2*omega + 7, omega + 6, 6*omega - 1, 3*omega - 1, -6*omega - 1, 5*omega - 2, -6*omega, -6*omega + 1, -6*omega + 2, -6*omega + 3, -6*omega + 4, -6*omega + 5, -6*omega + 6, -5*omega - 1, 3*omega - 7, 3*omega - 6, 3*omega - 5, 3*omega - 4, 3*omega - 3, 3*omega - 2, 3*omega, 3*omega + 1, 3*omega + 2, 3*omega + 3, 3*omega + 4, 3*omega + 5, 7*omega - 2, -5*omega - 3, -5*omega - 2, -5*omega, -5*omega + 1, -5*omega + 2, -5*omega + 3, -5*omega + 4, -5*omega + 5, omega + 5, -5*omega + 7, -omega - 6, -omega - 5, 6*omega - 6, 6*omega - 5, 6*omega - 4, -2*omega - 4, 6*omega - 2, 6*omega, 6*omega + 1, 6*omega + 2, -omega - 3, 2*omega - 7, 2*omega - 6, 2*omega - 5, 2*omega - 4, 2*omega - 3, -omega + 3, 2*omega + 4, 2*omega + 5, 2*omega + 6, -3*omega - 1, -omega + 4, 2*omega + 3, -2*omega + 5, -omega + 6, -omega + 7, 6*omega - 3, -4*omega - 4, -4*omega - 3, -4*omega - 2, -4*omega, -4*omega + 1, -4*omega + 2, -4*omega + 3, -4*omega + 4, -4*omega + 5, -4*omega + 6, -4*omega + 7, 4*omega - 1, -5*omega + 6, -7, -6, -5, -4, -3]', '1500.568172', 'successfull', 'Same weight coefficients sets are found by these group(s) of methods:[[1], [4]]', None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base'], ['23.2.2016 20:04:00', 'x^2 + 2', '[0, 1, -1]', 'A+A', '3', '2', '3', 'yes', 'I*sqrt(2)', 't^2 + 2', 'omega', 'I*sqrt(2)', 'x^2 + 2', '[-I*sqrt(2), I*sqrt(2)]', '[sqrt(2), sqrt(2)]', None, '[[0], [1, -1]]', '[]', '[[0], [1], [-1]]', '[]', 'yes', '4', 'OK', '173', '[173]', '15', 'OK', '8', 'OK', '9', '[0, 0, 0, 0, 0, 409, 11580, 304300, 91000]', '[3, 4, 5, 6, 7, omega - 7, omega - 6, omega - 5, omega - 4, omega - 3, omega + 3, omega + 4, 5*omega - 7, 5*omega - 6, 5*omega - 5, 5*omega - 4, 5*omega - 3, 5*omega - 1, 5*omega, 5*omega + 1, 5*omega + 2, 5*omega + 3, -3*omega - 5, -3*omega - 4, -3*omega - 3, -3*omega - 2, -3*omega, -3*omega + 1, -3*omega + 2, -3*omega + 3, -3*omega + 4, -3*omega + 5, -3*omega + 6, -3*omega + 7, -6*omega - 2, -4*omega - 1, -7*omega, -7*omega + 1, -7*omega + 2, -7*omega + 3, -7*omega + 4, -7*omega + 5, 4*omega - 7, 4*omega - 6, 4*omega - 5, 4*omega - 4, 4*omega - 3, 4*omega - 2, 4*omega, 4*omega + 1, 4*omega + 2, 4*omega + 3, 4*omega + 4, 7*omega - 5, 7*omega - 4, 7*omega - 3, 7*omega - 1, 7*omega, -2*omega - 6, -2*omega - 5, -omega - 4, -2*omega - 3, -2*omega + 3, -2*omega + 4, -omega + 5, -2*omega + 6, -2*omega + 7, omega + 6, 6*omega - 1, 3*omega - 1, -6*omega - 1, 5*omega - 2, -6*omega, -6*omega + 1, -6*omega + 2, -6*omega + 3, -6*omega + 4, -6*omega + 5, -6*omega + 6, -5*omega - 1, 3*omega - 7, 3*omega - 6, 3*omega - 5, 3*omega - 4, 3*omega - 3, 3*omega - 2, 3*omega, 3*omega + 1, 3*omega + 2, 3*omega + 3, 3*omega + 4, 3*omega + 5, 7*omega - 2, -5*omega - 3, -5*omega - 2, -5*omega, -5*omega + 1, -5*omega + 2, -5*omega + 3, -5*omega + 4, -5*omega + 5, omega + 5, -5*omega + 7, -omega - 6, -omega - 5, 6*omega - 6, 6*omega - 5, 6*omega - 4, -2*omega - 4, 6*omega - 2, 6*omega, 6*omega + 1, 6*omega + 2, -omega - 3, 2*omega - 7, 2*omega - 6, 2*omega - 5, 2*omega - 4, 2*omega - 3, -omega + 3, 2*omega + 4, 2*omega + 5, 2*omega + 6, -3*omega - 1, -omega + 4, 2*omega + 3, -2*omega + 5, -omega + 6, -omega + 7, 6*omega - 3, -4*omega - 4, -4*omega - 3, -4*omega - 2, -4*omega, -4*omega + 1, -4*omega + 2, -4*omega + 3, -4*omega + 4, -4*omega + 5, -4*omega + 6, -4*omega + 7, 4*omega - 1, -5*omega + 6, -7, -6, -5, -4, -3]', '1500.568172', 'successfull', 'Same weight coefficients sets are found by these group(s) of methods:[[1], [4]]', None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base'], ['24.2.2016 22:34:00', 'Quadratic_x^2 + 2_automaticAlphabet', '[0, omega + 1, -omega - 1]', 'A+A', '3', '2', '3', 'yes', 'I*sqrt(2)', 't^2 + 2', 'omega', 'I*sqrt(2)', 'x^2 + 2', '[-I*sqrt(2), I*sqrt(2)]', '[sqrt(2), sqrt(2)]', None, '[[0], [omega + 1, -omega - 1]]', '[]', '[[0], [omega + 1], [-omega - 1]]', '[]', 'yes', '2', 'OK', '9', '[1, 3, 9]', '18', 'OK', '4', 'OK', '4', '[0, 9, 30, 250]', '[]', '1.225022', 'successfull', None, None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base'], ['24.2.2016 22:41:00', 'Quadratic_x^2 + 2_automaticAlphabet', '[0, omega + 1, -omega - 1]', 'A+A', '3', '2', '3', 'yes', 'I*sqrt(2)', 't^2 + 2', 'omega', 'I*sqrt(2)', 'x^2 + 2', '[-I*sqrt(2), I*sqrt(2)]', '[sqrt(2), sqrt(2)]', None, '[[0], [omega + 1, -omega - 1]]', '[]', '[[0], [omega + 1], [-omega - 1]]', '[]', 'yes', '2', 'OK', '9', '[1, 3, 9]', '19', 'OK', '4', 'OK', '4', '[0, 9, 30, 250]', '[]', '1.261398', 'successfull', None, None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base'], ['24.2.2016 22:56:00', 'Quadratic_x^2 + 2_automaticAlphabet', '[0, omega + 1, -omega - 1]', 'A+A', '3', '2', '3', 'yes', 'I*sqrt(2)', 't^2 + 2', 'omega', 'I*sqrt(2)', 'x^2 + 2', '[-I*sqrt(2), I*sqrt(2)]', '[sqrt(2), sqrt(2)]', None, '[[0], [omega + 1, -omega - 1]]', '[]', '[[0], [omega + 1], [-omega - 1]]', '[]', 'yes', '3', 'OK', '9', '[1, 3, 9]', '19', 'OK', '4', 'OK', '4', '[0, 9, 30, 250]', '[]', '1.256088', 'successfull', None, None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base'], ['2.3.2016 7:59:00', 'Quadratic_gen_x^2 + 2_automaticIntegerAlphabet_-1*omega+(0)', '[-1, 0, 1]', 'A+A', '3', '2', '3', 'yes', 'I*sqrt(2)', 't^2 + 2', '-omega', '-I*sqrt(2)', 'x^2 + 2', '[-I*sqrt(2), I*sqrt(2)]', '[sqrt(2), sqrt(2)]', None, '[[-1, 1], [0]]', '[]', '[[-1], [0], [1]]', '[]', 'yes', '8', 'OK', '9', '[1, 3, 9]', '15', 'OK', '4', 'OK', '4', '[0, 9, 30, 250]', '[]', '0.995938', 'successfull', None, None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base'], ['2.3.2016 8:01:00', 'Quadratic_gen_x^2 + 2_automaticIntegerAlphabet_1*omega+(0)', '[-1, 0, 1]', 'A+A', '3', '2', '3', 'yes', 'I*sqrt(2)', 't^2 + 2', 'omega', 'I*sqrt(2)', 'x^2 + 2', '[-I*sqrt(2), I*sqrt(2)]', '[sqrt(2), sqrt(2)]', None, '[[-1, 1], [0]]', '[]', '[[-1], [0], [1]]', '[]', 'yes', '8', 'OK', '9', '[1, 3, 9]', '15', 'OK', '4', 'OK', '4', '[0, 9, 30, 250]', '[]', '0.990085999998', 'successfull', None, None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base'], ['2.3.2016 22:06:00', 'Quadratic_gen_x^2 - 2*x + 3_automaticIntegerAlphabet_-1*omega+(1)', '[-1, 0, 1]', 'A+A', '3', '2', '3', 'yes', 'I*sqrt(2) + 1', 't^2 - 2*t + 3', '-omega + 1', '-I*sqrt(2)', 'x^2 + 2', '[-I*sqrt(2), I*sqrt(2)]', '[sqrt(2), sqrt(2)]', None, '[[-1, 1], [0]]', '[]', '[[-1], [0], [1]]', '[]', 'yes', '8', 'OK', '9', '[1, 3, 9]', '15', 'OK', '4', 'OK', '4', '[0, 9, 30, 250]', '[]', '1.12429400001', 'successfull', None, None, 'yes', 'alphabet contains possibly only one representative in each congruence class mod base']]
︡e858a7a0-3cd3-4ae8-9564-e2bb01df729a︡︡{"done":true}
︠a71d3356-e526-4d51-8b73-299ab7e1091c︠


        if col in [ columns['Is alphabet minimal?'], columns['Phase 1'], columns['Phase 2'], columns['Is alphabet minimal?']]:
            row_tex+= row[col]+' & '
        elif col in [columns['Minimal polynomial of base']]:
            row_tex+=  '$'+row[col]+'$ & '
        elif col==columns['Real conjugates of base greater than 1']:
            if row[col]:
                row_tex+=  row[col]+' & '
            else:
                row_tex+=' & '
        elif col==columns['One letter inputs (problematic letters)']:
            row_tex+=  row[col]+' & '
        elif col in [columns['Minimal polynomial of generator omega'],columns['Name']]:
            pass
        else:
            row_tex+=  '$'+latex(sage.misc.sage_eval.sage_eval(row[col], locals={'omega':omega}))+'$ & '



︡f787d4da-a012-4f7d-b702-5a139fcba8a4︡
︠9433f554-c906-4cba-97d7-3fe598c48658︠
︡c24cc8f7-6eda-4b02-ac3c-6ceca6b34b01︡︡{"done":true}
︠fb6cdee5-22bc-4e3f-896a-9bddaa0044c5︠
︠0934d45f-c4b1-4dea-9ec4-55751c5166dc︠










