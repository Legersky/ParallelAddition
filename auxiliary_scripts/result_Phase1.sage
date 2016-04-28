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

category='compare'
_alphabet=['A','B','C','D','E', 'F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V', 'W', 'X','Y', 'Z']
col_titles=['Name','Ring generator','Minimal polynomial of generator omega', 'Base', 'Minimal polynomial of base','Real conjugates of base greater than 1','#A', 'Is alphabet minimal?', 'Size of weight coefficients set',  'One letter inputs (problematic letters)', 'Phase 2','Length of maximal input of weight function','Phase 2 - method No.','Numbers of saved combinations', 'Elapsed time','Sizes of intermediate weight coefficients sets','Phase 1', 'Alphabet', 'Input alphabet','Phase 1 - method No.', 'Error', 'Base (explicit)','Alphabet dividied into congruence classes mod base -1', 'Alphabet dividied into congruence classes mod base']



#['Name','Ring generator','Minimal polynomial of generator omega', 'Base', 'Minimal polynomial of base','Real conjugates of base greater than 1','#A', 'Is alphabet minimal?', 'Size of weight coefficients set',  'One letter inputs (problematic letters)', 'Phase 2','Length of maximal input of weight function','Phase 2 - method No.','Phase 1 - method No.','Numbers of saved combinations', 'Elapsed time', 'Base (explicit)', 'Alphabet', 'Input alphabet']# ,'Sizes of intermediate weight coefficients sets',, , ,'Phase 1',,


col_titles_phase1=['Name','Ring generator','Minimal polynomial of generator omega', 'Base', 'Minimal polynomial of base','Real conjugates of base greater than 1','#A', 'Is alphabet minimal?'  ]# 'Size of weight coefficients set','Sizes of intermediate weight coefficients sets',,  'One letter inputs (problematic letters)', 'Phase 2', 'Length of maximal input of weight function','Phase 1', 'Alphabet', 'Input alphabet','Numbers of saved combinations','Phase 1 - method No.','Phase 2 - method No.'

columns={}
columns={'Elapsed time': 33, 'Alphabet': 3, 'Input alphabet': 4, 'Length of maximal input of weight function': 30, 'Ring generator': 9, 'Name': 2, 'Alphabet dividied into congruence classes mod base': 17, 'Size of weight coefficients set': 24, 'Numbers of saved combinations': 31, 'Base': 11, 'Alphabet dividied into congruence classes mod base -1': 19, 'One letter inputs (problematic letters)': 27, 'Real conjugates of base greater than 1': 16, 'Minimal polynomial of generator omega': 10, 'Error': 34, 'Sizes of intermediate weight coefficients sets': 25, 'Minimal polynomial of base': 13, '#A': 5, 'Base (explicit)': 12, 'Phase 2': 29, 'Phase 1 - method No.': 22, 'Phase 1': 23, 'Phase 2 - method No.': 26, 'Is alphabet minimal?': 8}

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

