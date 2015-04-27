class CandidateSetSearch(object):
    """
    it is strongly dependent on the rewriting rule
    searching canditates for the set X such that C \subset A + base * X
    """
    def __init__(self, AlgForParallelAdd):
        self._algForParallelAdd = AlgForParallelAdd
            #class AlgorithmForParallelAddition
        self._alphabet = AlgForParallelAdd.getAlphabet()
            #alphabet
        self._ringGenerator = AlgForParallelAdd.getRingGenerator()
            #generator of Ring omega
        self._base=AlgForParallelAdd.getBase()
            #base
        self._verbose=AlgForParallelAdd._verbose
        self._ringGenCompanionMatrix=matrix.companion(self._algForParallelAdd.getMinPolynomial())
            # companion matrix to minimal polynomial of ringGenerator
        self._inverseBaseCompanionMatrix=self._computeInverseBaseCompanionMatrix()
            # inversion of companion matrix of base

    def _computeInverseBaseCompanionMatrix(self):
        base_list=self._base.list()
        #Horner scheme:
        baseCompanionMatrix=matrix(self._ringGenCompanionMatrix.nrows())
        for base_coef in reversed(base_list):
            baseCompanionMatrix *= self._ringGenCompanionMatrix
            baseCompanionMatrix += base_coef
        return baseCompanionMatrix.inverse()

    def __repr__(self):
        return "Instance of CandidateSetSearch, parent class for WeightCoefficientsSetSearch and WeightFunctionSearch"

    def setVerbose(self,verb):
        self._verbose=verb

    def _findCandidates(self,C):
        # it finds \forall elem_c \in C the list cand_for_elem(elem_c): \forall x \in cand_for_elem(elem_c): elem_c \in A + \beta x
        cand_for_all=[]
        for elem_c in C:
            cand_for_elem=[]
            num_cand=0
            for a in self._alphabet:
                division_result=self.divideByBase(elem_c-a)
                if not division_result==None:            #add result to candidates if it is divisible by base
                    cand_for_elem.append(division_result)
                    num_cand+=1
            if num_cand==0:
                raise RuntimeError ("There is no element a in the alphabet %s and candidate q in the alphabetRing such that %s = a+ base* q" %(self._alphabet,elem_c ))
            cand_for_all.append(cand_for_elem)
        return cand_for_all

    def divideByBase(self,divided_number):
        #returns w divided by base if defined, else returns None
        num_list=divided_number.list()    #coeffients of divided_number in Ring
        for i in range(len(divided_number.list()), self._inverseBaseCompanionMatrix.nrows()):
            num_list.append(0)    #prolonging to length equal to degree of minimal polynomial of ringGenerator
        num_vect=vector(num_list)
        res_vect=(self._inverseBaseCompanionMatrix)*num_vect    #division over rational polynomials
        res_list=[]
        for val in res_vect.list():        #divided_number is divisible by base if all its coefficients are integers
            if val.is_integer():
                res_list.append(Integer(val))
            else:
                return None
        return self._algForParallelAdd.list2Ring(res_list)    #conversion to Ring

    def _findSmallest(self,list_from_Ring):
        #finds smallest (in absolute value) element of list_from_Ring
        smallestAbs=abs(self._algForParallelAdd.ring2CC(list_from_Ring[0]))
        smallest_in=0
        i=0
        for num in list_from_Ring[1:]:
            numAbs=abs(self._algForParallelAdd.ring2CC(num))
            i+=1
            if numAbs<smallestAbs:
                smallestAbs=numAbs
                smallest_in=i
        return list_from_Ring[smallest_in]


