︠72ce4c3e-3dac-41d9-834b-b821993e0203s︠
path='../classes/WeightFunctionSearch.sage'

import re

f = open(path,'r')
s=' '
while s:
    t = f.readline()
    s=t.replace('_','\\_')
    if '#---' in s:
        print s[1:]
    if ' def ' in s:
        print '\\begin{method}{'+ s[s.find("def ")+4:s.find("(")] +'}{'+ s[s.find("self")+5:s.find(")")] + '}'
        print ''
        print '\\end{method}'
        print ''
        print ''
f.close()
︡3e57df4b-082c-4334-93bf-9912321b1e1c︡︡{"stdout":"-----------------------------CONSTRUCTOR, SETTERS-------------------------------------------------------------------\n\n\\begin{method}{\\_\\_init\\_\\_}{ algForParallelAdd, weightCoefSet, method,maxInputs}\n\n\\end{method}\n\n\n\\begin{method}{\\_\\_repr\\_\\_}{}\n\n\\end{method}\n\n\n-----------------------------SEARCH FOR WEIGHT FUNCTION-------------------------------------------------------------------\n\n\\begin{method}{\\_find\\_weightCoef\\_for\\_comb\\_B}{ combinations}\n\n\\end{method}\n\n\n\\begin{method}{\\_findQw}{w\\_tuple}\n\n\\end{method}\n\n\n\\begin{method}{\\_checkCycles}{ w\\_tuple}\n\n\\end{method}\n\n\n\\begin{method}{isSublist}{    def isSublist(\\_list, \\_sublist}\n\n\\end{method}\n\n\n\\begin{method}{find\\_next\\_letter}{    def find\\_next\\_letter(\\_w,witness\\_seq}\n\n\\end{method}\n\n\n\\begin{method}{\\_addNondecreasingTuple}{w}\n\n\\end{method}\n\n\n\\begin{method}{\\_findQw\\_once}{w\\_tuple,Qw\\_prev}\n\n\\end{method}\n\n\n\\begin{method}{findWeightFunction}{ max\\_input\\_length}\n\n\\end{method}\n\n\n\\begin{method}{check\\_one\\_letter\\_inputs}{ max\\_input\\_length}\n\n\\end{method}\n\n\n\\begin{method}{\\_pick\\_element}{elements}\n\n\\end{method}\n\n\n\\begin{method}{\\_pick\\_element\\_close\\_PoG\\_by\\_lattice}{elements, PoG}\n\n\\end{method}\n\n\n\\begin{method}{\\_pick\\_element\\_close\\_PoG}{elements, PoG}\n\n\\end{method}\n\n\n\\begin{method}{\\_pick\\_element\\_close\\_PoG\\_CC}{elements}\n\n\\end{method}\n\n\n\\begin{method}{\\_pick\\_element\\_closest\\_to\\_point}{elements, point}\n\n\\end{method}\n\n\n\\begin{method}{\\_pick\\_element\\_closest\\_to\\_point\\_betaNorm}{elements, point}\n\n\\end{method}\n\n\n-----------------------------PRINT FUNCTION-------------------------------------------------------------\n\n\\begin{method}{printCsvQww}{}\n\n\\end{method}\n\n\n\\begin{method}{point\\_of\\_gravity}{ numbers}\n\n\\end{method}\n\n\n\\begin{method}{point\\_of\\_gravity\\_Qomega}{ numbers}\n\n\\end{method}\n\n\n\\begin{method}{point\\_of\\_gravity\\_CC}{ numbers}\n\n\\end{method}\n\n\n\\begin{method}{\\_minimalCovering}{ sets\\_to\\_cover}\n\n\\end{method}\n\n\n\\begin{method}{opravy}{ w\\_tuple}\n\n\\end{method}\n\n\n\\begin{method}{convex}{ w\\_tuple, Qww}\n\n\\end{method}\n\n\n\\begin{method}{coveringAlphabets}{Q,shift}\n\n\\end{method}\n\n\n"}︡{"done":true}
︠98809d7d-1130-40c6-b14c-32a779c4df36︠
︡4410c59d-5156-43d6-bbbb-8fd01c39b174︡
︠a7dd3161-c96c-4ac6-996c-1792d5a68844︠









