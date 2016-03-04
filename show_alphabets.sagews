︠e8159b95-32e8-46f8-a6e7-55f1ba67ee2ds︠
load_attach_path('./classes')
load('ParAddException.sage')
load('AlgorithmForParallelAddition.sage')


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
    print e

for row in range(3,worksheet.row_count):
    try:
        if worksheet.cell(row, 1).value=='b':
            name = worksheet.cell(row, 2).value
            print name
            minPol =worksheet.cell(row, 6).value.replace('t','x')
            omegaCC= sage.misc.sage_eval.sage_eval(worksheet.cell(row, 5).value)
            alphabet = worksheet.cell(row, 3).value
            inputAlphabet = worksheet.cell(row, 4).value
            if inputAlphabet=='A+A':
                inputAlphabet=''
            base =worksheet.cell(row, 7).value

            alg= AlgorithmForParallelAddition(minPol,CC(omegaCC), alphabet,base,name,inputAlphabet, printLog=True)
            print 'modulo base'
            alg.plotAlphabetDivididedIntoCongruenceClasses(alg._base)
            print 'modulo base - 1'
            alg.plotAlphabetDivididedIntoCongruenceClasses(alg._base-1)
    except ExceptionParAdd, e:
        print e
︡94a08b52-1137-47e4-b9ba-6b3085b4aa2e︡︡{"stdout":"Quadratic_gen_x^2 - 3*x + 1_automaticAlphabet_-2*omega+(-2)","done":false}︡{"stdout":"\nInicialization...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Numeration system: \n","done":false}︡{"stdout":"Quadratic_gen_x^2 - 3*x + 1_automaticAlphabet_-2*omega+(-2)\n","done":false}︡{"stdout":"Alphabet: \n","done":false}︡{"stdout":"[0, omega + 1, -omega - 1, 1, -1, -omega + 1, omega - 1, omega, -omega, 2, -2, -omega + 2, omega - 2, -2*omega + 2, 2*omega - 2, -2*omega + 1, 2*omega - 1, 2*omega, -2*omega, -omega + 3, omega - 3, -2*omega + 3, 2*omega - 3, -3*omega + 3, 3*omega - 3, -3*omega + 2, 3*omega - 2, -3*omega + 1, 3*omega - 1, -2*omega + 4, 2*omega - 4]\n","done":false}︡{"stdout":"Input alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, 3, 4, 3*omega - 2, 5*omega - 2, -6*omega + 2, -6*omega + 3, -6*omega + 4, -6*omega + 5, -6*omega + 6, -2*omega - 2, omega - 5, omega - 4, omega - 3, omega - 1, omega, omega + 1, omega + 2, omega + 3, 5*omega - 7, 5*omega - 6, 5*omega - 5, 5*omega - 4, 5*omega - 3, 5*omega - 1, 3*omega - 7, 3*omega - 6, 3*omega - 5, 3*omega - 4, 3*omega - 3, 3*omega - 1, 3*omega, 3*omega + 1, omega - 2, -2*omega + 5, -3*omega - 1, -3*omega, -3*omega + 1, -3*omega + 2, -3*omega + 3, -3*omega + 4, -3*omega + 5, -3*omega + 6, -5*omega + 1, -5*omega + 2, -5*omega + 3, -5*omega + 4, -5*omega + 5, -5*omega + 6, -5*omega + 7, 6*omega - 6, 6*omega - 5, 6*omega - 4, 6*omega - 3, 6*omega - 2, -omega - 2, -omega - 1, -2*omega + 2, 2*omega - 2, -omega, -2*omega + 1, 2*omega - 6, 2*omega - 5, 2*omega - 4, 2*omega - 3, 2*omega - 1, 2*omega, 2*omega + 1, 2*omega + 2, -omega + 3, -2*omega + 4, 4*omega - 8, 4*omega - 7, 4*omega - 6, 4*omega - 5, 4*omega - 4, 4*omega - 3, 4*omega - 2, 4*omega, -4*omega, -4*omega + 1, -4*omega + 2, -4*omega + 3, -4*omega + 4, -4*omega + 5, -4*omega + 6, -4*omega + 7, -4*omega + 8, -3*omega + 7, -omega - 3, -2*omega - 1, 4*omega - 1, -2*omega, -omega + 1, -omega + 2, -2*omega + 3, -omega + 4, -omega + 5, -2*omega + 6, -1, -4, -3, -2]\n","done":false}︡{"stdout":"Ring generator: \n","done":false}︡{"stdout":"-1/2*sqrt(5) + 3/2\n","done":false}︡{"stdout":"Minimal polynomial of ring generator: \n","done":false}︡{"stdout":"t^2 - 3*t + 1\n","done":false}︡{"stdout":"Base: \n","done":false}︡{"stdout":"-2*omega - 2 = sqrt(5) - 5\n","done":false}︡{"stdout":"Minimal polynomial of base:\n","done":false}︡{"stdout":"x^2 + 10*x + 20\n","done":false}︡{"stdout":"Conjugates of base:\n","done":false}︡{"stdout":"[-sqrt(5) - 5, sqrt(5) - 5]\n","done":false}︡{"stdout":"With absolute values:\n","done":false}︡{"stdout":"[sqrt(5) + 5, -sqrt(5) + 5]\n","done":false}︡{"stdout":"modulo base\n","done":false}︡{"once":false,"done":false,"file":{"show":true,"uuid":"cf4c7253-8e68-43f4-8fa7-ebbbb92c7995","filename":"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.sage/temp/compute4-us/25816/tmp_4YxhjT.svg"}}︡{"html":"<div align='center'></div>","done":false}︡{"stdout":"modulo base - 1","done":false}︡{"stdout":"\n","done":false}︡{"once":false,"done":false,"file":{"show":true,"uuid":"2bb85f9c-8842-4d85-8797-eced14099832","filename":"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.sage/temp/compute4-us/25816/tmp_OmXRSM.svg"}}︡{"html":"<div align='center'></div>","done":false}︡{"stdout":"Quadratic_gen_x^2 - 3*x + 1_automaticAlphabet_-3*omega+(-3)","done":false}︡{"stdout":"\nInicialization...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Numeration system: \n","done":false}︡{"stdout":"Quadratic_gen_x^2 - 3*x + 1_automaticAlphabet_-3*omega+(-3)\n","done":false}︡{"stdout":"Alphabet: \n","done":false}︡{"stdout":"[0, omega + 1, -omega - 1, 1, -1, -omega + 1, omega - 1, omega, -omega, 2*omega + 2, -2*omega - 2, 2, -2, -omega + 2, omega - 2, -2*omega + 2, 2*omega - 2, 2*omega + 1, -2*omega - 1, -2*omega + 1, 2*omega - 1, 2*omega, -2*omega, 3, -3, -omega + 3, omega - 3, -2*omega + 3, 2*omega - 3, -3*omega + 3, 3*omega - 3, -3*omega + 2, 3*omega - 2, -3*omega + 1, 3*omega - 1, 3*omega, -3*omega, -omega + 4, omega - 4, -2*omega + 4, 2*omega - 4, -3*omega + 4, 3*omega - 4, -4*omega + 4, 4*omega - 4, -4*omega + 3, 4*omega - 3, -4*omega + 2, 4*omega - 2, -4*omega + 1, 4*omega - 1, -2*omega + 5, 2*omega - 5, -3*omega + 5, 3*omega - 5, -4*omega + 5, 4*omega - 5, -5*omega + 5, 5*omega - 5, -5*omega + 4, 5*omega - 4]\n","done":false}︡{"stdout":"Input alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, 3, 4, 5, 6, 7, 9*omega - 9, 9*omega - 8, -8*omega + 2, 9*omega - 7, -8*omega + 4, -8*omega + 5, omega - 7, omega - 6, omega - 5, omega - 4, omega - 3, omega - 1, omega, omega + 1, omega + 2, omega + 3, omega + 4, omega + 5, 5*omega - 6, 5*omega - 5, 5*omega - 4, 5*omega - 3, 5*omega - 1, 5*omega, 5*omega + 1, 5*omega + 2, -3*omega - 3, -3*omega - 2, -3*omega, -3*omega + 1, -3*omega + 2, -3*omega + 3, -3*omega + 4, -3*omega + 5, -3*omega + 6, -3*omega + 7, -3*omega + 8, -3*omega + 9, -6*omega - 1, -omega - 3, -2*omega - 1, 8*omega - 10, 8*omega - 9, 8*omega - 8, 8*omega - 7, 8*omega - 6, 8*omega - 5, 8*omega - 4, 8*omega - 3, 8*omega - 2, -4*omega + 1, -8*omega + 3, -7*omega + 1, -7*omega + 2, -7*omega + 3, -7*omega + 4, -7*omega + 5, 4*omega - 9, -7*omega + 7, 4*omega - 7, 4*omega - 6, 4*omega - 5, 4*omega - 4, 4*omega - 3, 4*omega - 2, -8*omega + 6, 4*omega, 4*omega + 1, 4*omega + 2, 4*omega + 3, 4*omega + 4, -8*omega + 7, -8*omega + 8, -4*omega + 5, -8*omega + 9, -8*omega + 10, -9*omega + 5, omega - 2, 10*omega - 9, -9*omega + 7, 9*omega - 10, 7*omega - 10, 7*omega - 9, 7*omega - 8, 7*omega - 7, 7*omega - 6, 7*omega - 5, 7*omega - 4, 7*omega - 3, 7*omega - 2, 5*omega - 9, -omega - 6, -2*omega - 5, -2*omega - 4, -2*omega - 3, -omega - 2, 5*omega - 8, -2*omega, -2*omega + 1, -omega + 2, -omega + 3, -2*omega + 4, -2*omega + 5, -2*omega + 6, -2*omega + 7, -2*omega + 8, omega + 6, 6*omega - 1, 5*omega - 7, 3*omega - 2, -10*omega + 8, -10*omega + 9, -10*omega + 10, 5*omega - 2, -6*omega, -6*omega + 1, -6*omega + 2, -6*omega + 3, -6*omega + 4, -6*omega + 5, -6*omega + 6, -6*omega + 7, -6*omega + 8, -6*omega + 9, -6*omega + 10, -2*omega - 2, 3*omega - 9, 3*omega - 8, 3*omega - 7, 3*omega - 6, 3*omega - 5, 3*omega - 4, 3*omega - 3, 3*omega - 1, 3*omega, 3*omega + 1, 3*omega + 2, 3*omega + 3, 7*omega - 1, -5*omega - 2, 9*omega - 6, -5*omega, -5*omega + 1, -5*omega + 2, -5*omega + 3, -5*omega + 4, -5*omega + 5, -5*omega + 6, -5*omega + 7, -5*omega + 8, -5*omega + 9, -5*omega + 10, -omega - 5, 9*omega - 5, 6*omega - 9, 6*omega - 8, 6*omega - 7, 6*omega - 6, 6*omega - 5, 6*omega - 4, -omega - 4, 6*omega - 2, 6*omega, 6*omega + 1, 10*omega - 10, -9*omega + 6, 10*omega - 8, -9*omega + 8, -9*omega + 9, -9*omega + 10, -omega - 1, -2*omega + 2, 2*omega - 2, -omega, -omega + 1, 2*omega - 8, 2*omega - 7, 2*omega - 6, 2*omega - 5, 2*omega - 4, 2*omega - 3, 2*omega - 1, 2*omega, 2*omega + 1, 2*omega + 2, -2*omega + 3, 2*omega + 4, 2*omega + 5, 6*omega - 10, -3*omega - 1, -omega + 4, 2*omega + 3, -omega + 5, -omega + 6, -omega + 7, 6*omega - 3, -4*omega - 4, -4*omega - 3, -4*omega - 2, 4*omega - 10, -4*omega, -5*omega - 1, -4*omega + 2, -4*omega + 3, -4*omega + 4, -7*omega + 6, -4*omega + 6, -4*omega + 7, -4*omega + 8, -4*omega + 9, -4*omega + 10, 4*omega - 8, -7*omega + 8, -7*omega + 9, -7*omega + 10, -4*omega - 1, 5*omega - 10, 4*omega - 1, -1, -7, -6, -5, -4, -3, -2]\n","done":false}︡{"stdout":"Ring generator: \n","done":false}︡{"stdout":"-1/2*sqrt(5) + 3/2\n","done":false}︡{"stdout":"Minimal polynomial of ring generator: \n","done":false}︡{"stdout":"t^2 - 3*t + 1\n","done":false}︡{"stdout":"Base: \n","done":false}︡{"stdout":"-3*omega - 3 = 3/2*sqrt(5) - 15/2\n","done":false}︡{"stdout":"Minimal polynomial of base:\n","done":false}︡{"stdout":"x^2 + 15*x + 45\n","done":false}︡{"stdout":"Conjugates of base:\n","done":false}︡{"stdout":"[-3/2*sqrt(5) - 15/2, 3/2*sqrt(5) - 15/2]\n","done":false}︡{"stdout":"With absolute values:\n","done":false}︡{"stdout":"[3/2*sqrt(5) + 15/2, -3/2*sqrt(5) + 15/2]\n","done":false}︡{"stdout":"modulo base\n","done":false}︡{"once":false,"done":false,"file":{"show":true,"uuid":"6c2a9117-2aba-4856-9e24-d2e68b20ae6e","filename":"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.sage/temp/compute4-us/25816/tmp_URUe8t.svg"}}︡{"html":"<div align='center'></div>","done":false}︡{"stdout":"modulo base - 1","done":false}︡{"stdout":"\n","done":false}︡{"once":false,"done":false,"file":{"show":true,"uuid":"41b3f10f-40c7-44ef-ab45-f5b7f2553daa","filename":"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.sage/temp/compute4-us/25816/tmp_VlOIZP.svg"}}︡{"html":"<div align='center'></div>","done":false}︡{"stdout":"Quadratic_gen_x^2 - 3*x + 1_automaticAlphabet_-1*omega+(-3)","done":false}︡{"stdout":"\nInicialization...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Numeration system: \n","done":false}︡{"stdout":"Quadratic_gen_x^2 - 3*x + 1_automaticAlphabet_-1*omega+(-3)\n","done":false}︡{"stdout":"Alphabet: \n","done":false}︡{"stdout":"[0, omega + 1, -omega - 1, 1, -1, -omega + 1, omega - 1, omega, -omega, 2*omega + 2, -2*omega - 2, omega + 2, -omega - 2, -2*omega + 2, 2*omega - 2, 2*omega + 1, -2*omega - 1, -2*omega + 1, 2*omega - 1, 2*omega, -2*omega, -2*omega + 3, 2*omega - 3, -3*omega + 3, 3*omega - 3, -3*omega + 1, 3*omega - 1, 3*omega, -3*omega]\n","done":false}︡{"stdout":"Input alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, 3, 4, 5, 3*omega - 1, 5*omega - 2, -6*omega, -6*omega + 1, -6*omega + 2, -6*omega + 3, -6*omega + 4, -6*omega + 6, -2*omega - 2, omega - 5, omega - 4, omega - 3, omega - 1, omega, omega + 1, omega + 2, omega + 3, 3*omega - 4, 5*omega - 6, 5*omega - 5, 5*omega - 4, 5*omega - 3, 5*omega - 1, 5*omega, 5*omega + 1, 5*omega + 2, 3*omega - 3, 3*omega - 2, 3*omega, 3*omega + 1, 3*omega + 2, 3*omega + 3, 3*omega + 4, -4*omega + 1, -2*omega + 5, -3*omega - 4, -3*omega - 3, -3*omega - 2, -3*omega, -3*omega + 1, -3*omega + 2, -3*omega + 3, -5*omega - 2, -5*omega, -5*omega + 1, -5*omega + 2, -5*omega + 3, -5*omega + 4, -5*omega + 5, -5*omega + 6, -3, 6*omega - 6, 6*omega - 4, 6*omega - 3, 6*omega - 2, 6*omega, -omega - 3, -omega - 1, -2*omega + 3, -2*omega - 1, -2*omega + 2, -4*omega - 1, 2*omega - 2, -omega, -omega + 1, 2*omega - 5, 2*omega - 4, 2*omega - 3, 2*omega - 1, 2*omega, 2*omega + 1, 2*omega + 2, 2*omega + 3, 2*omega + 4, -3*omega - 1, -2*omega + 4, -3*omega + 4, 4*omega - 6, 4*omega - 5, 4*omega - 4, 4*omega - 3, 4*omega - 2, 4*omega, 4*omega + 1, 4*omega + 2, 4*omega + 3, 4*omega + 4, -4*omega - 4, -4*omega - 3, -4*omega - 2, -4*omega, -5*omega - 1, -4*omega + 2, -4*omega + 3, -4*omega + 4, -4*omega + 5, -4*omega + 6, omega - 2, -2*omega - 4, -2*omega - 3, -omega - 2, 4*omega - 1, -2*omega, -2*omega + 1, -omega + 2, -omega + 3, -omega + 4, -omega + 5, -1, -5, -4, 6*omega - 1, -2]\n","done":false}︡{"stdout":"Ring generator: \n","done":false}︡{"stdout":"-1/2*sqrt(5) + 3/2\n","done":false}︡{"stdout":"Minimal polynomial of ring generator: \n","done":false}︡{"stdout":"t^2 - 3*t + 1\n","done":false}︡{"stdout":"Base: \n","done":false}︡{"stdout":"-omega - 3 = 1/2*sqrt(5) - 9/2\n","done":false}︡{"stdout":"Minimal polynomial of base:\n","done":false}︡{"stdout":"x^2 + 9*x + 19\n","done":false}︡{"stdout":"Conjugates of base:\n","done":false}︡{"stdout":"[-1/2*sqrt(5) - 9/2, 1/2*sqrt(5) - 9/2]\n","done":false}︡{"stdout":"With absolute values:\n","done":false}︡{"stdout":"[1/2*sqrt(5) + 9/2, -1/2*sqrt(5) + 9/2]\n","done":false}︡{"stdout":"modulo base\n","done":false}︡{"once":false,"done":false,"file":{"show":true,"uuid":"c0535a3a-a3c6-4dd0-8384-80556167487c","filename":"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.sage/temp/compute4-us/25816/tmp_dkIblf.svg"}}︡{"html":"<div align='center'></div>","done":false}︡{"stdout":"modulo base - 1","done":false}︡{"stdout":"\n","done":false}︡{"once":false,"done":false,"file":{"show":true,"uuid":"aaf05001-172f-4029-b80e-90c803403457","filename":"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.sage/temp/compute4-us/25816/tmp_QJt0Jq.svg"}}︡{"html":"<div align='center'></div>","done":false}︡{"done":true}
︠1d112cce-5f6b-406e-ad8d-0a92dcd8f52bs︠


letters='['
for i in range(65, 91)+range(97,123):
    letters+="'"+chr(i)+"'"+','
print letters
︡bd33d5f6-f7ae-4edc-8637-99e7c794e99a︡︡{"stdout":"['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',\n","done":false}︡{"done":true}
︠5770ce54-93ae-4354-a703-45b808fa1631︠









