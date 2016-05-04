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
            self._method='1d'     #set the default method
        methods1_letter={'1a':14,'1b':12, '1c':16, '1d':13,'1e':15}
        if self._method in methods1_letter:
            self._method=methods1_letter[self._method]

    def __repr__(self):
        return "Instance of PotentialCoefficientsSet using method %s" %self._method

    def getMethod(self):
        methods1_letter={14:'1a', 12:'1b', 16:'1c', 13:'1d',15:'1e'}
        if self._method in methods1_letter:
            return methods1_letter[self._method]
        else:
            return self._method

#-----------------------------SEARCH FOR WEIGHT COEFFICIENT SET-------------------------------------------------------------------

    def _findCandidates(self,to_cover):
        # it finds \forall elem_c \in to_cover the list cand_for_elem(elem_c): \forall x \in cand_for_elem(elem_c): elem_c \in A + \beta x
        candidates=[]
        for elem_c in to_cover:
            cand_for_elem=[]
            num_cand=0
            for a in self._alphabet:
                division_result=self._algForParallelAdd.divideByBase(elem_c-a)
                if not division_result==None:            #add result to candidates if it is divisible by base
                    cand_for_elem.append(division_result)
                    num_cand+=1
            if num_cand==0:
                raise RuntimeErrorParAdd ("There is no element a in the alphabet %s and candidate q in the alphabetRing such that %s = a+ base* q" %(self._alphabet,elem_c ))
            candidates.append(cand_for_elem)
        return candidates

    def _chooseQk_FromCandidates(self,candidates):
        #using candidates in candidates it extends Qk1 to Qk so that B + Qk1 \subset A + \beta Qk
        #returns Qk
        res=Set(self._Qk1)
        added_elem=[]
        self._numbersOfElementsInIterations.append(len(res))
        if self._verbose>=1: print "Number of elements in Qk: ", len(res)
        self._algForParallelAdd.addLog( "Number of elements in Qk: "+ str(len(res)))

        if self._method in [1,2,3,6,7, 8,9,10,11, 12,13,14,15,16,17]:
            #Method 1 chooses the smallest element (the embedding to CC is necessary here)
            #Method 2 takes first the only possible candidates and then chooses the smallest element (in absolute value, the embedding to CC is necessary)
            #Method 3 takes first the only possible candidates and then chooses the smallest element in the beta norm
            #Method 6 takes first the only possible candidates and all in non-covered lists
            #Method 7 == 2, but A+A is taken even if the input alphabet is different
            #Method 8  takes first the only possible candidates and then add all smallest elements (absolute value)
            #Method 9  takes first the only possible candidates and then add all smallest elements (beta norm)
            #6-14 8-12 9-13 10-15 11-16
            if self._method in [2,3,6,7,8,9,12,13,14]:
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

            if self._method in [1,2,3,6,7, 8,9,10,11]:
                for cand_for_elem in candidates:
                    intersect=Set(cand_for_elem).intersection(res)
                    if intersect.is_empty():                #check if there is already some candidate in Qk1
                        if self._method in [1,2,3]:
                            if self._verbose>=2: print "Searching smallest element."
                            if self._method in [1,2]:
                                weightCoef=self._algForParallelAdd._findSmallest(cand_for_elem)
                            elif self._method in [3]:
                                weightCoef=self._algForParallelAdd._findSmallest_norm(cand_for_elem)

                            res=res.union(Set([weightCoef]))            #add the smallest one
                            added_elem.append(weightCoef)

                        elif self._method in [6,7,8,9,10,11]:
                            if self._method in [8]:
                                weightCoefs=self._algForParallelAdd._findAllSmallest(cand_for_elem)
                            elif self._method in [9,7]:
                                weightCoefs=self._algForParallelAdd._findAllSmallest_norm(cand_for_elem)
                            elif self._method in [6]:
                                weightCoefs=cand_for_elem
                            elif self._method in [10]:
                                weightCoefs=self._algForParallelAdd._findAllSmallest_norm(cand_for_elem)
                            elif self._method in [11]:
                                weightCoefs=self._algForParallelAdd._findAllSmallest(cand_for_elem)
                            res=res.union(Set(weightCoefs))
                            added_elem+=Set(weightCoefs).list()
                    else:
                        if self._verbose>=2: print "Candidate(s) %s is already in Qk1:" %intersect


            if self._method in [12,13,14,15,16,17]:
                weightCoefs=[]
                for cand_for_elem in candidates:
                    intersect=Set(cand_for_elem).intersection(res)
                    if intersect.is_empty():                #check if there is already some candidate in Qk1
                        if self._method in [12]:
                            weightCoefs+=self._algForParallelAdd._findAllSmallest(cand_for_elem)
                        elif self._method in [13]:
                            weightCoefs+=self._algForParallelAdd._findAllSmallest_norm(cand_for_elem)
                        elif self._method in [14,17]:
                            weightCoefs+=cand_for_elem
                        elif self._method in [15]:
                            weightCoefs+=self._algForParallelAdd._findAllSmallest_norm(cand_for_elem)
                        elif self._method in [16]:
                            weightCoefs+=self._algForParallelAdd._findAllSmallest(cand_for_elem)
                res=res.union(Set(weightCoefs))
                added_elem+=Set(weightCoefs).list()



            if self._verbose>=1: print "Added coefficients:"
            if self._verbose>=1: print added_elem
            self._algForParallelAdd.addLog("Added coefficients:")
            self._algForParallelAdd.addLog(added_elem, latex=True)
            self._algForParallelAdd.addWeightCoefSetIncrement(added_elem)
            return res.list()


        else:
            raise ValueErrorParAdd("Method number %s for WeightCoefficientsSet is not implemented" % self._method)

    def _getQk(self,to_cover):
        #it extends Qk1 to Qk such that C \subset A + \beta Qk
        return self._chooseQk_FromCandidates(self._findCandidates(to_cover))

    def findWeightCoefficientsSet(self, maxIterations):
        # call  _chooseQkFromCandidates until there is no increment
        if self._method in [4,5]:
            #Method 4 - weight coefficients set given by bound (norm)     DO NOT USE
            #Method 5 - weight coefficients set given by bound (abs)      DO NOT USE
            if self._method==4:
                bound=self._algForParallelAdd.computeBound_norm()
            elif self._method==5:
                bound=self._algForParallelAdd.computeBound()

            max_coef=round(bound)
            num_prev=0
            while 1:
                max_coef=2*max_coef
                comb = list(CartesianProduct(*(range(-max_coef,max_coef+1) for i in range(0,self._algForParallelAdd._minPolynomial.degree()))))

                Q=[]
                for (ind, a) in enumerate(comb):
                    cand=self._algForParallelAdd.list2Ring(list(a))
                    if self._method==4:
                        cand_size=self._algForParallelAdd.betaNorm(cand)
                    elif self._method==5:
                        cand_size=abs(self._algForParallelAdd.ring2CC(cand))
                    if cand_size<bound:
                        Q.append(cand)
                print len(Q)
                if num_prev==len(Q):
                    break

                num_prev=len(Q)

            self._Qk1=Q
            self._algForParallelAdd.addWeightCoefSetIncrement(self._Qk1)
            self._numbersOfElementsInIterations=[len(self._Qk1)]

            betaQ=[]
            for q in self._Qk1:
                betaQ.append(self._base*q)
            if not Set(self._algForParallelAdd.sumOfSets(self._inputAlphabet, self._Qk1)).issubset(Set(self._algForParallelAdd.sumOfSets(self._alphabet, betaQ))):
                raise RuntimeErrorParAdd('For Q computed by method %s: A+A+Q is not subset of A+beta Q.' %self._method)
            return self._Qk1



        self._Qk1=[]    #previous potential Weight Coefficient Set
        self._Qk1.append(0)    #0 is always in Weight Coefficients set
        self._algForParallelAdd.addWeightCoefSetIncrement(self._Qk1)
        self._numbersOfElementsInIterations=[]
        self._algForParallelAdd.addLog('Starting Q_0:')
        self._algForParallelAdd.addLog(self._Qk1, latex=True)
        B=self._inputAlphabet   #input alphabet
        if self._method==7:
            B=self._algForParallelAdd.sumOfSets(self._alphabet,self._alphabet)
        self._Qk2=copy(self._Qk1)    #preprevious potential Weight Coefficient Set

        self._Qk1=self._getQk(self._algForParallelAdd.sumOfSets(B,self._Qk1))    #get Qk for B+Qk1 \subset alphabet + base* Qk
        k=0
        while True:
            if k>=maxIterations-1:
                if self._verbose>=1: print "Phase 1 doesn't stop after %s loops" %(k+1)
                raise RuntimeErrorParAdd("Searching Weight coefficient set requires more interations than given maximum: " + str(maxIterations))
            tested_set=Set(self._algForParallelAdd.sumOfSets(B,self._Qk1)).difference(Set(self._algForParallelAdd.sumOfSets(B,self._Qk2)))
                #it is enough to check (B+Qk1)-(B+Qk2)
            Qk=self._getQk(tested_set.list())
            if len(Qk)==len(self._Qk1):    #no increment
                return self._Qk1
            else:
                if self._algForParallelAdd._minPolynomial.degree()==3 and len(Qk)>100:
                    raise RuntimeErrorParAdd("Cubic base, Weight coefficient set has more than 100 elements")
                self._Qk2=copy(self._Qk1)
                self._Qk1=copy(Qk)
            k+=1

        betaQ=[]
        for q in self._Qk1:
            betaQ.append(self._base*q)
        if not Set(self._algForParallelAdd.sumOfSets(self._inputAlphabet, self._Qk1)).issubset(Set(self._algForParallelAdd.sumOfSets(self._alphabet, betaQ))):
            raise RuntimeErrorParAdd('For Q computed by method %s: A+A+Q is not subset of A+beta Q.' %self._method)
        return self._Qk1

