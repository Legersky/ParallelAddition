class WeightCoefficientsSetSearch(object):
    """
    Class for searching for Weight Coefficients set
    """
#-----------------------------CONSTRUCTOR-------------------------------------------------------------------
    def __init__(self, algForParallelAdd, method):
        self._algForParallelAdd = algForParallelAdd
            #class AlgorithmForParallelAddition
        self._alphabet = algForParallelAdd.getAlphabet()
            #alphabet
        self._inputAlphabet=algForParallelAdd.getInputAlphabet()
            #input alphabet
        self._ringGenerator = algForParallelAdd.getRingGenerator()
            #generator of Ring omega
        self._base=algForParallelAdd.getBase()
            #base
        self._verbose=algForParallelAdd._verbose

        self._method=method
        if self._method==None:
            self._method=2     #set the default method

        #the following diagonalizing matrix is necessary for construction of the norm for method 3
        self._diagonalizingMatrix=matrix(CC,matrix(QQbar,self._algForParallelAdd._inverseBaseCompanionMatrix).eigenmatrix_right()[1])

    def __repr__(self):
        return "Instance of PotentialCoefficientsSet using method %s" %self._method

#-----------------------------SEARCH FOR WEIGHT COEFFICIENT SET-------------------------------------------------------------------

    def _findCandidates(self,C):
        # it finds \forall elem_c \in C the list cand_for_elem(elem_c): \forall x \in cand_for_elem(elem_c): elem_c \in A + \beta x
        candidates=[]
        for elem_c in C:
            cand_for_elem=[]
            num_cand=0
            for a in self._alphabet:
                division_result=self._algForParallelAdd.divideByBase(elem_c-a)
                if not division_result==None:            #add result to candidates if it is divisible by base
                    cand_for_elem.append(division_result)
                    num_cand+=1
            if num_cand==0:
                raise RuntimeError ("There is no element a in the alphabet %s and candidate q in the alphabetRing such that %s = a+ base* q" %(self._alphabet,elem_c ))
            candidates.append(cand_for_elem)
        return candidates

    def _chooseQk_FromCandidates(self,candidates):
        #using candidates in candidates it enlarges Qk1 to Qk so that B + Qk1 \subset A + \beta Qk
        #returns Qk
        res=Set(self._Qk1)
        added_elem=[]
        self._numbersOfElementsInIterations.append(len(res))
        if self._verbose>=1: print "Number of elements in Qk: ", len(res)
        self._algForParallelAdd.addLog( "Number of elements in Qk: "+ str(len(res)))
        #Method 1 chooses the smallest element (the embedding to CC is necessary here)
        if self._method==1:
            for cand_for_elem in candidates:
                intersect=Set(cand_for_elem).intersection(res)
                if intersect.is_empty():                #check if there is already some candidate in Qk1
                    if self._verbose>=1: print "Searching smallest element."
                    weightCoef=self.algForParallelAdd._findSmallest(cand_for_elem)
                    res=res.union(Set([weightCoef]))            #add the smallest one
                    if self._verbose>=2: print "Added coefficient:"
                    if self._verbose>=2: print weightCoef
                    added_elem.append(weightCoef)
                else:
                    if self._verbose>=2: print "Candidate(s) %s is already in Qk1:" %intersect
            if self._verbose>=1: print "Added coefficients:"
            if self._verbose>=1: print added_elem
            self._algForParallelAdd.addLog("Added coefficients:")
            self._algForParallelAdd.addLog(added_elem, latex=True)
            self._algForParallelAdd.addWeightCoefSetIncrement(added_elem)
            return res.list()

        #Method 2 takes first the only possible candidates and then chooses the smallest element (the embedding to CC is necessary here)
        if self._method==2:
            for cand_for_elem in copy(candidates):
                if len(cand_for_elem)==1:
                    weightCoef=cand_for_elem[0]
                    if self._verbose>=2: print "Only element: ", weightCoef
                    if not weightCoef in res:            #pick and add the only element if it is not in Qk1 yet
                        res=res.union(Set([weightCoef]))
                        if self._verbose>=2: print "Added coefficient:"
                        if self._verbose>=2: print weightCoef
                        added_elem.append(weightCoef)
                    candidates.remove(cand_for_elem)    #remove cand_for_elem from candidates

            for cand_for_elem in candidates:
                intersect=Set(cand_for_elem).intersection(res)
                if intersect.is_empty():                #check if there is already some candidate in Qk1
                    if self._verbose>=2: print "Searching smallest element."
                    weightCoef=self.algForParallelAdd._findSmallest(cand_for_elem)
                    res=res.union(Set([weightCoef]))            #add the smallest one
                    if self._verbose>=2: print "Added coefficient:"
                    if self._verbose>=2: print weightCoef
                    added_elem.append(weightCoef)
                else:
                    if self._verbose>=2: print "Candidate(s) %s is already in Qk1:" %intersect
            if self._verbose>=1: print "Added coefficients:"
            if self._verbose>=1: print added_elem
            self._algForParallelAdd.addLog("Added coefficients:")
            self._algForParallelAdd.addLog(added_elem, latex=True)
            self._algForParallelAdd.addWeightCoefSetIncrement(added_elem)
            return res.list()

        #Method 3 takes first the only possible candidates and then chooses the smallest element in the natural norm
        if self._method==3:
            for cand_for_elem in copy(candidates):
                if len(cand_for_elem)==1:
                    weightCoef=cand_for_elem[0]
                    if self._verbose>=2: print "Only element: ", weightCoef
                    if not weightCoef in res:            #pick and add the only element if it is not in Qk1 yet
                        res=res.union(Set([weightCoef]))
                        if self._verbose>=2: print "Added coefficient:"
                        if self._verbose>=2: print weightCoef
                        added_elem.append(weightCoef)
                    candidates.remove(cand_for_elem)    #remove cand_for_elem from candidates

            for cand_for_elem in candidates:
                intersect=Set(cand_for_elem).intersection(res)
                if intersect.is_empty():                #check if there is already some candidate in Qk1
                    if self._verbose>=2: print "Searching smallest element."
                    weightCoef=self.algForParallelAdd._findSmallest_norm(cand_for_elem)
                    res=res.union(Set([weightCoef]))            #add the smallest one
                    if self._verbose>=2: print "Added coefficient:"
                    if self._verbose>=2: print weightCoef
                    added_elem.append(weightCoef)
                else:
                    if self._verbose>=2: print "Candidate(s) %s is already in Qk1:" %intersect
            if self._verbose>=1: print "Added coefficients:"
            if self._verbose>=1: print added_elem
            self._algForParallelAdd.addLog("Added coefficients:")
            self._algForParallelAdd.addLog(added_elem, latex=True)
            self._algForParallelAdd.addWeightCoefSetIncrement(added_elem)
            return res.list()
        else:
            raise ValueError("Method number %s for WeightCoefficientsSet is not implemented" % self._method)

    def _getQk(self,C):
        #it extends Qk1 to Qk such that C \subset A + \beta Qk
        return self._chooseQk_FromCandidates(self._findCandidates(C))

    def findWeightCoefficientsSet(self, maxIterations):
        # call  _chooseQkFromCandidates until there is no increment
        self._Qk1=[]    #previous potential Weight Coefficient Set
        self._Qk1.append(0)    #0 is always in Weight Coefficients set
        self._algForParallelAdd.addWeightCoefSetIncrement(self._Qk1)
        self._numbersOfElementsInIterations=[]
        self._algForParallelAdd.addLog('Starting Q_0:')
        self._algForParallelAdd.addLog(self._Qk1, latex=True)
        B=self._inputAlphabet   #input alphabet
        self._Qk2=copy(self._Qk1)    #preprevious potential Weight Coefficient Set

        self._Qk1=self._getQk(self._algForParallelAdd.sumOfSets(B,self._Qk1))    #get Qk for B+Qk1 \subset alphabet + base* Qk
        k=0
        while True:
            if k>=maxIterations-1:
                if self._verbose>=1: print "Phase 1 doesn't stop after %s loops" %(k+1)
                raise RuntimeError("Searching Weight coefficient set requires more interations than given maximum: " + str(maxIterations))
            tested_set=Set(self._algForParallelAdd.sumOfSets(B,self._Qk1)).difference(Set(self._algForParallelAdd.sumOfSets(B,self._Qk2)))
                #it is enough to check (B+Qk1)-(B+Qk2)
            Qk=self._getQk(tested_set.list())
            if len(Qk)==len(self._Qk1):    #no increment
                return self._Qk1
            else:
                self._Qk2=copy(self._Qk1)
                self._Qk1=copy(Qk)
            k+=1
        return self._Qk1

