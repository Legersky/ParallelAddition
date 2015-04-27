class WeightFunction(object):
    """ukladani prepisovacich pravidel"""
    def __init__(self,B):
        self._maxLength=1
        self._mapping={}
        self._inputAlphabet=B
            #alphabet of inputs (rewritten sequence)

    def __repr__(self):
        return "Instance of WeightFunction"

    def __call__(self, input_tuple):
        return self.getWeightCoef(input_tuple)

    def addWeightCoefToInput(self,_input, coef):
        if not type(_input) is tuple:
            raise TypeError("The weight function input must be a tuple.")
        for x_i in _input:
            if not x_i in self._inputAlphabet:
                raise ValueError("Value %s is not in the alphabet of rewritten sequence." %x_i)
        if len(_input)>self._maxLength:
            self._maxLength = len(_input)
        self._mapping[_input]=coef

    def printInfo(self):
        print "Maximal input length: %s" %self._maxLength
        print "Number of inputs:", len(self._mapping.keys())

    def printLatexInfo(self):
        print "Maximal input length: $" + latex(self._maxLength)  + '$'
        print '\n'
        print "Number of inputs: $" + latex(len(self._mapping.keys())) + '$'
        print '\n'

    def printMapping(self):
        self.printInfo()
        for inp, coef in self._mapping.items():
            show("Input: ", inp, "coeficient: ", coef)

    def printLatexMapping(self):
        self.printLatexInfo()
        for inp, coef in self._mapping.items():
            print "Input $(x_j, \dots , x_{j-%s}) = " %(len(inp)-1) + latex(inp) + "$ coeficient:" + '$' +  latex(coef) + '$'
            print '\n'

    def printCsvMapping(self):
        for inp, coef in self._mapping.items():
            line=''
            for xj in inp:
                line=line+str(xj)+'; '
            for i in range(len(inp),self._maxLength):
                line=line+'; '
            line=line+ str(coef)
            print line

    def getMaxLength(self):
        return self._maxLength

    def getWeightCoef_old(self, input_tuple):
        if input_tuple in self._mapping:
            return self._mapping[input_tuple]
        else:
            raise ValueError("There is no rule for tuple ", input_tuple)

    def getWeightCoef(self, x):
        #outputs weight coef for x = (x_j, x_j-1, ...), zeros are appended if necessary
        maxLength=self._maxLength
        x=list(x)
        x.extend([0]*(maxLength+1))    #padding by zeros in greater exponents
        #minLength=1
        for i in range(0,len(x)):
            if not x[i] in self._inputAlphabet:
                raise ValueError("Digit %s is not in the input alphabet" %x[i])
        input_tuple=(x[0],)    #input to weight function
         #   for k in range(0,minLength-1):
         #       input_tuple= input_tuple + (x[i+k],)
        shift=1
        while not input_tuple in self._mapping:    #until the input is found in the weight function
            input_tuple=input_tuple + (x[shift],)                    #take longer if not
            shift+=1
            if shift>maxLength:
                raise RuntimeError("Input tuple " + str(input_tuple) + " is longer than maxLength of Weight function.")
        return self._mapping[input_tuple]

    def getMapping(self):
        return self._mapping