names_cmp1=['Eisenstein\\_1--block\\_complex', 'Eisenstein\\_1--block\\_integer', 'Eisenstein\\_2--block\\_complex', 'Eisenstein\\_2--block\\_integer', 'Penney\\_1--block\\_complex', 'Penney\\_1--block\\_integer', 'Penney\\_2--block\\_integer', 'Quadratic+1+0--17\\_integer', 'Quadratic+1+0--2\\_integer', 'Quadratic+1+0--21\\_integer', 'Quadratic+1+0--3\\_integer', 'Quadratic+1+0--5\\_integer', 'Quadratic+1+2+3\\_complex', 'Quadratic+1+3+4\\_complex', 'Quadratic+1+3+5\\_complex1', 'Quadratic+1+3+5\\_complex2 ', 'Quadratic+1+4+5\\_complex1', 'Quadratic+1+4+5\\_complex2', 'Quadratic+1+9+19\\_complex']
methods_cmp1=[[[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6], [8, 11], [9, 10], [12, 13, 15, 16], [14]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[12, 13, 15, 16], [14]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 11, 12, 13, 14, 15, 16], [9, 10]], [[6, 8, 12], [9, 10, 11, 16], [13, 15], [14]], [[6, 14], [8, 11, 12, 16], [9, 10, 13,15]], [[6], [8, 11], [9, 10], [12, 16], [13, 15], [14]], [[6, 14], [8, 9, 10, 11, 12, 13, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]], [[6, 8, 9, 10, 11, 12, 13, 14, 15, 16]]]
lens_cmp1=[[19], [113, 53, 52, 57, 139], [17], [26], [45], [49, 141], [27], [9], [9], [9], [9], [9], [27, 26], [20, 19, 20, 21], [19, 11, 17], [39, 31, 34, 33, 39, 43], [19, 17], [17], [11]]




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
    elif _key=='Error':
        return data[_key][ind].replace('omega','\\omega').replace('[','$(').replace(']',')$').replace('*','').replace('...','\\dots')
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
methods=[12,13,14,15,16]#[14,8,12,9,13,10,15,11,16]
with open('comparePhase1.tex', 'w') as fp:
    stdout = sys.stdout
    sys.stdout = fp
    ex_code=iter(cartesian_product([_alphabet,_alphabet]))

    print '\\begin{tabular}{ll|c c c c|ccc|c',
    for i in range(0,len(methods)):
        print 'c ',
    print '}'

    title_tex='\\multirow{2}{*}{Ex.} &'
    methods_tex=' & '
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
        code=next(ex_code)
        row_tex='\\ref{ex:'+category+code[0]+code[1]+'} & '
        for col_title in col_titles_phase1:
            row_tex+= str(data_tex[col_title][row])+ ' & '
        pos=names_cmp1.index(data_tex['Name'][row])
        lengths={}
        for ind, m_group in enumerate(methods_cmp1[pos]):
            for m in m_group:
                lengths[m]=lens_cmp1[pos][ind]
            if names_cmp1[pos] in differentPhase1:
                differentPhase1[names_cmp1[pos]].append([lens_cmp1[pos][ind],m_group])# append(lens_cmp1[pos][ind])
            else:
                differentPhase1[names_cmp1[pos]]=[[lens_cmp1[pos][ind],m_group]] #[lens_cmp1[pos][ind]]
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

    ex_code=iter(cartesian_product([_alphabet,_alphabet]))
    print '\\begin{tabular}{ll|cc|',
    for i in range(0,len(methods_phase2)-1):
        print 'ccc| ',
    print 'ccc}'

    title_tex='\\multirow{2}{*}{Ex.}  & \\multirow{2}{*}{Name}  & Methods & \\multirow{2}{*}{$\\#\\Q$}&'
 #   for col_title in col_titles_phase1:
