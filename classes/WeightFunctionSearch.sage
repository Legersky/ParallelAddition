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

            first_time=True
            while C_covered_by:        #while there are uncovered elements
                if self._verbose>=2:
                    print C_covered_by
                to_add=[]
                if first_time:
                    for covered in C_covered_by:
                        if len(C_covered_by[covered])==1:    #primarily add values which are single covering ones
                            to_add.append(C_covered_by[covered][0])
                    to_add=Set(to_add).list()
                    first_time=False

                if self._method ==0:    	    #puvodni FUNGUJE
                    num=2
                    while not to_add:
                        for covered in C_covered_by:
                            if len(C_covered_by[covered])==num:    #then add first value of list with length num
                                to_add.append(C_covered_by[covered][0])
                                break
                        num+=1

                elif self._method ==1: #nejmensi mozna ze shortest FUNGUJE
                    num=2
                    while not to_add:
                        list_of_shortest=[]
                        for covered in C_covered_by:
                            if len(C_covered_by[covered])==num:    #then add first value of list with length num
                                list_of_shortest.append(Set(C_covered_by[covered]))
                        if list_of_shortest:
                            to_add=self._minimalCovering(list_of_shortest)[0]
                        num+=1

                elif self._method in [2,3,4,7,8]:
                    num=2
                    while not to_add:
                        shortest=[]
                        for covered in C_covered_by:
                            if len(C_covered_by[covered])==num:    #then add first value of list with length num
                                shortest+=C_covered_by[covered]
                        if shortest:
                            if self._method==2:    	    #nahodne ze shortest FUNGUJE
                                to_add.append(shortest[ZZ.random_element(len(shortest))])
                            elif self._method==3:        #pick element podle mrizky ze shortest FUNGUJE
                                chosen_element=self._pick_element(shortest)
                                if chosen_element!=None:
                                    to_add=[chosen_element]
                            elif self._method==4:        #pick element co nejbliz teziste(zaokrouhlene) podle mrizky ze shortest FUNGUJE
                                chosen_element=self._pick_element_close_PoG_by_lattice(shortest,self.point_of_gravity(shortest))
                                if chosen_element!=None:
                                    to_add=[chosen_element]
                            elif self._method==7:        #pick element co nejbliz teziste (zaokrouhlene) ze shortest FUNGUJE
                                chosen_element=self._pick_element_close_PoG(shortest,self.point_of_gravity(shortest))
                                if chosen_element!=None:
                                    to_add=[chosen_element]
                            elif self._method==8:    #co nejbliz teziste (CC) ze shortest
                                chosen_element=self._pick_element_close_PoG_CC(shortest)
                                if chosen_element!=None:
                                    to_add=[chosen_element]
                        num+=1

                elif self._method==5:        #pick element ze vsech co nejbliz teziste(zaokrouhlene) podle mrizky HORSI - WINDOW LENGTH 4
                    if not to_add:
                        elements=[]
                        for covered in C_covered_by:
                            elements+=C_covered_by[covered]        #adding all shortest
                        to_add=[self._pick_element_close_PoG_by_lattice(elements, self.point_of_gravity(elements))]

                elif self._method==9:        #co nejbliz teziste (CC) ze vsech
                    if not to_add:
                        elements=[]
                        for covered in C_covered_by:
                            elements+=C_covered_by[covered]        #adding all shortest
                        to_add=[self._pick_element_close_PoG_by_lattice(elements, self.point_of_gravity(elements))]

                elif self._method==6:    	    #nejmensi mozna FUNGUJE
                    if not to_add:
                        list_of_all=[]
                        for covered in C_covered_by:
                            list_of_all.append(Set(C_covered_by[covered]))
                        to_add=self._minimalCovering(list_of_all)[0]

                else:
                    raise ValueError("Method number %s for WeightFunctionSearch is not implemented" % self._method)

                for covered in copy(C_covered_by):
                    for added in to_add:
                        if added in C_covered_by[covered]:
                            C_covered_by.pop(covered)    #remove covered elements from dictionary
                            break
                if self._verbose>=2:
                    print 'Elements to add:', to_add
                Qww+=to_add

            Qww=Set(Qww).list()

            if self._verbose>=2:
                print "Qw_w for ", w_tuple, " was found: "
                print Qww
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

    def _pick_element(self,elements):
        #pick the element with smallest absolute, then linear, quadratic... coefficient in Z[omega]
        if elements:
            chosen=[]
            for elem in elements:
                chosen.append(self._algForParallelAdd._ring(elem))    #coercion into Z[omega]
            k=0
            while len(chosen)>1:
                #print 'vybiram z ', chosen , 'pomoci ',k, '. koeficientu'
                min_k=[chosen[0]]
                for elem in chosen[1:]:
                    if elem.list()[k]<min_k[0].list()[k]:
                        min_k=[elem]
                    elif elem.list()[k]==min_k[0].list()[k]:
                        min_k.append(elem)
                chosen=copy(min_k)
                k+=1
                if k==self._algForParallelAdd.getMinPolynomial().degree():
                    #print chosen
                    break
            #print 'vybrano1', chosen[0]
            return chosen[0]
        else:
            return None

    def _pick_element_close_PoG_by_lattice(self,elements, PoG):
        #pick the element with the smallest absolute, then linear, quadratic... coefficient in Z[omega]
        if elements:
            chosen=[]
            for elem in elements:
                chosen.append(self._algForParallelAdd._ring(elem)-PoG)    #coercion into Z[omega], shift to point of gravity
            k=0
            while len(chosen)>1:
                min_k=[chosen[0]]
                for elem in chosen[1:]:
                    if abs(elem.list()[k])<abs(min_k[0].list()[k]):
                        min_k=[elem]
                    elif abs(elem.list()[k])==abs(min_k[0].list()[k]):
                        min_k.append(elem)
                chosen=copy(min_k)
                k+=1
                if k==self._algForParallelAdd.getMinPolynomial().degree() and len(chosen)>1:
                    return self._pick_element(chosen)+PoG
            return chosen[0]+PoG
        else:
            return None

    def _pick_element_close_PoG(self,elements, PoG):
        #pick the element from elements which is closest to the point of g
        if elements:
            chosen=[]
            for elem in elements:
                chosen.append(self._algForParallelAdd._ring(elem)-PoG)    #coercion into Z[omega], shift to point of gravity

            min_abs=[chosen[0]]
            for elem in chosen[1:]:
                if abs(self._algForParallelAdd.ring2CC(elem))<abs(self._algForParallelAdd.ring2CC(min_abs[0])):
                    min_abs=[elem]
                elif abs(self._algForParallelAdd.ring2CC(elem))==abs(self._algForParallelAdd.ring2CC(min_abs[0])):
                    min_abs.append(elem)
            return self._pick_element(min_abs)+PoG
        else:
            return None

    def _pick_element_close_PoG_CC(self,elements):
        #pick the element from elements which is closest to the point of g
        if elements:
            PoG=self.point_of_gravity_CC(elements)
            min_abs=[elements[0]]
            for elem in elements[1:]:
                if abs(PoG-self._algForParallelAdd.ring2CC(elem))<abs(PoG-self._algForParallelAdd.ring2CC(min_abs[0])):
                    min_abs=[elem]
                elif abs(PoG-self._algForParallelAdd.ring2CC(elem))==abs(PoG-self._algForParallelAdd.ring2CC(min_abs[0])):
                    min_abs.append(elem)
            return self._pick_element(min_abs)
        else:
            return None

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

    def point_of_gravity(self, numbers):
        point=[]
        num=len(numbers)
        if num==0:
            return None
        for coef in self._algForParallelAdd._ring(sum(numbers)).list():
            point.append(round(coef/num))
        return self._algForParallelAdd.list2Ring(point)

    def point_of_gravity_CC(self, numbers):
        if numbers:
            point=0
            for num in numbers:
                point+=self._algForParallelAdd.ring2CC(num)
            return point/len(numbers)
        else:
            return None

    def _minimalCovering(self, sets_to_cover):
        k=1
        elements=Set([])
        for _set in sets_to_cover:
            elements=union(elements,_set)
        if self._verbose>=1:
            print 'sets to cover: ',sets_to_cover
            print 'elements: ', elements
        while 1:
            subsets_k=Subsets(elements,k)
            covering_subsets=[]
            if self._verbose>=1:
                print 'subsets', subsets_k
            for subset in subsets_k:
                covered=True
                for _set in sets_to_cover:
                    if len(subset.intersection(_set))==0:
                        covered=False
                if covered:
                    covering_subsets.append(subset)
            if covering_subsets:
                if self._verbose>=2:
                    print 'covering',covering_subsets
                return covering_subsets
            k+=1
            if k>6:
                self._algForParallelAdd.addLog('Stopped afer searching subsets of size '+str(k-1)+ '.')
                raise  RuntimeError('Stopped afer searching subsets of size '+str(k-1)+ '.')