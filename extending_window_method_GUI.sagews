︠cedec87d-8bcc-4a51-bf6b-a86f2c11e248︠
#---------------------------------EXTENDING WINDOW METHOD---------------------------------
#---------------------evaluate this cell (SHIFT + ENTER) to start GUI---------------------
load('interact_ewm.sage')
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

︡bf5b1b0d-ec7e-4a42-8e9f-e1a6d6bcb03e︡
︠d564c6d0-8302-4ac8-b001-33781909b93ai︠
︡a860dfb1-0363-430e-bf36-f4bfdb810a29︡














