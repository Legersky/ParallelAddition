︠d036622f-9a67-4df9-a2ac-e69ebcf258a9s︠
#------------INPUTS---------------------
#Name of the numeration system
name = 'x^2 + x + 2_automaticAlphabet'
#Minimal polynomial of ring generator (use variable x)
minPol ='x^2 + x + 2'
#Embedding (the closest root of the minimal polynomial to this value is taken as the ring generator)
omegaCC= I
#Alphabet (use 'omega' as ring generator)
alphabet = ''
#Input alphabet (if empty, A + A is used)
inputAlphabet = ''
#Base (use 'omega' as ring generator)
base ='omega'

#------------EWM SETTING----------------
max_iterations = 20      #maximum of iterations in searching for the weight coefficient set
methods_phase1=[3]        #methods in the list are used. If empty, default method is used.
max_input_length = 10    #maximal length of the input of the weight function
methods_phase2=[16]        #methods in the list are used. If empty, default method is used.
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

folder_path='./outputs/'
load('ewm.sage')
︡ffccf83d-e4d2-4d86-9912-87842889a785︡︡{"stdout":"Inicialization...","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Numeration system: \n","done":false}︡{"stdout":"x^2 + x + 2_automaticAlphabet\n","done":false}︡{"stdout":"Alphabet: \n","done":false}︡{"stdout":"[0, omega + 1, 1, -1]\n","done":false}︡{"stdout":"Input alphabet: \n","done":false}︡{"stdout":"[0, 1, 2, omega, omega + 1, omega + 2, -1, 2*omega + 2, -2]\n","done":false}︡{"stdout":"Ring generator: \n","done":false}︡{"stdout":"1/2*I*sqrt(7) - 1/2\n","done":false}︡{"stdout":"Minimal polynomial of ring generator: \n","done":false}︡{"stdout":"t^2 + t + 2\n","done":false}︡{"stdout":"Base: \n","done":false}︡{"stdout":"omega = 1/2*I*sqrt(7) - 1/2\n","done":false}︡{"stdout":"Minimal polynomial of base:\n","done":false}︡{"stdout":"x^2 + x + 2\n","done":false}︡{"stdout":"Conjugates of base:\n","done":false}︡{"stdout":"[-1/2*I*sqrt(7) - 1/2, 1/2*I*sqrt(7) - 1/2]\n","done":false}︡{"stdout":"With absolute values:\n","done":false}︡{"stdout":"[sqrt(2), sqrt(2)]\n","done":false}︡{"stdout":" \nMaximum iterations: 20\n","done":false}︡{"stdout":"Maximum length of input of weight function: 10\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base:\n","done":false}︡{"stdout":"Number of congruence classes mod base is: 2\n","done":false}︡{"stdout":"Alphabet divided into congruence classes:\n","done":false}︡{"stdout":"[[0], [omega + 1, 1, -1]]\n","done":false}︡{"stdout":"=> There are all representatives mod base in the alphabet.\n","done":false}︡{"stdout":"Checking alphabet for representatives mod base-1:\n","done":false}︡{"stdout":"Number of congruence classes mod base - 1 is: 4\n","done":false}︡{"stdout":"There are all elements of the input alphabet mod base-1 in the alphabet.\n","done":false}︡{"stdout":"Phase 1 - Searching for the Weight Coefficient Set using method 3...\n","done":false}︡{"stdout":"Starting Q_0:\n","done":false}︡{"stdout":"[0]\n","done":false}︡{"stdout":"Number of elements in Qk: 1","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-omega - 1, 1, -omega, -omega + 1, omega + 1]\n","done":false}︡{"stdout":"Number of elements in Qk: 6\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-1, -omega - 2, omega]\n","done":false}︡{"stdout":"Number of elements in Qk: 9","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[2, omega + 2, 2*omega + 1, -omega + 2]\n","done":false}︡{"stdout":"Number of elements in Qk: 13\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-2*omega - 2, -2*omega - 1, -2*omega - 3, -2*omega + 1, -2*omega]\n","done":false}︡{"stdout":"Number of elements in Qk: 18","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[2*omega, -2, -omega - 3, omega - 1]\n","done":false}︡{"stdout":"Number of elements in Qk: 22","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[3, omega + 3, 2*omega + 2, -omega + 3]\n","done":false}︡{"stdout":"Number of elements in Qk: 26","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-2*omega + 2]\n","done":false}︡{"stdout":"Number of elements in Qk: 27","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[-2*omega - 4]\n","done":false}︡{"stdout":"Number of elements in Qk: 28","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[3*omega + 1]\n","done":false}︡{"stdout":"Number of elements in Qk: 29","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Added coefficients:\n","done":false}︡{"stdout":"[]\n","done":false}︡{"stdout":"The Weight Coefficient Set is:\n","done":false}︡{"stdout":"[0, 1, 2, 3, -2*omega, -2*omega + 1, -2*omega - 2, -2*omega + 2, 2*omega, 2*omega + 1, 2*omega + 2, omega - 1, omega, omega + 1, omega + 2, omega + 3, -2*omega - 4, -2*omega - 3, -2*omega - 1, -omega, -omega + 1, -omega + 2, -omega + 3, -2, 3*omega + 1, -omega - 3, -omega - 2, -omega - 1, -1]\n","done":false}︡{"stdout":"Number of elements: 29\n","done":false}︡{"stdout":"Phase 2 is starting...\n","done":false}︡{"stdout":"Checking one letter inputs...\n","done":false}︡{"stdout":"The longest inputs are:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"[(1, 1, 1, 1, 1, 1), (omega + 1, omega + 1, omega + 1, omega + 1, omega + 1, omega + 1)]\n","done":false}︡{"stdout":"Length of one letter input: 6: \n","done":false}︡{"stdout":"Number of letters with longest input: 2\n","done":false}︡{"stdout":"Searching the Weight Function using method 16...\n","done":false}︡{"stdout":"Length of the window: 1, Number of saved combinations of input digits: 0, To next iteration: 9","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 2, Number of saved combinations of input digits: 0, To next iteration: 81","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 3, Number of saved combinations of input digits: 0, To next iteration: 729","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 4, Number of saved combinations of input digits: 0, To next iteration: 6561","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 5, Number of saved combinations of input digits: 43431, To next iteration: 15618","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 6, Number of saved combinations of input digits: 126069, To next iteration: 14493","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 7, Number of saved combinations of input digits: 126882, To next iteration: 3555","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Length of the window: 8, Number of saved combinations of input digits: 31995, To next iteration: 0","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Info about Weight Function:\n","done":false}︡{"stdout":"Maximal input length: 8\n","done":false}︡{"stdout":"Number of inputs: 328377","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"Output of weight function for the input 0,0,...,0: 0\n","done":false}︡{"stdout":"All elements of the weight coefficient set are used.","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"\n\nSaving...\n","done":false}︡{"stdout":"Elapsed time: 1388.717353\n","done":false}︡{"stdout":"Some problem with saving to google spreadsheet:","done":false}︡{"stdout":"\n","done":false}︡{"stdout":"500: <!DOCTYPE html><html lang=\"en\" ><head><meta name=\"description\" content=\"Web word processing, presentations and spreadsheets\"><link rel=\"shortcut icon\" href=\"//ssl.gstatic.com/docs/common/drive_favicon1.ico\"><title>Google Drive Error</title><link href=\"//fonts.googleapis.com/css?family=Product+Sans\" rel=\"stylesheet\" type=\"text/css\"><style>/* Copyright 2016 Google Inc. All Rights Reserved. */\n.goog-inline-block{position:relative;display:-moz-inline-box;display:inline-block}* html .goog-inline-block{display:inline}*:first-child+html .goog-inline-block{display:inline}#drive-logo{margin:18px 0;position:absolute;white-space:nowrap}.docs-drivelogo-img{background-image:url('//ssl.gstatic.com/images/branding/googlelogo/1x/googlelogo_color_116x41dp.png');background-size:116px 41px;display:inline-block;height:41px;vertical-align:bottom;width:116px}.docs-drivelogo-text{color:#000;display:inline-block;opacity:0.54;text-decoration:none;font-family:'Product Sans',Arial,Helvetica,sans-serif;font-size:32px;text-rendering:optimizeLegibility;position:relative;top:-6px;left:-7px;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale}@media (-webkit-min-device-pixel-ratio:1.5),(min-resolution:144dpi){.docs-drivelogo-img{background-image:url('//ssl.gstatic.com/images/branding/googlelogo/2x/googlelogo_color_116x41dp.png')}}</style><style type=\"text/css\">body {background-color: #fff; font-family: Arial,sans-serif; font-size: 13px; margin: 0; padding: 0;}a, a:link, a:visited {color: #112ABB;}</style><style type=\"text/css\">.errorMessage {font-size: 12pt; font-weight: bold; line-height: 150%;}</style></head><body><div style=\"margin: auto; max-width: 750px;\"><div style=\"margin: 80px 40px 20px 40px; position:relative; \"><div style=\"position: absolute; top: -80px;\"><div id=\"drive-logo\"><a href=\"/\"><span class=\"docs-drivelogo-img\" title=\"Google logo\"></span><span class=\"docs-drivelogo-text\">&nbsp;Drive</span></a></div></div><p style=\"padding-top: 15px\">Google Docs encountered an error. Please try reloading this page, or coming back to it in a few minutes.</p><p>To learn more about the Google Docs editors, please visit our <a href=\"https://support.google.com/docs/?hl=en&p=error_help\" target=\"_blank\">help center</a>.</p><p><br><b>We're sorry for the inconvenience.</b><br><i>- The Google Docs Team</i></p></div></div></body></html>\n","done":false}︡{"stdout":"The following row can be saved to google spreadsheet ParallelAddition_results\n","done":false}︡{"stdout":"2016-02-24 15:45; x^2 + x + 2_automaticAlphabet; [0, omega + 1, 1, -1]; A+A; 1/2*I*sqrt(7) - 1/2; t^2 + t + 2; omega = 1/2*I*sqrt(7) - 1/2; x^2 + x + 2; [-1/2*I*sqrt(7) - 1/2, 1/2*I*sqrt(7) - 1/2]; [sqrt(2), sqrt(2)]; [[0], [omega + 1, 1, -1]]; []; [[0], [omega + 1], [1], [-1]]; []; yes; 3; OK; 29; [1, 6, 9, 13, 18, 22, 26, 27, 28, 29]; 16; OK; 6; OK; 8; [0, 0, 0, 0, 43431, 126069, 126882, 31995]; []; 1388.717353; successfull; ; \n","done":false}︡{"stdout":"Info about algorithm for parallel addition saved to ./outputs/x^2 + x + 2_automaticAlphabet/methods_3-16/x^2 + x + 2_automaticAlphabet.tex\n","done":false}︡{"stdout":"Log saved to ./outputs/x^2 + x + 2_automaticAlphabet/methods_3-16/x^2 + x + 2_automaticAlphabet_log.txt\n","done":false}︡{"stdout":"--------------------------end of x^2 + x + 2_automaticAlphabet---------------------------------------------\n","done":false}︡{"done":true}
︠6b4ccdb8-15c4-43db-af9a-9380a8cc0703︠

















