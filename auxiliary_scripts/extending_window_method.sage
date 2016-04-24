load(sys.argv[1])        #load inputs from file
folder_path='./outputs/'
load_attach_path('./classes')

try:
    methods_phase1
    methods_phase2
except:
    methods_phase1=[3]        #methods in the list are used. If None, default method is used.
    methods_phase2=[14]        #methods in the list are used. If None, default method is used.
    #Cartesian product of lists methods_phase1 and methods_phase2 is computed

load('ewm.sage')         #run extending window method

#-----------Methods Phase 1---------------------------------------
# 1 - chooses the smallest element (the embedding to CC is necessary here)
# 2 - takes first the only possible candidates and then chooses the smallest element (in absolute value, the embedding to CC is necessary here) - dependent on order of digits in alphabet!!!
# 3 - takes first the only possible candidates and then chooses the smallest element in the natural norm  - dependent on order of digits in alphabet!!!
# 4 - weight coefficients set given by bound (norm)
# 5 - weight coefficients set given by bound (abs)
# 6 - takes first the only possible candidates and all in non-covered lists
# 7 == 9, but A+A is taken even if the input alphabet is different
# 8 -  takes first the only possible candidates and then add all smallest elements (absolute value)
# 9 - takes first the only possible candidates and then add all smallest elements (natural norm) (default)

#-----------Methods Phase 2---------------------------------------
# 0 - add the first element in the first shortest list (implementation dependent)
# 1 - find the smallest covering coefficients from the shortest lists (really slow !!!)
# 2 - random from the shortest lists
# 3 - pick element from the shortest lists lexicographically according to coordinates in lattice
# 4 - pick element from the shortest list which is the closest (according to lattice) to rounded center of gravity of points in shortest lists (default)
# 5 - pick element from all resting list which is the closest (according to lattice) to rounded center of gravity of points in all resting lists
# 6 - find the smallest covering coefficients from all resting lists (really slow !!!)
# 7 - pick element from the shortest list which is the closest (in absolute value) to rounded center of gravity of points in shortest lists
# 8 - pick element from the shortest list which is the closest (in absolute value) to center of gravity of points in shortest lists
# 9 - pick element from all resting list which is the closest (in absolute value) to center of gravity of points in all resting lists
# 10 - each value covered separately by the point closest to point of gravity of covering values
# 11 - pick element from the shortest lists which is the smallest (in absolute value)
# 12 - pick element from the shortest lists which is the smallest (beta-norm)
# 13 - pick element from those with highest occurrencies, which is the closest to 0 in beta-norm
# 14 - pick element from those with highest occurrencies, which is the closest to the center of gravity of already added (in absolute value)
# 15 - pick element from the shortest lists which is closest to already added (absolute value)
# 16 - pick element from those with highest occurrencies, which is the closest to center of gravity of already added (in beta norm)
# 17 - pick element from all resting which is the closest (in beta norm) to the center of gravity of already
# 18 - pick element according to covering by alphabets
# 19 - pick more elements according to covering by alphabets
# 20 - another way to pick an element according to covering by alphabets
