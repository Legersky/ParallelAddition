load(sys.argv[1])        #load inputs from file
folder_path='./outputs/'
load_attach_path('./classes')

try:
    methods_phase1
    methods_phase2
except:
    methods_phase1=[4]        #methods in the list are used. If None, default method is used.
    methods_phase2=[]        #methods in the list are used. If None, default method is used.
    #Cartesian product of lists methods_phase1 and methods_phase2 is computed

load('ewm.sage')         #run extending window method
