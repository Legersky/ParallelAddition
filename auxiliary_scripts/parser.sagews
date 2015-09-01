︠72ce4c3e-3dac-41d9-834b-b821993e0203s︠
path='classes/WeightFunction.sage'

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
︡fdd16456-d780-4498-b25f-a1cbb86d11d8︡{"stdout":"-----------------------------CONSTRUCTOR, GETTERS-------------------------------------------------------------------\n\n\\begin{method}{\\_\\_init\\_\\_}{B}\n\n\\end{method}\n\n\n\\begin{method}{\\_\\_repr\\_\\_}{}\n\n\\end{method}\n\n\n\\begin{method}{getMaxLength}{}\n\n\\end{method}\n\n\n\\begin{method}{getMapping}{}\n\n\\end{method}\n\n\n-----------------------------ADDING INPUTS, CALL FUNCTION-------------------------------------------------------------------\n\n\\begin{method}{\\_\\_call\\_\\_}{ input\\_tuple}\n\n\\end{method}\n\n\n\\begin{method}{getWeightCoef}{ w}\n\n\\end{method}\n\n\n\\begin{method}{addWeightCoefToInput}{\\_input, coef}\n\n\\end{method}\n\n\n-----------------------------PRINT FUNCTIONS-------------------------------------------------------------------\n\n\\begin{method}{printInfo}{}\n\n\\end{method}\n\n\n\\begin{method}{printLatexInfo}{}\n\n\\end{method}\n\n\n\\begin{method}{printMapping}{}\n\n\\end{method}\n\n\n\\begin{method}{printLatexMapping}{}\n\n\\end{method}\n\n\n\\begin{method}{printCsvMapping}{}\n\n\\end{method}\n\n\n"}︡
︠98809d7d-1130-40c6-b14c-32a779c4df36︠
︡4410c59d-5156-43d6-bbbb-8fd01c39b174︡
︠a7dd3161-c96c-4ac6-996c-1792d5a68844︠









