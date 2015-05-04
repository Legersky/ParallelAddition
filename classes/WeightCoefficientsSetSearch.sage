load('CandidateSetSearch.sage')

class WeightCoefficientsSetSearch(CandidateSetSearch):
    """
    Searching set of Weight Coefficients
    """
    def __init__(self, AlgForParallelAdd, method):
        super(WeightCoefficientsSetSearch,self).__init__(AlgForParallelAdd)
        self._method=method

    def __repr__(self):
        return "Instance of PotentialCoefficientsSet using method %s" %self._method

    def _chooseQk_FromCandidates(self,cand_for_all):
        #using candidates in cand_for_all it enlarges Qk1 to Qk so that B + Qk1 \subset A + \beta Qk
        #returns Qk
        res=Set(self._Qk1)
        added_elem=[]
        if self._verbose>=1: print "Number of elements in Qk: ", len(res)
        self._algForParallelAdd.addLog( "Number of elements in Qk: "+ str(len(res)))
        #Method 1 chooses the smallest element (the embedding to CC is necessary here)
        if self._method==1:
            for cand_for_elem in cand_for_all:
                intersect=Set(cand_for_elem).intersection(res)
                if intersect.is_empty():                #check if there is already some candidate in Qk1
                    if self._verbose>=1: print "Searching smallest element."
                    weightCoef=self._findSmallest(cand_for_elem)
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
            return res.list()

        #Method 2 takes first the only possible candidates and then chooses the smallest element (the embedding to CC is necessary here)
        if self._method==2:
            for cand_for_elem in copy(cand_for_all):
                if len(cand_for_elem)==1:
                    weightCoef=cand_for_elem[0]
                    if self._verbose>=2: print "Only element: ", weightCoef
                    if not weightCoef in res:            #pick and add the only element if it is not in Qk1 yet
                        res=res.union(Set([weightCoef]))
                        if self._verbose>=2: print "Added coefficient:"
                        if self._verbose>=2: print weightCoef
                        added_elem.append(weightCoef)
                    cand_for_all.remove(cand_for_elem)    #remove cand_for_elem from cand_for_all

            for cand_for_elem in cand_for_all:
                intersect=Set(cand_for_elem).intersection(res)
                if intersect.is_empty():                #check if there is already some candidate in Qk1
                    if self._verbose>=2: print "Searching smallest element."
                    weightCoef=self._findSmallest(cand_for_elem)
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
            return res.list()
        else:
            raise ValueError("Method number %s for PotentialCoefficientsSet is not implemented" % self._method)

    def _getQk(self,C):
        #it extends Qk1 to Qk such that C \subset A + \beta Qk
        return self._chooseQk_FromCandidates(self._findCandidates(C))

    def findWeightCoefficientsSet(self, maxIterations):
        # call  _chooseQkFromCandidates until there is no increment
        self._Qk1=[]    #previous potential Weight Coefficient Set
        self._Qk1.append(0)    #O is always in Weight Coefficients set
        self._algForParallelAdd.addLog('Starting Q_0:')
        self._algForParallelAdd.addLog(self._Qk1, latex=True)
        B=self._algForParallelAdd.getInputAlphabet() #sumOfSets(self._alphabet,self._alphabet)    #input alphabet
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
