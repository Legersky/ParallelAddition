load('CandidateSetSearch.sage')
load('WeightFunction.sage')

class WeightFunctionSearch(CandidateSetSearch):
    """
    searching Weight Function
    """
    def __init__(self, algForParallelAdd, weightCoefSet, method):
        super(WeightFunctionSearch,self).__init__(algForParallelAdd)
        self._B=algForParallelAdd.getInputAlphabet()
            #alphabet of inputs (sequence to rewrite)
        self._weightFunction= WeightFunction(self._B)
            #weight function
        self._weightCoefSet=weightCoefSet
            #starting set of weight coefficients
        self._Qx_x={}
            #dictionary of sets of weight coefficients for (x_0 ... x_m), xi \in self._B
        self._method=method

    def __repr__(self):
        return "Instance of WeightFunctionSearch"

    def _chooseQxx_FromCandidates(self, cand_Qxx):
        # takes candidates from findCandidates(x + Qx) and then it chooses the Qxx such that  x + Qx \subset alphabet + base * Qxx
        if self._method==1:
            #method 1 adds the smallest candidate in absolute value -> it is very slow (both in convergence and power)
            res=[]
            for cand_elem in cand_Qxx:
                res.append(self._findSmallest(cand_elem))
            if self._verbose>=1: print res
            return Set(res).list()
        elif self._method==2:
            #method 2 adds the candidates with the highest number of occurencies BLBE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            cand_occur={}
            for cand_elem in cand_Qxx:    #counting occurencies
                for cand in cand_elem:
                    if not cand in cand_occur:
                        cand_occur[cand]=1
                    else:
                        cand_occur[cand]+=1
            cand_sorted_by_occur=sorted(cand_occur, key=cand_occur.get, reverse=True)    #sorting from the most frequent candidate
            num_lists=len(cand_Qxx)
            res=[]
            num_added=0
            index_sort=0
            cand_notCoveredElem=copy(cand_Qxx)
            while cand_notCoveredElem:    #add candidates according to occurencies until there is at least one for each list
                to_add=cand_sorted_by_occur[index_sort]
                res.append(to_add)
                if self._verbose>=2: print "Adding ", to_add
                for cand_elem in copy(cand_notCoveredElem):
                    if to_add in cand_elem:        #if the element to_add is in the list, then there is no need to check it again (i.e. it is removed)
                        cand_notCoveredElem.remove(cand_elem)
                index_sort+=1
            return res
        elif self._method==3:
            #method 3 takes first the only possible candidates and then it adds the candidates with the highest number of occurencies
            res=[]
            for cand_for_elem in cand_Qxx:
                if len(cand_for_elem)==1:
                    res.append(cand_for_elem[0])        #add only possible candidates
            res=Set(res).list()

            notCoveredCandLists=copy(cand_Qxx)
            for cand_for_elem in cand_Qxx:
                for val in res:
                    if val in cand_for_elem:        #remove candidate list covered by added values
                        notCoveredCandLists.remove(cand_for_elem)
                        break

            if notCoveredCandLists:    #if there are still lists to cover
                cand_occur={}
                for cand_elem in notCoveredCandLists:    #counting occurencies
                    for cand in cand_elem:
                        if not cand in cand_occur:
                            cand_occur[cand]=1
                        else:
                            cand_occur[cand]+=1
                cand_sorted_by_occur=sorted(cand_occur, key=cand_occur.get, reverse=True)    #sorting from the most frequent candidate
                num_lists=len(cand_Qxx)
                num_added=0
                index_sort=0
            while notCoveredCandLists:    #add candidates according to occurencies until all lists are covered
                to_add=cand_sorted_by_occur[index_sort]
                res.append(to_add)
                if self._verbose>=2: print "Adding ", to_add
                for cand_elem in copy(notCoveredCandLists):
                    if to_add in cand_elem:        #if the element to_add is in the list, then there is no need to check it again (i.e. it is removed)
                        notCoveredCandLists.remove(cand_elem)
                index_sort+=1
            return res
        else:
            raise ValueError("Method number %s for WeightFunctionSearch is not implemented" % self._method)

    def _find_weightCoef_for_comb_B(self, combinations, max_len):
        #finds weight coefficients for combinations + letter from self._B if it is possible, function returns combinations for which wider window is necessary to get weight coefficient
        new_combinations=[]
        for comb in combinations:
            for xj in self._B:
                x_tuple = comb+(xj,)
                Qxx=self._findQx(x_tuple)    #find Qxx for the tuple and save weight coefficient if there is only one element in Qxx
                if len(Qxx)==1:
                    self._weightFunction.addWeightCoefToInput(x_tuple, Qxx[0])
                else:
                    new_combinations.append(x_tuple)
        return new_combinations

    def _findQx(self,x_tuple):
        x_tuple_without_first=x_tuple[1:]
        x0=x_tuple[0]
        if x_tuple_without_first in self._Qx_x:
            C=self._algForParallelAdd.sumOfSets([x0],self._Qx_x[x_tuple_without_first])
            #find candidates cand_Qxx such that x0 + _Qx_x[x_tuple_without_first \subset alphabet + base* Qxx
            cand_Qxx=self._findCandidates(C)
            Qxx=self._chooseQxx_FromCandidates( cand_Qxx)
            if self._verbose>=2: print "Qx_x for ", x_tuple, " was found"
            self._Qx_x[x_tuple]=Qxx
            return Qxx
        else:
            raise RuntimeError("There is no Qxx for: ", x_tuple_without_first)

    def findWeightFunction(self, max_input_length):
        # checks different x \in alphabet + alphabet, it extends the window if there is no unique weight coefficient
        self._Qx_x[()]=self._weightCoefSet
        combinations=[()]
        self._k=0
        while combinations:
            if self._k>=max_input_length:
                raise RuntimeError("Inputs are longer than given maximum: "+ str(max_input_length))
            num_prev_comb=len(combinations)
            combinations=self._find_weightCoef_for_comb_B(combinations,self._k)
            self._k+=1
            if self._verbose>=1: print "Processed length: ", self._k,", Saved rules: " ,num_prev_comb*len(self._B) - len(combinations), ", To next turn: " ,len(combinations)
            self._algForParallelAdd.addLog("Processed length: "+ str(self._k) + ", Saved rules: " + str(num_prev_comb*len(self._B) - len(combinations)) + ", To next turn: " + str(len(combinations)))
        return self._weightFunction

    def printCsvQxx(self):
        for inp, coef in self._Qx_x.items():
            line=''
            if len(inp)==self._k:
                for xj in inp:
                    line=line+str(xj)+'; '
                for i in range(len(inp),self._weightFunction._maxLength):
                    line=line+'; '
                line=line+ str(coef)
                print line

    def check_one_letter_inputs(self, max_input_length):
        self._Qx_x[()]=self._weightCoefSet
        longest=[()]
        for a in self._B:
            if self._verbose>=1: print "Processing input", a,',', a, '...'
            x_tuple=(a,)
            Qxx=self._findQx(x_tuple)
            if self._verbose>=1:print Qxx
            inp_len=1
            prevQxx=Set(Qxx)
            while len(Qxx)>1:
                if inp_len>=max_input_length:
                    raise RuntimeError("Inputs are longer than given maximum: "+ str(max_input_length))
                x_tuple = x_tuple+(a,)
                Qxx=self._findQx(x_tuple)    #find Qxx for the tuple and save weight coefficient if there is only one element in Qxx
                if self._verbose>=1:  print Qxx
                if prevQxx==Set(Qxx):
                    self._algForParallelAdd.addLog("There is no unique weight coefficient for finite input gained by repetition of letter %s using method number %s" %(a,self._method))
                    raise RuntimeError("There is no unique weight coefficient for finite input gained by repetition of letter %s using method number %s" %(a,self._method))
                if len(Qxx)==1:
                    self._weightFunction.addWeightCoefToInput(x_tuple, Qxx[0])
                inp_len+=1
                prevQxx=Set(Qxx)
            if len(x_tuple)>len(longest[0]):
                longest=[x_tuple]
            elif len(x_tuple)==len(longest[0]):
                longest.append(x_tuple)
        return longest

