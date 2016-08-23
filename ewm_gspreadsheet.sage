# This script loads inputs from the list 'inputs' of google spreadsheet
# https://docs.google.com/spreadsheets/d/1TnhrHdefHfHa0WSeVs4q6XVj3epjPlPlnoekE0E1xeM/edit#gid=209657865

# Methods for Phase 1, resp. 2, are given by a list in the cell C1, resp. C2
# Values in the columns 'Name', 'Alphabet',	'Input alphabet', 'Ring generator',	'Minimal polynomial of generator omega' and 'Base'
# must be filled for the tested rows

compareWith=['kblock']    #if some of these values is found in column A, the correspondig row will be tested
general_note='my own note'

# Do not change order of rows in the  list 'inputs' when processing!


onlyComparePhase1=False     #if True, then comparing of methods for Phase 1 given in the cell C1 is run without Phase 2.

# !!DO NOT CHANGE!!
load_attach_path('~')
load_attach_path('/home/legerjan/ParallelAddition')
load_attach_path('/home/legerjan/ParallelAddition/classes')

load('run_gspreadsheet.sage')

