︠d036622f-9a67-4df9-a2ac-e69ebcf258a9︠
#------------INPUTS---------------------
#Name of the numeration system
name = 'Eisenstein_1-block_complex'
#Minimal polynomial of ring generator (use variable x)
minPol ='x^2 + x + 1'
#Embedding (the closest root of the minimal polynomial to this value is taken as the ring generator)
omegaCC= -0.5 + 0.8*I
#Alphabet (use 'omega' as ring generator)
alphabet = '' #'[0, 1, -1, omega, -omega, -omega - 1, omega + 1]'
#Input alphabet (if empty, A + A is used)
inputAlphabet = ''
#Base (use 'omega' as ring generator)
base ='omega - 1'

#------------EWM SETTING----------------
max_iterations = 20      #maximum of iterations in searching for the weight coefficient set
methods_phase1=[3]        #methods in the list are used. If empty, default method is used.
max_input_length = 10    #maximal length of the input of the weight function
methods_phase2=[13]        #methods in the list are used. If empty, default method is used.
#Cartesian product of lists methods_phase1 and methods_phase2 is computed

#------------SANITY CHECK---------------
sanityCheck=False         #run sanity check

#------------SAVING---------------------
info=True                #save general info to .tex file
WFcsv=False              #save weight function to .csv file
localConversionCsv=False #save local conversion to .csv file
saveSetting=False        #save inputs setting as a dictionary
saveLog=True             #save log file
saveUnsolved=False       #save unsolved combinations after interruption

#------------IMAGES--------------------
alphabet_img=False        #save image of alphabet and input alphabet
lattice_img=False         #save image of lattice with shifted alphabet
phase1_images=False       #save step-by-step images of phase 1
weightCoefSet_img=False   #save image of the weight coefficient set
#with estimation given by lemma:
estimation=False
phase2_images=False       #save step-by-step images of phase 2
#for input:
phase2_input='(omega,1,omega,1,omega,1,omega,1)'


load_attach_path('~')

load_attach_path('/home/legerjan/ParallelAddition')
load_attach_path('/home/legerjan/ParallelAddition/classes')

