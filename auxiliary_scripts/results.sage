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
chosen_inputs=['Quadratic+1+0+11_integer_bigger', 'Quadratic+1+0+11_integer', 'Quadratic_gen_x^2 - x + 3_automaticAlphabet_-2*omega+(-3)', 'Quadratic_gen_x^2 + x + 3_automaticAlphabet_2*omega+(-3)', 'Quadratic_gen_x^2 + x + 3_automaticAlphabet_1*omega+(-3)', 'Quadratic+1+0+7_integer_bigger', 'Quadratic+1+0+7_integer', 'Quadratic_gen_x^2 + x + 2_automaticAlphabet_1*omega+(0)', 'Quadratic_gen_x^2 + x + 2_automaticAlphabet_2*omega+(-3)', 'Quadratic_gen_x^2 - 3*x + 3_automaticAlphabet_-3*omega+(-3)', 'Quadratic_x^2 + 9*x + 27_ownAlphabet', 'Quadratic_gen_x^2 - x + 1_automaticAlphabet_-2*omega+(0)', 'Quadratic_gen_x^2 - x + 1_automaticAlphabet>=1.3*m(0)_-3*omega+(2)', 'Quadratic_gen_x^2 + 3_automaticIntegerAlphabet_1*omega+(0)', 'Quadratic_gen_x^2 + 2*x + 3_automaticAlphabet_2*omega+(2)', 'Quadratic_x^2 + 2_automaticIntegerAlphabet', 'Quadratic_gen_x^2 + 2*x + 3_automaticAlphabet_1*omega+(-2)', 'Quadratic_gen_x^2 - 2*x + 2_automaticAlphabet_-2*omega+(-2)', 'Quadratic_gen_x^2 + 1_automaticAlphabet_-3*omega+(-3)', 'Quadratic_gen_x^2 + 4*x - 4_automaticIntegerAlphabet_-1*omega+(-2)', 'Quadratic_gen_x^2 - 2_automaticAlphabet_-1*omega+(0)', 'Quadratic+1+0-3_integer', 'Quadratic_gen_x^2 - x - 1_automaticAlphabet>=1.3*m(0)_mensi_-2*omega+(1)', 'Quadratic_gen_x^2 - 2*x - 4_automaticIntegerAlphabet_1*omega+(-1)', 'Quadratic_gen_x^2 - 3*x + 1_automaticAlphabet_-3*omega+(-3)', 'Quadratic_gen_x^2 - 3*x + 1_automaticAlphabet_-2*omega+(-2)', 'Quadratic_gen_x^2 - 2*x - 5_automaticIntegerAlphabet_1*omega+(-1)', 'Quadratic_gen_x^2 + 2*x - 5_automaticIntegerAlphabet_1*omega+(1)', 'Quadratic_gen_x^2 - 4*x - 3_automaticIntegerAlphabet_-1*omega+(2)', 'Quadratic_gen_x^2 - x - 3_automaticAlphabet>=1.3*m(0)_mensi_-2*omega+(1)', 'Quadratic+1+0-17_integer', 'Quadratic_gen_x^2 + 3*x - 2_automaticAlphabet_1*omega+(-3)', 'Quadratic+1+0-21_integer', 'Quadratic_gen_x^2 - 3*x - 5_automaticAlphabet>=m(1)+2_3*omega+(1)', 'Quadratic_gen_x^2 - 5*x - 3_automaticAlphabet>=m(1)+2_-1*omega+(-3)', 'Cubic+1+0+0+2_integer', 'Cubic+1+0+0-2_integer', 'Cubic_gen_x^3 - 2*x - 2_automaticAlphabet_-2*omega^2+(1*omega)+(2)', 'Cubic_gen_x^3 - x^2 - 2_automaticAlphabet_-1*omega^2+(1*omega)+(-1)']

if not chosen_inputs:
    chosen_inputs=ws_vybrane.col_values(2)[1:]
    print chosen_inputs

chosen_inputs_category=[]
chosen_inputs_category=['integer', 'integer', 'complex', 'complex', 'complex', 'integer', 'integer', 'complex', 'complex', 'complex', 'complex', 'complex', 'integer', 'integer', 'complex', 'integer', 'complex', 'complex', 'complex', None, 'integer', 'integer', 'integer', 'integer', 'complex', 'complex', 'integer', 'integer', 'integer', 'integer', 'integer', 'complex', 'integer', 'kill', 'kill', 'cubic', 'cubic', 'kill', 'kill']

