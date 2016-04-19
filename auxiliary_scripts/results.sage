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
    ws_results=sheet.worksheet('results_zpracovane')
except Exception, e:
    print "Some problem with google spreadsheet:"
    print e

chosen_inputs=[]
chosen_inputs=['Quadratic_x^2 + x + 2_automaticAlphabet', 'x^2 + 2', 'Eisenstein_1-block_complex', 'Quadratic_gen_x^2 - 3*x + 1_automaticAlphabet_-3*omega+(-3)', 'Quadratic_x^2 + x + 4_automaticAlphabet ', 'Quadratic_gen_x^2 - x + 3_automaticAlphabet_-2*omega+(-2)', 'Quadratic_gen_x^2 - x + 3_automaticIntegerAlphabet_-1*omega+(1)', 'Quadratic_gen_x^2 + x + 2_automaticAlphabet_1*omega+(0)', 'x^2 - x + 2_automaticAlphabet', 'Quadratic_gen_x^2 + x + 1_automaticAlphabet_2*omega+(0)', 'Quadratic_gen_x^2 + 3_automaticIntegerAlphabet_-1*omega+(0)', 'Quadratic_gen_x^2 - x + 1_automaticIntegerAlphabet_-3*omega+(2)', 'Quadratic_x^2 + 2_automaticIntegerAlphabet', 'Quadratic_gen_x^2 - 2*x + 3_automaticAlphabet_-1*omega+(-3)', 'Quadratic+1+2+3_complex_bigger', 'Quadratic_gen_x^2 + 2*x + 2_automaticAlphabet_1*omega+(0)', 'Quadratic_gen_x^2 + 1_automaticAlphabet_-3*omega+(0)', 'Quadratic_gen_x^2 - 3*x + 1_automaticAlphabet_-2*omega+(-2)', 'Quadratic_gen_x^2 - 3*x + 1_automaticAlphabet_3*omega+(-3)', 'Quadratic_gen_x^2 + 3*x - 1_automaticAlphabet_1*omega+(-3)', 'Quadratic_gen_x^2 + 3*x - 2_automaticAlphabet_1*omega+(-3)', 'Quadratic_gen_x^2 - x - 3_automaticAlphabet_-2*omega+(2)', 'Quadratic_x^2 - 3*x + 4_automaticAlphabet']

if not chosen_inputs:
    chosen_inputs=ws_vybrane.col_values(2)[1:]
    print chosen_inputs

chosen_inputs_category=[]
chosen_inputs_category=[None, None, None, None, None, None, 'integer', 'integer', 'integer', 'integer', 'integer', 'integer', 'integer', 'integer', 'integer', 'integer', 'integer', 'integer', None, None, None, None, None]
if not chosen_inputs_category:
    chosen_inputs_category=ws_vybrane.col_values(1)[1:]
    print chosen_inputs_category

col_titles=['Name','Ring generator','Minimal polynomial of generator omega', 'Base', 'Minimal polynomial of base','Real conjugates of base greater than 1','#A', 'Is alphabet minimal?', 'Size of weight coefficients set',  'One letter inputs (problematic letters)', 'Phase 2','Length of maximal input of weight function','Phase 2 - method No.','Numbers of saved combinations', 'Elapsed time']# ,'Sizes of intermediate weight coefficients sets',, , ,'Phase 1', 'Alphabet', 'Input alphabet',,'Phase 1 - method No.',

col_titles_tab=['Ring generator','Minimal polynomial of generator omega', 'Base', 'Minimal polynomial of base','Real conjugates of base greater than 1','#A', 'Is alphabet minimal?',   'Size of weight coefficients set',  'One letter inputs (problematic letters)', 'Phase 2', 'Length of maximal input of weight function']#'Name',,,'Phase 1', 'Alphabet', 'Input alphabet','Numbers of saved combinations','Phase 1 - method No.','Phase 2 - method No.'

columns={}
columns={'Elapsed time': 33, 'Real conjugates of base greater than 1': 16, 'Is alphabet minimal?': 8, '#A': 5, 'Size of weight coefficients set': 24, 'Minimal polynomial of generator omega': 10, 'Phase 2': 29, 'Numbers of saved combinations': 31, 'Base': 11, 'Length of maximal input of weight function': 30, 'Phase 2 - method No.': 26, 'Ring generator': 9, 'Minimal polynomial of base': 13, 'One letter inputs (problematic letters)': 27, 'Name': 2}

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

load('data_both.sage')

if not data:
    for col_title in col_titles:
        data[col_title]=ws_results.col_values(columns[col_title])

    with open('data_both.sage', 'w') as fp:
        stdout = sys.stdout
        sys.stdout = fp
        print data
        sys.stdout = stdout


var('omega')
var('t')

def getVal(_key,ind):
    data[_key][ind]
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
    elif _key=='Length of maximal input of weight function':
        return data[_key][ind]
    elif _key=='Name':
        return data[_key][ind].replace('_','\\_').replace('-','--')
    elif _key=='Elapsed time':
        return data[_key][ind]
    #elif _key=='Base':
     #   return '$'+data[_key][ind].replace('omega','\omega')+'$'
    else:
        return '$'+latex(sage.misc.sage_eval.sage_eval(data[_key][ind],locals={'omega':omega, 't':t, 'x':x}))+'$'

data_tex=deepcopy(data)
for ind, name in enumerate(data['Name']):
    if ind:
        for col_title in col_titles:
            data_tex[col_title][ind]=getVal(col_title,ind)


rows=[]
category='integer'
for ind,_input in enumerate(chosen_inputs_category):
    if _input==category:
        for r,_name in enumerate(data['Name']):
            if _name==chosen_inputs[ind]:
                rows.append(r)

_alphabet=['A','B','C','D','E', 'F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V', 'W', 'X','Y', 'Z']
ex_code=iter(cartesian_product([_alphabet,_alphabet]))


filename='results_'+category

shortInput=False
with open(filename+".tex", 'w') as fp:
    stdout = sys.stdout
    sys.stdout = fp

    rows_tex=[]
    for row in rows:
        code=next(ex_code)
        row_tex='\\ref{ex:'+category+code[0]+code[1]+'} & '
        for col in col_titles_tab:
            row_tex+=data_tex[col][row]+' & '
        rows_tex.append(row_tex[0:-2]+'\\\\')


    print '\\begin{tabular}{l|c c|c c c| c c| c| c c c }'
    title='Ex. &'
    for col in col_titles_tab:
        title+= col_titles_table[col]+ ' & '
    print title[0:-2], ' \\\\ \\hline'
    for row in rows_tex:
        print row
    print '\\end{tabular}'

    sys.stdout = stdout