folder_path='./'
load('ewm.sage')
︡d2f73123-a6fe-469f-a118-6d8f89aa2497︡{"done":false,"stderr":"<string>:185: DeprecationWarning: CartesianProduct is deprecated. Use cartesian_product instead\nSee http://trac.sagemath.org/18411 for details.\n"}︡{"stdout":"Inicialization...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Numeration system: \n","done":false}︡{"stdout":"Eisenstein_1-block_complex\n","done":false}︡{"stdout":"Alphabet: \n","done":false}︡{"stdout":"[0, -omega - 1, omega + 1, -1, 1, -omega, omega]\n","done":false}︡{"stdout":"Input alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -2*omega - 2, -2*omega - 1, -2*omega, -omega + 1, -1, -omega - 2, -omega - 1, -2]\n","done":false}︡{"stdout":"Ring generator: \n","done":false}︡{"stdout":"1/2*I*sqrt(3) - 1/2\n","done":false}︡{"stdout":"Minimal polynomial of ring generator: \n","done":false}︡{"stdout":"t^2 + t + 1\n","done":false}︡{"stdout":"Base: \n","done":false}︡{"stdout":"omega - 1 = 1/2*I*sqrt(3) - 3/2\n","done":false}︡{"stdout":"Minimal polynomial of base:\n","done":false}︡{"stdout":"x^2 + 3*x + 3\n","done":false}︡{"stdout":"Conjugates of base:\n","done":false}︡{"stdout":"[-1/2*I*sqrt(3) - 3/2, 1/2*I*sqrt(3) - 3/2]\n","done":false}︡{"stdout":"With absolute values:\n","done":false}︡{"stdout":"[sqrt(3), sqrt(3)]\n","done":false}︡{"stdout":" \nMaximum iterations: 20\n","done":false}︡{"stdout":"Maximum length of input of weight function: 10\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base:\n","done":false}︡{"stdout":"Number of congruence classes mod base is: 3\n","done":false}︡{"stdout":"Alphabet divided into congruence classes:\n","done":false}︡{"stdout":"[[0], [-omega - 1, 1, omega], [omega + 1, -1, -omega]]\n","done":false}︡{"stdout":"=> There are all representatives mod base in the alphabet.\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base-1:\n","done":false}︡{"stdout":"Number of congruence classes mod base - 1 is: 7\n","done":false}︡{"stdout":"There are all elements of the input alphabet mod base-1 in the alphabet.","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Phase 1 - Searching for the Weight Coefficient Set using method 3...\n","done":false}︡{"stdout":"Starting Q_0:\n","done":false}︡{"stdout":"[0]\n","done":false}︡{"stdout":"Number of elements in Qk: 1\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-omega, 1, -omega - 1, -1, omega + 1, omega]\n","done":false}︡{"stdout":"Number of elements in Qk: 7","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-omega - 2, 2*omega + 1, omega - 1, -omega + 1, -2*omega - 1, omega + 2]\n","done":false}︡{"stdout":"Number of elements in Qk: 13","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[2*omega, 2, -2*omega - 2, 2*omega + 2, -2*omega, -2]\n","done":false}︡{"stdout":"Number of elements in Qk: 19","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[]\n","done":false}︡{"stdout":"The Weight Coefficient Set is:\n","done":false}︡{"stdout":"[0, 1, 2, -omega, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, -omega - 1, -omega - 2, -2*omega, -omega + 1, -1, -2*omega - 2, -2*omega - 1, -2]\n","done":false}︡{"stdout":"Number of elements: 19\n","done":false}︡{"stdout":"Phase 2 is starting...\n","done":false}︡{"stdout":"Checking one letter inputs...\n","done":false}︡{"stdout":"The longest inputs are:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[(1, 1, 1), (2, 2, 2), (-omega, -omega, -omega), (2*omega, 2*omega, 2*omega), (2*omega + 1, 2*omega + 1, 2*omega + 1), (2*omega + 2, 2*omega + 2, 2*omega + 2), (omega - 1, omega - 1, omega - 1), (omega, omega, omega), (omega + 1, omega + 1, omega + 1), (omega + 2, omega + 2, omega + 2), (-2*omega - 2, -2*omega - 2, -2*omega - 2), (-2*omega - 1, -2*omega - 1, -2*omega - 1), (-2*omega, -2*omega, -2*omega), (-omega + 1, -omega + 1, -omega + 1), (-1, -1, -1), (-omega - 2, -omega - 2, -omega - 2), (-omega - 1, -omega - 1, -omega - 1), (-2, -2, -2)]\n","done":false}︡{"stdout":"Length of one letter input: 3: \n","done":false}︡{"stdout":"Number of letters with longest input: 18\n","done":false}︡{"stdout":"Searching the Weight Function using method 13...\n","done":false}︡{"stdout":"Length of the window: 1, Number of saved combinations of input digits: 0, To next iteration: 19","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 2, Number of saved combinations of input digits: 43, To next iteration: 318","done":false}︡{"stdout":"\n","done":false}︡︡{"stdout":"Length of the window: 2, Number of saved combinations of input digits: 43, To next iteration: 318","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 3, Number of saved combinations of input digits: 6042, To next iteration: 0","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Info about Weight Function:\n","done":false}︡{"stdout":"Maximal input length: 3\n","done":false}︡{"stdout":"Number of inputs: 6085\n","done":false}︡{"stdout":"Output of weight function for the input 0,0,...,0: 0\n","done":false}︡{"stdout":"All elements of the weight coefficient set are used.\n","done":false}︡{"stdout":"\n\nSaving...\n","done":false}︡{"stdout":"Elapsed time: 41.258939\n","done":false}︡{"stdout":"Some problem with saving to google spreadsheet:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[Errno 99] Cannot assign requested address\n","done":false}︡{"stdout":"The following row can be saved to google spreadsheet ParallelAddition_results\n","done":false}︡{"stdout":"2016-02-17 18:37; Eisenstein_1-block_complex; [0, -omega - 1, omega + 1, -1, 1, -omega, omega]; A+A; 1/2*I*sqrt(3) - 1/2; t^2 + t + 1; omega - 1 = 1/2*I*sqrt(3) - 3/2; x^2 + 3*x + 3; [-1/2*I*sqrt(3) - 3/2, 1/2*I*sqrt(3) - 3/2]; [sqrt(3), sqrt(3)]; [[0], [-omega - 1, 1, omega], [omega + 1, -1, -omega]]; []; [[0], [-omega - 1], [omega + 1], [-1], [1], [-omega], [omega]]; []; yes; 3; OK; 19; [1, 7, 13, 19]; 13; OK; 3; OK; 3; [0, 43, 6042]; []; 41.258939; successfull; ; \n","done":false}︡{"stdout":"Info about algorithm for parallel addition saved to ./Eisenstein_1-block_complex/methods_3-13/Eisenstein_1-block_complex.tex","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Log saved to ./Eisenstein_1-block_complex/methods_3-13/Eisenstein_1-block_complex_log.txt\n","done":false}︡{"stdout":"--------------------------end of Eisenstein_1-block_complex---------------------------------------------\n","done":false}︡{"done":true}
︠a39a0b4a-1ee1-49ac-b794-89d88a61f468s︠