if not chosen_inputs_category:
    chosen_inputs_category=ws_vybrane.col_values(1)[1:]
    print chosen_inputs_category

col_titles=['Name','Ring generator','Minimal polynomial of generator omega', 'Base', 'Minimal polynomial of base','Real conjugates of base greater than 1','#A', 'Is alphabet minimal?', 'Size of weight coefficients set',  'One letter inputs (problematic letters)', 'Phase 2','Length of maximal input of weight function','Phase 2 - method No.','Numbers of saved combinations', 'Elapsed time','Sizes of intermediate weight coefficients sets','Phase 1', 'Alphabet', 'Input alphabet','Phase 1 - method No.', 'Error', 'Base (explicit)','Alphabet dividied into congruence classes mod base -1', 'Alphabet dividied into congruence classes mod base','Maximal length of one letter inputs']#

col_titles_tab=['Ring generator','Base (explicit)', 'Minimal polynomial of base','Real conjugates of base greater than 1','#A', 'Is alphabet minimal?',   'Size of weight coefficients set',  'One letter inputs (problematic letters)', 'Phase 2', 'Length of maximal input of weight function']#'Name',,,'Phase 1', 'Alphabet', 'Input alphabet','Numbers of saved combinations','Phase 1 - method No.','Phase 2 - method No.','Minimal polynomial of generator omega' 'Base',

columns={}
columns={'Maximal length of one letter inputs': 28, 'Elapsed time': 33, 'Alphabet': 3, 'Input alphabet': 4, 'Length of maximal input of weight function': 30, 'Ring generator': 9, 'Name': 2, 'Alphabet dividied into congruence classes mod base': 17, 'Size of weight coefficients set': 24, 'Numbers of saved combinations': 31, 'Base': 11, 'Alphabet dividied into congruence classes mod base -1': 19, 'One letter inputs (problematic letters)': 27, 'Real conjugates of base greater than 1': 16, 'Minimal polynomial of generator omega': 10, 'Error': 34, 'Sizes of intermediate weight coefficients sets': 25, 'Minimal polynomial of base': 13, '#A': 5, 'Base (explicit)': 12, 'Phase 2': 29, 'Phase 1 - method No.': 22, 'Phase 1': 23, 'Phase 2 - method No.': 26, 'Is alphabet minimal?': 8}

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
                  'Base (explicit)':'$\\beta$',
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

methods1_letter={14:'1a', 12:'1b', 16:'1c', 13:'1d',15:'1e', 4:'thm', 9:'9'}
methods2_letter={9:'2a',15:'2b',22:'2c', 23:'2d', 14:'2e', 21:'21'}

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
        return data[_key][ind].replace('omega','\\omega').replace('[','$(').replace(']',')$').replace('*','').replace('...','\\dots')
    elif _key=='Numbers of saved combinations':
        return sage.misc.sage_eval.sage_eval(str(data[_key][ind]))
    else:
        try:
            return '$'+latex(sage.misc.sage_eval.sage_eval(data[_key][ind],locals={'omega':omega, 't':t, 'x':x}))+'$'
        except:
            return data[_key][ind]

