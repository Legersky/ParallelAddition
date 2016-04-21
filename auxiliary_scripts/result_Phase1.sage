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
    ws_comparePhase2=sheet.worksheet('comparePhase2')
    ws_comparePhase1=sheet.worksheet('comparePhase1')
except Exception, e:
    print "Some problem with google spreadsheet:"
    print e

category='integer'

col_titles=['Name','Ring generator','Minimal polynomial of generator omega', 'Base', 'Minimal polynomial of base','Real conjugates of base greater than 1','#A', 'Is alphabet minimal?', 'Size of weight coefficients set',  'One letter inputs (problematic letters)', 'Phase 2','Length of maximal input of weight function','Phase 2 - method No.','Numbers of saved combinations', 'Elapsed time']# ,'Sizes of intermediate weight coefficients sets',, , ,'Phase 1', 'Alphabet', 'Input alphabet',,'Phase 1 - method No.',
col_titles_phase1=['Name','Ring generator','Minimal polynomial of generator omega', 'Base', 'Minimal polynomial of base','Real conjugates of base greater than 1','#A', 'Is alphabet minimal?'  ]# 'Size of weight coefficients set','Sizes of intermediate weight coefficients sets',,  'One letter inputs (problematic letters)', 'Phase 2', 'Length of maximal input of weight function','Phase 1', 'Alphabet', 'Input alphabet','Numbers of saved combinations','Phase 1 - method No.','Phase 2 - method No.'

columns={}
columns={'Elapsed time': 33, 'Real conjugates of base greater than 1': 16, 'Is alphabet minimal?': 8, '#A': 5, 'Size of weight coefficients set': 24, 'Minimal polynomial of generator omega': 10, 'Phase 2': 29, 'Numbers of saved combinations': 31, 'Base': 11, 'Length of maximal input of weight function': 30, 'Phase 2 - method No.': 26, 'Ring generator': 9, 'Minimal polynomial of base': 13, 'One letter inputs (problematic letters)': 27, 'Name': 2}

if not columns:
    col_titles_ws=ws_comparePhase2.row_values(1)
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
                  'Length of maximal input of weight function': '$m$',
                  'Phase 2 - method No.': 'No.',
                  'Numbers of saved combinations': 'Numbers of saved combinations',
                  'Minimal polynomial of generator omega': '$m_\\omega$',
                  'Minimal polynomial of base': '$m_\\beta$',
                  'One letter inputs (problematic letters)': '$bb\\dots b$',
                  'Is alphabet minimal?': 'min.',
                  'Sizes of intermediate weight coefficients sets':'Sizes'}


data={}

load('data.sage')

if not data:
    for col_title in col_titles:
        data[col_title]=ws_comparePhase2.col_values(columns[col_title])

    with open('data.sage', 'w') as fp:
        stdout = sys.stdout
        sys.stdout = fp
        print 'data=',data
        sys.stdout = stdout

var('omega')
var('t')


names_cmp1=[]
methods_cmp1=[]
lens_cmp1=[]

names_cmp1=['Eisenstein\\_1--block\\_complex', 'Eisenstein\\_1--block\\_integer', 'Eisenstein\\_2--block\\_complex', 'Penney\\_1--block\\_integer', 'Penney\\_2--block\\_integer', 'Quadratic+1+0--2\\_integer', 'Quadratic+1+0--3\\_integer', 'Quadratic+1+0--5\\_integer', 'Quadratic+1+2+3\\_complex', 'Quadratic+1+3+4\\_complex', 'Quadratic+1+3+5\\_complex1', 'Quadratic+1+9+19\\_complex', 'Eisenstein\\_2--block\\_integer', 'Penney\\_1--block\\_complex', 'Quadratic+1+0--21\\_integer', 'Quadratic+1+3+5\\_complex2 ', 'Quadratic+1+4+5\\_complex1', 'Quadratic+1+4+5\\_complex2', 'Eisenstein\\_1--block\\_complex', 'Eisenstein\\_1--block\\_integer', 'Eisenstein\\_2--block\\_complex', 'Eisenstein\\_2--block\\_integer', 'Penney\\_1--block\\_complex', 'Penney\\_1--block\\_integer', 'Penney\\_2--block\\_integer', 'Quadratic+1+0--17\\_integer', 'Quadratic+1+0--2\\_integer', 'Quadratic+1+0--21\\_integer', 'Quadratic+1+0--3\\_integer', 'Quadratic+1+0--5\\_integer', 'Quadratic+1+2+3\\_complex', 'Quadratic+1+3+4\\_complex', 'Quadratic+1+3+5\\_complex1', 'Quadratic+1+3+5\\_complex2 ', 'Quadratic+1+4+5\\_complex1', 'Quadratic+1+4+5\\_complex2', 'Quadratic+1+9+19\\_complex']
methods_cmp1=[[[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6], [8, 11], [9, 10], [12, 13, 15, 16], [14]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6], [8, 9, 10, 11, 12, 13, 15, 16], [14]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 11, 12, 13, 14, 15, 16], [9, 10]], [[6, 8, 12], [9, 10, 11, 16], [13, 15], [14]], [[6, 14], [8, 11, 12, 16], [9, 10, 13, 15]], [[6], [8, 11], [9, 10], [12, 16], [13, 15], [14]], [[6, 14], [8, 9, 10, 11, 12, 13, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]]]
[[19], [113, 53, 52, 57, 139], [17], [26], [45], [97, 27, 95], [27], [9], [9], [9], [9], [9], [27, 26], [20, 19, 20, 21], [19, 11, 17], [39, 31, 34, 33, 39, 43], [19, 17], [17], [11]]
lens_cmp1=[[19], [113, 53, 52, 57, 139], [17], [26], [45], [97, 27, 95], [27], [9], [9], [9], [9], [9], [27, 26], [20, 19, 20, 21], [19, 11, 17], [39, 31, 34, 33, 39, 43], [19, 17], [17], [11]]



