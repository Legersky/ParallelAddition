load('CandidateSetSearch.sage')
load('WeightFunction.sage')

class WeightFunctionSearch(CandidateSetSearch):
    """
    searching Weight Function
    """
#-----------------------------CONSTRUCTOR, GETTERS-------------------------------------------------------------------
    def __init__(self, algForParallelAdd, weightCoefSet, method):
        super(WeightFunctionSearch,self).__init__(algForParallelAdd)
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
    def _chooseQww_FromCandidates(self, cand_Qww, w_tuple):
        Qw_prev=self._Qw_w[w_tuple[0:-1]]
        for cand_elem in copy(cand_Qww):   #intersection with previous Qww
            for cand in copy(cand_elem):
                if not cand in Qw_prev:
                    cand_elem.remove(cand)
        # takes candidates from findCandidates(w + Qw) and then it chooses the Qww such that  w + Qw \subset alphabet + base * Qww
        if self._method==1:
            #method 1 adds the smallest candidate in absolute value -> it is very slow (both in convergence and power)
            res=[]
            for cand_elem in cand_Qww:
                res.append(self._findSmallest(cand_elem))
            if self._verbose>=1: print res
            return Set(res).list()
        elif self._method==2:
            #method 2 adds the candidates with the highest number of occurencies BLBE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            cand_occur={}
            for cand_elem in cand_Qww:    #counting occurencies
                for cand in cand_elem:
                    if not cand in cand_occur:
                        cand_occur[cand]=1
                    else:
                        cand_occur[cand]+=1
            cand_sorted_by_occur=sorted(cand_occur, key=cand_occur.get, reverse=True)    #sorting from the most frequent candidate
            num_lists=len(cand_Qww)
            res=[]
            num_added=0
            index_sort=0
            cand_notCoveredElem=copy(cand_Qww)
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
            for cand_for_elem in cand_Qww:
                if len(cand_for_elem)==1:
                    res.append(cand_for_elem[0])        #add only possible candidates
            res=Set(res).list()

            notCoveredCandLists=copy(cand_Qww)
            for cand_for_elem in cand_Qww:
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
                num_lists=len(cand_Qww)
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
            for wj in self._B:
                w_tuple = comb+(wj,)
                Qww=self._findQw(w_tuple)    #find Qww for the tuple and save weight coefficient if there is only one element in Qww
                if len(Qww)==1:
                    self._weightFunction.addWeightCoefToInput(w_tuple, Qww[0])
                else:
                    new_combinations.append(w_tuple)
        return new_combinations

    def _findQw(self,w_tuple):
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
                #find candidates cand_Qww such that w0 + _Qw_w[w_tuple_without_first \subset alphabet + base* Qww
                cand_Qww=self._findCandidates(C)
                Qww=self._chooseQww_FromCandidates(cand_Qww, w_tuple)
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
            combinations=self._find_weightCoef_for_comb_B(combinations,self._k)
            self._k+=1
            if self._verbose>=1: print "Processed length: ", self._k,", Saved rules: " ,num_prev_comb*len(self._B) - len(combinations), ", To next turn: " ,len(combinations)
            self._algForParallelAdd.addLog("Processed length: "+ str(self._k) + ", Saved rules: " + str(num_prev_comb*len(self._B) - len(combinations)) + ", To next turn: " + str(len(combinations)))
        return self._weightFunction

    def check_one_letter_inputs(self, max_input_length):
        self._Qw_w[()]=self._weightCoefSet
        longest=[()]
        for a in self._B:
            if self._verbose>=1: print "Processing input", a,',', a, '...'
            w_tuple=(a,)
            Qww=self._findQw(w_tuple)
            if self._verbose>=1:print Qww
            inp_len=1
            prevQww=Set(Qww)
            while len(Qww)>1:
                if inp_len>=max_input_length:
                    raise RuntimeError("Inputs are longer than given maximum: "+ str(max_input_length))
                w_tuple = w_tuple+(a,)
                Qww=self._findQw(w_tuple)    #find Qww for the tuple and save weight coefficient if there is only one element in Qww
                if self._verbose>=1:  print Qww
                if prevQww==Set(Qww):
                    self._algForParallelAdd.addLog("There is no unique weight coefficient for finite input gained by repetition of letter %s using method number %s" %(a,self._method))
                    raise RuntimeError("There is no unique weight coefficient for finite input gained by repetition of letter %s using method number %s" %(a,self._method))
                if len(Qww)==1:
                    self._weightFunction.addWeightCoefToInput(w_tuple, Qww[0])
                inp_len+=1
                prevQww=Set(Qww)
            if len(w_tuple)>len(longest[0]):
                longest=[w_tuple]
            elif len(w_tuple)==len(longest[0]):
                longest.append(w_tuple)
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