import json
import gspread         #https://gspread.readthedocs.org/en/latest/#gspread.Spreadsheet.add_worksheet
import warnings

from oauth2client.client import SignedJwtAssertionCredentials


try:
    json_key = json.load(open('vysledkyParallel-b1ae50e4c6ea.json'))
except Exception, e:
    json_key = json.load(open('/home/legerjan/ParallelAddition/vysledkyParallel-b1ae50e4c6ea.json'))

scope = ['https://spreadsheets.google.com/feeds']

credentials = SignedJwtAssertionCredentials(json_key['client_email'], json_key['private_key'].encode(), scope)

gc = gspread.authorize(credentials)


sheet=gc.open("ParallelAddition_results")

worksheet=sheet.worksheet(_worksheet)

worksheet.append_row(row)
︡bb85087e-e5ca-4268-b036-fe88000be4fb︡︡{"done":false,"stderr":"/projects/sage/sage-6.10/local/lib/python2.7/site-packages/Crypto/Util/number.py:57: PowmInsecureWarning: Not using mpz_powm_sec.  You should rebuild using libgmp >= 5 to avoid timing attack vulnerability.\n  _warn(\"Not using mpz_powm_sec.  You should rebuild using libgmp >= 5 to avoid timing attack vulnerability.\", PowmInsecureWarning)\n"}︡{"done":false,"stderr":"Error in lines 14-14\n"}︡{"done":false,"stderr":"Traceback (most recent call last):\n  File \"/projects/sage/sage-6.10/local/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 905, in execute\n    exec compile(block+'\\n', '', 'single') in namespace, locals\n  File \"\", line 1, in <module>\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/gspread/client.py\", line 335, in authorize\n    client.login()\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/gspread/client.py\", line 98, in login\n    self.auth.refresh(http)\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/oauth2client/client.py\", line 626, in refresh\n    self._refresh(http.request)\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/oauth2client/client.py\", line 835, in _refresh\n    self._do_refresh_request(http_request)\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/oauth2client/client.py\", line 867, in _do_refresh_request\n    self.token_uri, method='POST', body=body, headers=headers)\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/httplib2/__init__.py\", line 1609, in request\n    (response, content) = self._request(conn, authority, uri, request_uri, method, body, headers, redirections, cachekey)\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/httplib2/__init__.py\", line 1351, in _request\n    (response, content) = self._conn_request(conn, request_uri, method, body, headers)\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/httplib2/__init__.py\", line 1272, in _conn_request\n    conn.connect()\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/httplib2/__init__.py\", line 1075, in connect\n    raise socket.error, msg\nerror: [Errno 99] Cannot assign requested address\n"}︡{"done":true}︡{"done":false,"stderr":"Error in lines 11-11\n"}︡{"done":false,"stderr":"Traceback (most recent call last):\n  File \"/projects/sage/sage-6.10/local/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 905, in execute\n    exec compile(block+'\\n', '', 'single') in namespace, locals\n  File \"\", line 1, in <module>\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/gspread/client.py\", line 335, in authorize\n    client.login()\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/gspread/client.py\", line 98, in login\n    self.auth.refresh(http)\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/oauth2client/client.py\", line 626, in refresh\n    self._refresh(http.request)\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/oauth2client/client.py\", line 835, in _refresh\n    self._do_refresh_request(http_request)\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/oauth2client/client.py\", line 867, in _do_refresh_request\n    self.token_uri, method='POST', body=body, headers=headers)\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/httplib2/__init__.py\", line 1609, in request\n    (response, content) = self._request(conn, authority, uri, request_uri, method, body, headers, redirections, cachekey)\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/httplib2/__init__.py\", line 1351, in _request\n    (response, content) = self._conn_request(conn, request_uri, method, body, headers)\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/httplib2/__init__.py\", line 1272, in _conn_request\n    conn.connect()\n  File \"/projects/583d857d-54f0-48f2-9377-fb66dca7659a/.local/lib/python2.7/site-packages/httplib2/__init__.py\", line 1075, in connect\n    raise socket.error, msg\nerror: [Errno 99] Cannot assign requested address\n"}︡{"done":true}
︠85373ed2-c4f9-4801-85db-17847add659a︠