if not names_cmp1 or not methods_cmp1 or not lens_cmp1:
    names_cmp1_tmp=ws_comparePhase1.col_values(2)
    methods_cmp1_tmp=ws_comparePhase1.col_values(9)
    lens_cmp1_tmp=ws_comparePhase1.col_values(10)
    sort_cmp1=ws_comparePhase1.col_values(12)
    for ind, s in enumerate(sort_cmp1):
        if s=='kontrola novych metod':
            names_cmp1.append(names_cmp1_tmp[ind].replace('_','\\_').replace('-','--'))
            methods_cmp1.append(sage.misc.sage_eval.sage_eval(methods_cmp1_tmp[ind]))
            lens_cmp1.append(sage.misc.sage_eval.sage_eval(lens_cmp1_tmp[ind]))

    print names_cmp1
    print methods_cmp1
    print lens_cmp1

def getVal(_key,ind):
    if _key in ['Is alphabet minimal?', 'Is alphabet minimal?']:
        return data[_key][ind]
    #elif _key in ['Minimal polynomial of base','Minimal polynomial of generator omega']:
     #   return '$'+data[_key][ind]+'$'
    elif _key=='Real conjugates of base greater than 1':
        if data[_key][ind]!='-':
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




differentPhase1={}
names_sorted=[]
methods=[6,12,8,13,9,14,10,15,11,16]
with open('comparePhase1.tex', 'w') as fp:
    stdout = sys.stdout
    sys.stdout = fp

    print '\\begin{tabular}{l|c c c c|ccc|c',
    for i in range(0,len(methods)):
        print 'c ',
    print '}'

    title_tex=''
    methods_tex=' '
    for col_title in col_titles_phase1:
        title_tex+= '\\multirow{2}{*}{'+col_titles_table[col_title]+ '} & '
        methods_tex+= ' & '
    title_tex+= '\\multicolumn{5}{c}{$\\#\\Q$} \\\\'
    print title_tex

    for m in methods:
        methods_tex+= str(m)+ ' & '
    print methods_tex[:-2]+'\\\\ \\hline'
    rows=[]
    name_prev=''
    for ind,name in enumerate(data_tex['Name']):
        if name!=name_prev:
            rows.append(ind)
            name_prev=name
            names_sorted.append(name)

    for row in rows[1:]:
        row_tex=''
        for col_title in col_titles_phase1:
            row_tex+= str(data_tex[col_title][row])+ ' & '
        pos=names_cmp1.index(data_tex['Name'][row])
        lengths={}
        for ind, m_group in enumerate(methods_cmp1[pos]):
            for m in m_group:
                lengths[m]=lens_cmp1[pos][ind]
            if names_cmp1[pos] in differentPhase1:
                differentPhase1[names_cmp1[pos]].append(lens_cmp1[pos][ind])
            else:
                differentPhase1[names_cmp1[pos]]=[lens_cmp1[pos][ind]]
        for m in methods:
            if m in lengths:
                row_tex+= str(lengths[m])+ ' & '
            else:
                row_tex+= '- & '
        print row_tex[0:-2]+'\\\\'
    print '\\end{tabular}'
    sys.stdout = stdout

#print differentPhase1