#        title_tex+= col_titles_table[col_title]+ ' & '
#    title_tex+= '$\\#\\Q\\,:$'
    title2=' & & Phase 1&  '
    for m in methods_phase2[0:-1]:
        title_tex+= '\\multicolumn{3}{c|}{$'+str(m)+ '$} & '
        title2+='&$bbb$ & Ph.2 & $r$ '
    print title_tex+'\\multicolumn{3}{c}{$'+str(methods_phase2[-1])+ '$} '+'\\\\'
    print title2 + '&$bbb$ & Ph.2 & $r$ \\\\ \\hline'


    for name in names_sorted[1:]:
        _name=name
        diffPhase1=differentPhase1[name]

        code=next(ex_code)

        n=0
        for nameQ in diffPhase1:
            if Set(nameQ[1]).intersection(Set(methods)):
                n+=1
        for nameQ in diffPhase1:
            #sys.stderr.write(name+'\n')
            #sys.stderr.write(str(nameQ[1])+'\n')
            if Set(nameQ[1]).intersection(Set(methods)):
                if _name:
                    row_tex='\\multirow{'+str(n)+ '}{*}{\\ref{ex:'+category+code[0]+code[1]+'} } &' +'\\multirow{'+str(n)+ '}{*}{'+_name+'}'
                else:
                    row_tex=' & '
                ms=Set(nameQ[1]).intersection(Set(methods)).list()
                ms.sort()
                row_tex+='& $'+str(ms)[1:-1]+'$ & $'+str(nameQ[0])+'$ &'
                for m in methods_phase2:
                    method_res=''
                    saved=False
                    for r,name_data_tex in enumerate(data_tex['Name']):
                        #sys.stderr.write(name+'  '+name_data_tex+'\n')
                        #sys.stderr.write(str(nameQ)+' - '+str(data['Size of weight coefficients set'][r])+'\n')
                        if not saved and name_data_tex==name and int(data['Size of weight coefficients set'][r])==nameQ[0] and (int(data['Phase 1 - method No.'][r]) in nameQ[1]) and int(data['Phase 2 - method No.'][r])==m:
                            saved=True
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




# with open('comparePhase2_time.tex', 'w') as fp:
    # stdout = sys.stdout
    # sys.stdout = fp

    # print '\\begin{tabular}{l|c|',
    # for i in range(0,len(methods_phase2)-1):
        # print 'r ',
    # print 'r}'

    # title_tex='\\multirow{1}{*}{Name} & \\multirow{1}{*}{$\\#\\Q$}&'
 # #   for col_title in col_titles_phase1:
# #        title_tex+= col_titles_table[col_title]+ ' & '
# #    title_tex+= '$\\#\\Q\\,:$'
    # title2=' &  '
    # for m in methods_phase2[0:-1]:
        # title_tex+= '$'+str(m)+ '$ & '
    # print title_tex+'$'+str(methods_phase2[-1])+ '$ '+'\\\\'


    # for name in names_sorted[1:]:
        # _name=name
        # for nameQ in differentPhase1[name]:
            # row_tex=''
            # if _name:
                # row_tex='\\multirow{'+str(len(differentPhase1[name]))+ '}{*}{'+_name+'}'
            # row_tex+=' & $'+str(nameQ)+'$ &'
            # for m in methods_phase2:
                # method_res=''
                # for r,name_data_tex in enumerate(data_tex['Name']):
                    # #sys.stderr.write(name+'  '+name_data_tex+'\n')
                    # #sys.stderr.write(str(nameQ)+' - '+str(data['Size of weight coefficients set'][r])+'\n')
                    # if name_data_tex==name and int(data['Phase 1 - method No.'][r])==nameQ and int(data['Phase 2 - method No.'][r])==m:
                        # #sys.stderr.write(str(r))
                        # if data_tex['Phase 2'][r]=='\\checkmark':
                            # method_res+=data_tex['Elapsed time'][r][0:-5]+ ' & '
                        # else:
                            # method_res+='('+data_tex['Elapsed time'][r][0:-5]+ ') & '
                # if not method_res:
                    # method_res+='-& '
                # row_tex+=method_res

            # print row_tex[0:-2]+'\\\\'
            # _name=''
        # print '\\hline'

    # print '\\end{tabular}'
    # sys.stdout = stdout

def setBraces(s):
    return s.replace('[','\\{').replace(']','\\}')