rows=[]
category='kill' #complex' #'integer'#'cubic'
for ind,_input in enumerate(chosen_inputs_category):
    if _input==category:
        for r,_name in enumerate(data['Name']):
            if _name==chosen_inputs[ind]:# and data['Phase 1 - method No.'][r] in ['13']:
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
        for col in col_titles_tab:
            row_tex+=str(getVal(col,row))+' & '
        rows_tex.append(row_tex[0:-2]+'\\\\')

        print '\\begin{exmp}'
        print "\\label{ex:"+category+code[0]+code[1]+'}\n'

       # print 'An alphabet $\A$ divided into congruence classes modulo $\\beta$: '
        #print "$$"  + setBraces(getVal('Alphabet dividied into congruence classes mod base',row))[1:-1]+'\\,,$$\n'
        #print "and modulo $\\beta - 1$: $$"  + setBraces(getVal('Alphabet dividied into congruence classes mod base -1',row))[1:-1]+'\\,.$$\n'

        if 1:
            print '\n\\rule{0cm}{0cm}\n'
            print '\\begin{tabular}{ll}'
            print '$\\omega=', getVal('Ring generator',row)[1:], ' & $\\beta=' +getVal('Base',row)[1:-1]+'='+getVal('Base (explicit)',row)[1:]+ '\\\\'
            print '$m_\\omega(t)=',getVal('Minimal polynomial of generator omega',row)[1:],' & '+ '$m_\\beta(x)=',getVal('Minimal polynomial of base',row)[1:]+'\\\\'
            print 'Real conjugate of $\\beta$ greater than 1: ',' & ', getVal('Real conjugates of base greater than 1',row), '\\\\'
            if data['Is alphabet minimal?'][row]=='yes':
                print '$\\#\\A=',getVal('#A',row),'$ & $\\A$ is minimal. \\\\'
            else:
                print '$\\#\\A=',getVal('#A',row),'$ & $\\A$ is not minimal. \\\\'
            #print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth}\\begin{dmath*}\\B ="  + setBraces(getVal('Input alphabet',row)[1:-1])+' \\end{dmath*}\\end{minipage} }\\\\[10pt]'
            print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth}\\begin{dmath*}\\A ="  + setBraces(getVal('Alphabet',row)[1:-1])+' \\end{dmath*}\\end{minipage} }\\\\'
            #print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth}$\A$ divided into congruence classes modulo $\\beta$: \\begin{dmath*}"  + setBraces(getVal('Alphabet dividied into congruence classes mod base',row))[1:-1]+' \\end{dmath*}\\end{minipage} }\\\\[10pt]'
            #print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth}$\A$ divided into congruence classes modulo $\\beta-1$: \\begin{dmath*}"  + setBraces(getVal('Alphabet dividied into congruence classes mod base -1',row))[1:-1]+' \\end{dmath*}\\end{minipage} }\\\\'
            #print ' & \\\\ \\hline'
            print ' & \\\\'
            print 'Phase 1 (method ',methods1_letter[int(getVal('Phase 1 - method No.',row))]+'): &'
            if data['Phase 1'][row]=='OK':
                print '\\checkmark, $\\#\\mathcal{Q} =' + getVal('Size of weight coefficients set',row)+ '$ \\\\ '
                if data['One letter inputs (problematic letters)'][row]=='OK':
                    print '$b,b,\\dots,b$ inputs (method ',methods2_letter[int(getVal('Phase 2 - method No.',row))]+'): & \\checkmark, maximal length of window: '+ getVal('Maximal length of one letter inputs',row)+ ' \\\\'
                    if  data['Phase 2'][row]=='OK':
                        print 'Phase 2 (method ',methods2_letter[int(getVal('Phase 2 - method No.',row))]+'): & \\checkmark , $r=', getVal('Length of maximal input of weight function',row) + '$ \\\\'
                    else:
                        #print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth} Phase 2 (method ",methods2_letter[int(getVal('Phase 2 - method No.',row))]+') fails because ', getVal('Error',row).replace('The', 'the') +'\\end{minipage} }\\\\'
                        if getVal('Numbers of saved combinations',row):
                            saved_combinations=getVal('Numbers of saved combinations',row)
                        else:
                            saved_combinations=[]
                        print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth} Computation of Phase 2 (method ",methods2_letter[int(getVal('Phase 2 - method No.',row))]+') was killed when the length of window ' +str(len(saved_combinations)+1) + ' was being proccessed. Numbers of saved combinations for each finished length of window are: '+str(saved_combinations) +'\\end{minipage} }\\\\'
                else:
                    print 'Failing $b,b,\\dots,b$ inputs (method ',methods1_letter[int(getVal('Phase 2 - method No.',row))]+'): & '+ setBraces(data['One letter inputs (problematic letters)'][row])+ '\\\\'
            else:
                print '\\xmark \\\\'
            print '\\end{tabular}\n'

        print '\\end{exmp}'
        print '\n'
        #print '\n'

    if 0:
        print '\\begin{tabular}{l|c|cc c| c c| c| c c c }'
        title='Ex. &'
        for col in col_titles_tab:
            title+= col_titles_table[col]+ ' & '
        print title[0:-2], ' \\\\ \\hline'
        for row in rows_tex:
            print row
        print '\\end{tabular}'

    sys.stdout = stdout