methods_phase2=[9,15,22,23]
with open('comparePhase2.tex', 'w') as fp:
    stdout = sys.stdout
    sys.stdout = fp

    print '\\begin{tabular}{l|c|',
    for i in range(0,len(methods_phase2)-1):
        print 'ccc| ',
    print 'ccc}'

    title_tex='\\multirow{2}{*}{Name} & \\multirow{2}{*}{$\\#\\Q$}&'
 #   for col_title in col_titles_phase1:
#        title_tex+= col_titles_table[col_title]+ ' & '
#    title_tex+= '$\\#\\Q\\,:$'
    title2=' &  '
    for m in methods_phase2[0:-1]:
        title_tex+= '\\multicolumn{3}{c|}{$'+str(m)+ '$} & '
        title2+='&$bbb$ & Ph.2 & $r$ '
    print title_tex+'\\multicolumn{3}{c}{$'+str(methods_phase2[-1])+ '$} '+'\\\\'
    print title2 + '&$bbb$ & Ph.2 & $r$ \\\\ \\hline'


    for name in names_sorted[1:]:
        _name=name
        if name in ['Quadratic+1+4+5\\_complex1','Quadratic+1+3+5\\_complex2 ']:
            diffPhase1=differentPhase1[name]
        else:
            diffPhase1=differentPhase1[name][1:]
        for nameQ in diffPhase1:
            row_tex=''
            if _name:
                row_tex='\\multirow{'+str(len(diffPhase1))+ '}{*}{'+_name+'}'
            row_tex+=' & $'+str(nameQ)+'$ &'
            for m in methods_phase2:
                method_res=''
                for r,name_data_tex in enumerate(data_tex['Name']):
                    #sys.stderr.write(name+'  '+name_data_tex+'\n')
                    #sys.stderr.write(str(nameQ)+' - '+str(data['Size of weight coefficients set'][r])+'\n')
                    if name_data_tex==name and int(data['Size of weight coefficients set'][r])==nameQ and int(data['Phase 2 - method No.'][r])==m:
                        #sys.stderr.write(str(r))
                        method_res+=data_tex['One letter inputs (problematic letters)'][r]+ ' & '
                        if method_res=='\\xmark & ':
                            method_res+='- & - & '
                        else:
                            method_res+=data_tex['Phase 2'][r]+ ' & '
                            method_res+=data_tex['Length of maximal input of weight function'][r]+ ' & '
                            #method_res+=str(sum(sage.misc.sage_eval.sage_eval(data['Numbers of saved combinations'][r])))+ ' & '
                if not method_res:
                    method_res+='\\multicolumn{3}{c|}{-} & '
                row_tex+=method_res

            print row_tex[0:-2]+'\\\\'
            _name=''
        print '\\hline'
    print '\\end{tabular}'
    sys.stdout = stdout




with open('comparePhase2_time.tex', 'w') as fp:
    stdout = sys.stdout
    sys.stdout = fp

    print '\\begin{tabular}{l|c|',
    for i in range(0,len(methods_phase2)-1):
        print 'r ',
    print 'r}'

    title_tex='\\multirow{1}{*}{Name} & \\multirow{1}{*}{$\\#\\Q$}&'
 #   for col_title in col_titles_phase1:
#        title_tex+= col_titles_table[col_title]+ ' & '
#    title_tex+= '$\\#\\Q\\,:$'
    title2=' &  '
    for m in methods_phase2[0:-1]:
        title_tex+= '$'+str(m)+ '$ & '
    print title_tex+'$'+str(methods_phase2[-1])+ '$ '+'\\\\'


    for name in names_sorted[1:]:
        _name=name
        for nameQ in differentPhase1[name]:
            row_tex=''
            if _name:
                row_tex='\\multirow{'+str(len(differentPhase1[name]))+ '}{*}{'+_name+'}'
            row_tex+=' & $'+str(nameQ)+'$ &'
            for m in methods_phase2:
                method_res=''
                for r,name_data_tex in enumerate(data_tex['Name']):
                    #sys.stderr.write(name+'  '+name_data_tex+'\n')
                    #sys.stderr.write(str(nameQ)+' - '+str(data['Size of weight coefficients set'][r])+'\n')
                    if name_data_tex==name and int(data['Size of weight coefficients set'][r])==nameQ and int(data['Phase 2 - method No.'][r])==m:
                        #sys.stderr.write(str(r))
                        if data_tex['Phase 2'][r]=='\\checkmark':
                            method_res+=data_tex['Elapsed time'][r][0:-5]+ ' & '
                        else:
                            method_res+='('+data_tex['Elapsed time'][r][0:-5]+ ') & '
                if not method_res:
                    method_res+='-& '
                row_tex+=method_res

            print row_tex[0:-2]+'\\\\'
            _name=''
        print '\\hline'

    print '\\end{tabular}'
    sys.stdout = stdout






