class WeightFunction(object):
    """saving of weight function"""
#-----------------------------CONSTRUCTOR, GETTERS-------------------------------------------------------------------
    def __init__(self,B):
        self._maxLength=1
        self._mapping={}
        self._num_of_saved=0
        self._inputAlphabet=B
            #alphabet of input sequence

    def __repr__(self):
        return "Instance of WeightFunction"

    def getMaxLength(self):
        return self._maxLength

    def getMapping(self):
        return self._mapping

#-----------------------------ADDING INPUTS, CALL FUNCTION-------------------------------------------------------------------
    def __call__(self, input_tuple):
        return self.getWeightCoef(input_tuple)

    def getWeightCoef(self, w):
        #outputs weight coef for w = (w_j, w_j-1, ...), zeros are appended if necessary
        maxLength=self._maxLength
        w=list(w)
        w.extend([0]*(maxLength+1))    #padding by zeros in greater exponents

        for i in range(0,len(w)):
            if not w[i] in self._inputAlphabet:
                raise ValueErrorParAdd("Digit %s is not in the input alphabet" %w[i])
        input_tuple=(w[0],)    #input to weight function
        shift=1
        while not input_tuple in self._mapping:    #until the input is found in the weight function
            input_tuple=input_tuple + (w[shift],)                    #take longer if not
            shift+=1
            if shift>maxLength:
                raise RuntimeErrorParAdd("Input tuple " + str(input_tuple) + " is longer than maxLength of Weight function.")
        return self._mapping[input_tuple]

    def addWeightCoefToInput(self,_input, coef):
        #save coef fo _input
        if not type(_input) is tuple:
            raise TypeErrorParAdd("The weight function input must be a tuple.")
        for w_i in _input:
            if not w_i in self._inputAlphabet:
                raise ValueErrorParAdd("Value %s is not in the alphabet of rewritten sequence." %w_i)
        if len(_input)>self._maxLength:
            self._maxLength = len(_input)
        self._mapping[_input]=coef
        self._num_of_saved+=1

#-----------------------------print FUNCTIONS-------------------------------------------------------------------
    def printInfo(self):
        print("Maximal input length: %s" %self._maxLength)
        print("Number of inputs:", len(self._mapping.keys()))

    def printLatexInfo(self):
        print("Maximal input length: $" + latex(self._maxLength)  + '$')
        print('\n')
        print("Number of inputs: $" + latex(len(self._mapping.keys())) + '$')
        print('\n')

    def printMapping(self):
        self.printInfo()
        for inp, coef in self._mapping.items():
            show("Input: ", inp, "coeficient: ", coef)

    def printLatexMapping(self):
        self.printLatexInfo()
        for inp, coef in self._mapping.items():
            print("Input $(w_j, \\dots , w_{j-%s}) = " %(len(inp)-1) + latex(inp) + "$ coeficient:" + '$' +  latex(coef) + '$')
            print('\n')

    def printCsvMapping(self):
        for inp, coef in self._mapping.items():
            line=' '
            for wj in inp:
                line=line+str(wj)+'; '
            for i in range(len(inp),self._maxLength):
                line=line+'; '
            line=line+ str(coef)
            print(line)