methods_phase2=[9,15,22,23]
with open('comparePhase2_examples.tex', 'w') as fp:
    stdout = sys.stdout
    sys.stdout = fp

    ex_code=iter(cartesian_product([_alphabet,_alphabet]))
    for name in names_sorted[1:]:
        _name=name
        code=next(ex_code)
        diffPhase1=differentPhase1[name]
        row1=0
        for r,name_data_tex in enumerate(data_tex['Name']):
            if name_data_tex==name:
                row1=r
                break


        print '\\begin{exmp}'
        print "\\label{ex:"+category+code[0]+code[1]+'}\n'
        print name
        print '\n\\rule{0cm}{0cm}\n'
        print '\\begin{tabular}{ll}'
        print '$\\omega=', getVal('Ring generator',row1)[1:], ' & $\\beta=' +getVal('Base',row1)[1:-1]+'='+getVal('Base (explicit)',row1)[1:]+ '\\\\'
        print '$m_\\omega(t)=',getVal('Minimal polynomial of generator omega',row1)[1:],' & '+ '$m_\\beta(x)=',getVal('Minimal polynomial of base',row1)[1:]+'\\\\'
        print 'Real conjugate of $\\beta$ greater than 1: ',' & ', getVal('Real conjugates of base greater than 1',row1), '\\\\'

        if data['Is alphabet minimal?'][row1]=='yes':
            print '$\\#\\A=',getVal('#A',row1),'$ & $\\A$ is minimal. \\\\'
        else:
            print '$\\#\\A=',getVal('#A',row1),'$ & $\\A$ is not minimal. \\\\'
   #     print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth}\\begin{dmath*}\\B ="  + setBraces(getVal('Input alphabet',row1)[1:-1])+' \\end{dmath*}\\end{minipage} }\\\\[10pt]'
        print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth}\\begin{dmath*}\\A ="  + setBraces(getVal('Alphabet',row1)[1:-1])+' \\end{dmath*}\\end{minipage} }\\\\'
        print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth}$\A$ divided into congruence classes modulo $\\beta$: \\begin{dmath*}"  + setBraces(getVal('Alphabet dividied into congruence classes mod base',row1))[1:-1]+' \\end{dmath*}\\end{minipage} }\\\\[10pt]'
        print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth}$\A$ divided into congruence classes modulo $\\beta-1$: \\begin{dmath*}"  + setBraces(getVal('Alphabet dividied into congruence classes mod base -1',row1))[1:-1]+' \\end{dmath*}\\end{minipage} }\\\\'
        print ' & \\\\ \\hline'
        print ' & \\\\'
        print '\\end{tabular}\n'
        print '\\begin{tabular}{ll}'
        for nameQ in diffPhase1:
            if Set(nameQ[1]).intersection(Set(methods)):
                ms=Set(nameQ[1]).intersection(Set(methods)).list()
                ms.sort()
                print 'Phase 1 (methods $'+str(ms)[1:-1]+'$): &'
                print '\\checkmark, $\\#\\mathcal{Q} =' + str(nameQ[0])+ '$ \\\\ '
                for m in methods_phase2:
                    method_res=''
                    saved=False
                    print 'Method ',str(m)+': &\\\\'
                    for row,name_data_tex in enumerate(data_tex['Name']):
                        if not saved and name_data_tex==name and int(data['Size of weight coefficients set'][row])==nameQ[0] and (int(data['Phase 1 - method No.'][row]) in nameQ[1]) and int(data['Phase 2 - method No.'][row])==m:
                            saved=True
                            if data['One letter inputs (problematic letters)'][row]=='OK':
                                print '$b,b,\\dots,b$ inputs: & \\checkmark \\\\'
                                if  data['Phase 2'][row]=='OK':
                                    print 'Phase 2: & \\checkmark , $r=', getVal('Length of maximal input of weight function',row) + '$ \\\\'
                                else:
                                    print "\multicolumn{2}{l}{\\begin{minipage}{\\textwidth} Phase 2 fails because ", getVal('Error',row).replace('The', 'the') + '\\end{minipage} }\\\\'
                            else:
                                print 'Failing $b,b,\\dots,b$ inputs: & $'+ setBraces(data['One letter inputs (problematic letters)'][row].replace('omega','\\omega').replace('*',''))+ '$ \\\\'

                print '\\hline'

        print '\\end{tabular}\n'

        print '\\end{exmp}'
        print '\n'
        print '\n'
    sys.stdout = stdout





