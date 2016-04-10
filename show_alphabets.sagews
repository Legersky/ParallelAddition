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

first_col=worksheet.col_values(1)
row=1
for r in first_col:
    try:
        if r=='b':
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
    row+=1
︡855328f5-4cc6-4468-accd-73fe260deb20︡︡{"stdout":"Quadratic_1+4+5_A2_var01"}︡{"stdout":"\nInicialization..."}︡{"stdout":"\n"}︡{"stdout":"Numeration system: \n"}︡{"stdout":"Quadratic_1+4+5_A2_var01\n"}︡{"stdout":"Alphabet: \n"}︡{"stdout":"[omega + 2, omega + 1, omega, omega - 1, 1, 0, -1, -omega + 1, -omega, -omega - 1]\n"}︡{"stdout":"Input alphabet: \n"}︡{"stdout":"[0, 1, 2, 3, 2*omega - 1, omega - 1, -omega, -omega + 1, -omega + 2, 2*omega - 2, 2*omega, 2*omega + 1, 2*omega + 2, 2*omega + 3, 2*omega + 4, omega - 2, omega, omega + 1, omega + 2, omega + 3, -omega - 2, -2*omega - 2, -2*omega, -2*omega + 1, -2*omega + 2, -1, -2*omega - 1, -omega - 1, -2]\n"}︡{"stdout":"Ring generator: \n"}︡{"stdout":"I\n"}︡{"stdout":"Minimal polynomial of ring generator: \n"}︡{"stdout":"t^2 + 1\n"}︡{"stdout":"Base: \n"}︡{"stdout":"omega - 2 = I - 2\n"}︡{"stdout":"Minimal polynomial of base:\n"}︡{"stdout":"x^2 + 4*x + 5\n"}︡{"stdout":"Conjugates of base:\n"}︡{"stdout":"[-I - 2, I - 2]\n"}︡{"stdout":"With absolute values:\n"}︡{"stdout":"[sqrt(5), sqrt(5)]\n"}︡{"stdout":"modulo base\n"}︡{"file":{"filename":"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.sage/temp/compute4-us/27869/tmp_d5S736.svg","show":true,"uuid":"aaaeb253-ab56-4b45-a43d-7f70e518ad5e"},"once":false}︡{"html":"<div align='center'></div>"}︡{"stdout":"modulo base - 1"}︡{"stdout":"\n"}︡{"file":{"filename":"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.sage/temp/compute4-us/27869/tmp_VdIRS_.svg","show":true,"uuid":"d07deff5-15bf-4b31-8abf-7f42546ef294"},"once":false}︡{"html":"<div align='center'></div>"}︡{"stdout":"Quadratic_1+4+5_1-block_complex_10-digits_var04"}︡{"stdout":"\nInicialization..."}︡{"stdout":"\n"}︡{"stdout":"Numeration system: \n"}︡{"stdout":"Quadratic_1+4+5_1-block_complex_10-digits_var04\n"}︡{"stdout":"Alphabet: \n"}︡{"stdout":"[omega + 2, omega + 1, omega, 2, 1, 0, -1, -omega + 1, -omega, -omega - 1]\n"}︡{"stdout":"Input alphabet: \n"}︡{"stdout":"[0, 1, 2, 3, 4, -omega, -omega + 1, -omega + 2, 2*omega, 2*omega + 1, 2*omega + 2, 2*omega + 3, 2*omega + 4, omega - 1, omega, omega + 1, omega + 2, omega + 3, omega + 4, -omega - 2, -2*omega - 2, -2*omega, -2*omega + 1, -2*omega + 2, -omega + 3, -1, -2*omega - 1, -omega - 1, -2]\n"}︡{"stdout":"Ring generator: \n"}︡{"stdout":"I\n"}︡{"stdout":"Minimal polynomial of ring generator: \n"}︡{"stdout":"t^2 + 1\n"}︡{"stdout":"Base: \n"}︡{"stdout":"omega - 2 = I - 2\n"}︡{"stdout":"Minimal polynomial of base:\n"}︡{"stdout":"x^2 + 4*x + 5\n"}︡{"stdout":"Conjugates of base:\n"}︡{"stdout":"[-I - 2, I - 2]\n"}︡{"stdout":"With absolute values:\n"}︡{"stdout":"[sqrt(5), sqrt(5)]\n"}︡{"stdout":"modulo base\n"}︡{"file":{"filename":"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.sage/temp/compute4-us/27869/tmp_JMb7Ol.svg","show":true,"uuid":"118aba98-c0f0-4dd7-b36b-f1db4fb811ba"},"once":false}︡{"html":"<div align='center'></div>"}︡{"stdout":"modulo base - 1"}︡{"stdout":"\n"}︡{"file":{"filename":"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.sage/temp/compute4-us/27869/tmp_NYn44W.svg","show":true,"uuid":"d49d5c85-e960-43c3-8c57-7511b3633298"},"once":false}︡{"html":"<div align='center'></div>"}︡{"stdout":"Quadratic_1+4+5_1-block_complex_10-digits_var04"}︡{"stdout":"\nInicialization..."}︡{"stdout":"\n"}︡{"stdout":"Numeration system: \n"}︡{"stdout":"Quadratic_1+4+5_1-block_complex_10-digits_var04\n"}︡{"stdout":"Alphabet: \n"}︡{"stdout":"[1, 0, -1, -omega, omega + 2, omega + 1, omega, 2, -omega + 1, -omega - 1]\n"}︡{"stdout":"Input alphabet: \n"}︡{"stdout":"[0, 1, 2, 3, 4, -omega, -omega + 1, -omega + 2, 2*omega, 2*omega + 1, 2*omega + 2, 2*omega + 3, 2*omega + 4, omega - 1, omega, omega + 1, omega + 2, omega + 3, omega + 4, -omega - 2, -2*omega - 2, -2*omega, -2*omega + 1, -2*omega + 2, -omega + 3, -1, -2*omega - 1, -omega - 1, -2]\n"}︡{"stdout":"Ring generator: \n"}︡{"stdout":"I\n"}︡{"stdout":"Minimal polynomial of ring generator: \n"}︡{"stdout":"t^2 + 1\n"}︡{"stdout":"Base: \n"}︡{"stdout":"omega - 2 = I - 2\n"}︡{"stdout":"Minimal polynomial of base:\n"}︡{"stdout":"x^2 + 4*x + 5\n"}︡{"stdout":"Conjugates of base:\n"}︡{"stdout":"[-I - 2, I - 2]\n"}︡{"stdout":"With absolute values:\n"}︡{"stdout":"[sqrt(5), sqrt(5)]\n"}︡{"stdout":"modulo base\n"}︡{"file":{"filename":"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.sage/temp/compute4-us/27869/tmp_hvSVec.svg","show":true,"uuid":"764a46ef-0eeb-4ba9-ad4e-00768c86524b"},"once":false}︡{"html":"<div align='center'></div>"}︡{"stdout":"modulo base - 1"}︡{"stdout":"\n"}︡{"file":{"filename":"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.sage/temp/compute4-us/27869/tmp_vcwghw.svg","show":true,"uuid":"0ad5b762-3363-40f9-a55e-c5ea61c8eb48"},"once":false}︡{"html":"<div align='center'></div>"}︡{"done":true}
︠1d112cce-5f6b-406e-ad8d-0a92dcd8f52bs︠


letters='['
for i in range(65, 91)+range(97,123):
    letters+="'"+chr(i)+"'"+','
print letters
︡bd33d5f6-f7ae-4edc-8637-99e7c794e99a︡︡{"stdout":"['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',\n","done":false}︡{"done":true}
︠5770ce54-93ae-4354-a703-45b808fa1631︠









