load('WeightFunction.sage')

class WeightFunctionSearch(object):
    """
    searching Weight Function
    """
#-----------------------------CONSTRUCTOR, SETTERS-------------------------------------------------------------------
    def __init__(self, algForParallelAdd, weightCoefSet, method):
        self._algForParallelAdd = algForParallelAdd
            #class AlgorithmForParallelAddition
        self._alphabet = algForParallelAdd.getAlphabet()
            #alphabet
        self._ringGenerator = algForParallelAdd.getRingGenerator()
            #generator of Ring omega
        self._base=algForParallelAdd.getBase()
            #base
        self._verbose=algForParallelAdd._verbose

        self._B=algForParallelAdd.getInputAlphabet()
            #alphabet of inputs (sequence to rewrite)
        self._weightFunction= WeightFunction(self._B)
            #weight function
        self._weightCoefSet=weightCoefSet
            #starting set of weight coefficients
        self._Qw_w={}
            #dictionary of sets of weight coefficients for (w_0 ... w_m), wi \in self._B
        self._method=method
        self._k=0

    def __repr__(self):
        return "Instance of WeightFunctionSearch"

#-----------------------------SEARCH FOR WEIGHT FUNCTION-------------------------------------------------------------------
    def _find_weightCoef_for_comb_B(self, combinations):
        #finds weight coefficients for combinations + letter from self._B if it is possible, function returns combinations for which wider window is necessary to get weight coefficient
        new_combinations=[]
        for comb in combinations:
            for wj in self._B:
                w_tuple = comb+(wj,)
                Qww=self._findQw(w_tuple)    #find Qww for the tuple and save weight coefficient if there is only one element in Qww
                if len(Qww)==1:
                    self._weightFunction.addWeightCoefToInput(w_tuple, Qww[0])
                else:
                    new_combinations.append(w_tuple)
        return new_combinations

    def _findQw(self,w_tuple):
        #find set of possible weight coefficients for input w_tuple
        w_tuple_without_first=w_tuple[1:]
        w0=w_tuple[0]
        if w_tuple_without_first in self._Qw_w:
            C=self._algForParallelAdd.sumOfSets([w0],self._Qw_w[w_tuple_without_first])
            if self._method==4:
                Qww=[]
                Qw_prev=self._Qw_w[w_tuple[0:-1]]
                if self._verbose>=2:
                    print 'To be covered:' , C
                    print 'Previous Qw', Qw_prev
                C_covered_by={}        #key= element of C, value=list of elements of Qw_prev that cover key
                for q in Qw_prev:
                    for covered_by_q in Set(self._algForParallelAdd.sumOfSets(self._alphabet,[self._base*q])).intersection(Set(C)):
                        #add covering values
                        if covered_by_q in C_covered_by:
                            C_covered_by[covered_by_q].append(q)    #next ones
                        else:
                            C_covered_by[covered_by_q]=[q]        #first covering value

                while C_covered_by:        #while there are uncovered elements
                    if self._verbose>=2:
                        print C_covered_by
                    to_add=[]
                    for covered in C_covered_by:
                        if len(C_covered_by[covered])==1:    #primarily add values which are single covering ones
                            to_add.append(C_covered_by[covered][0])
                    to_add=Set(to_add).list()

                    num=2
                    while not to_add:
                        for covered in C_covered_by:
                            if len(C_covered_by[covered])==num:    #then add first value of number num
                                to_add.append(C_covered_by[covered][0])
                                break
                        num+=1

                    for covered in copy(C_covered_by):
                        for added in to_add:
                            if added in C_covered_by[covered]:
                                C_covered_by.pop(covered)    #remove covered elements from dictionary
                                break
                    if self._verbose>=2:
                        print 'Elements to add:', to_add
                    Qww+=to_add
                Qww=Set(Qww).list()
            else:
                raise ValueError("Method number %s for WeightFunctionSearch is not implemented" % self._method)
            if self._verbose>=2: print "Qw_w for ", w_tuple, " was found"
            self._Qw_w[w_tuple]=Qww
            return Qww
        else:
            raise RuntimeError("There is no Qww for: ", w_tuple_without_first)

    def findWeightFunction(self, max_input_length):
        # checks different w \in alphabet + alphabet, it extends the window if there is no unique weight coefficient
        self._Qw_w[()]=self._weightCoefSet
        combinations=[()]
        self._k=0
        while combinations:
            if self._k>=max_input_length:
                raise RuntimeError("Inputs are longer than given maximum: "+ str(max_input_length))
            num_prev_comb=len(combinations)
            combinations=self._find_weightCoef_for_comb_B(combinations)
            self._k+=1
            if self._verbose>=1: print "Length of the window: ", self._k,", Number of saved combinations of input digits: " ,num_prev_comb*len(self._B) - len(combinations), ", To next iteration: " ,len(combinations)
            self._algForParallelAdd.addLog("Length of the window: "+ str(self._k) + ", Number of saved combinations of input digits: " + str(num_prev_comb*len(self._B) - len(combinations)) + ", To next iteration: " + str(len(combinations)))
        return self._weightFunction

    def check_one_letter_inputs(self, max_input_length):
        #check if there is a unique weight coefficient for inputs given by repetition of one letter
        self._Qw_w[()]=self._weightCoefSet
        longest=[()]
        self._algForParallelAdd._problematicLetters=[]
        for a in self._B:
            if self._verbose>=1: print "Processing input", a,',', a, '...'
            w_tuple=(a,)
            Qww=self._findQw(w_tuple)
            if self._verbose>=1:print Qww
            inp_len=1
            prevQww=Set(Qww)
            while len(Qww)>1:
                if inp_len>=max_input_length:
                    self._algForParallelAdd.addLog("Inputs are longer than the given maximum: %s" %(max_input_length))
                    raise RuntimeError("Inputs are longer than the given maximum: %s" %(max_input_length))
                w_tuple = w_tuple+(a,)
                Qww=self._findQw(w_tuple)    #find Qww for the tuple and save weight coefficient if there is only one element in Qww
                if self._verbose>=1:  print Qww
                if prevQww==Set(Qww):
                    self._algForParallelAdd.addLog("There is no unique weight coefficient for finite input gained by repetition of letter %s using method number %s" %(a,self._method))
                    self._algForParallelAdd._problematicLetters.append(a)
                    break
                if len(Qww)==1:
                    self._weightFunction.addWeightCoefToInput(w_tuple, Qww[0])
                inp_len+=1
                prevQww=Set(Qww)
            if len(w_tuple)>len(longest[0]):
                longest=[w_tuple]
            elif len(w_tuple)==len(longest[0]):
                longest.append(w_tuple)
        if self._algForParallelAdd._problematicLetters:
            raise RuntimeError("There is no unique weight coefficient for finite input gained by repetition of letters %s using method number %s" %(self._algForParallelAdd._problematicLetters,self._method))
        return longest

#-----------------------------PRINT FUNCTION-------------------------------------------------------------
    def printCsvQww(self):
        for inp, coef in self._Qw_w.items():
            line=' '
            if len(inp)==self._k:
                for wj in inp:
                    line=line+str(wj)+'; '
                for i in range(len(inp),self._weightFunction._maxLength):
                    line=line+'; '
                line=line+ str(coef)
                print line
