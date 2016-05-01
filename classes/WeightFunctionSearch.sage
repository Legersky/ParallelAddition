load('WeightFunction.sage')

class WeightFunctionSearch(object):
    """
    searching for Weight Function
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
        if self._method==None:
            self._method='2b'     #set the default method

        methods2_letter={'2a':9,'2b':15,'2c':22, '2d':23, '2e':14}
        if self._method in methods2_letter:
            self._method=methods2_letter[self._method]

        self._k=0
        self._numbersOfSavedCombinations=[]

        self._nondecreasing_prev={}
        self._nondecreasing={}

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
        size_difference=1
        Qw_prev=self._Qw_w[w_tuple[0:-1]]
        while size_difference>0:
            Qww=self._findQw_once(w_tuple,Qw_prev)
            size_difference=len(Qw_prev)-len(Qww)
            Qw_prev=Qww

        if len(self._Qw_w[w_tuple[0:-1]])==len(Qww):
            self._addNondecreasingTuple(w_tuple)
            self._checkCycles(w_tuple)
        return Qww

    def _checkCycles(self, w_tuple):
        w=w_tuple[1:]
        def isSublist(_list, _sublist):
            for i in range(0,len(_list)-len(_sublist)+1):
                if _list[i:i+len(_sublist)]==_sublist:
                    return True
            return False

        def find_next_letter(_w,witness_seq):
            w_without_first=tuple(_w[1:])
            if w_without_first in self._nondecreasing_prev:
                for x in self._nondecreasing_prev[w_without_first]:
                    w_new=w_without_first+(x,)
                    if self._verbose>=2:
                        print w_new
                    if isSublist(witness_seq,list(w_new)):
                        self._algForParallelAdd._cycled=True
                        raise RuntimeErrorParAdd("The sequence "+str(witness_seq+[x])[0:-1]+", ... ,"+str(w_new)[1:-1]+", ...]"+" leads to an infinite loop.")
                    else:
                        new_witness_seq=witness_seq+[x]
                        find_next_letter(w_new,copy(new_witness_seq))
            else:
                if self._verbose>=2:
                    print '--------', witness_seq

        if tuple(w[0:-1]) in self._nondecreasing_prev:
            if w[-1] in self._nondecreasing_prev[w[0:-1]]:
                #self._algForParallelAdd.addLog("Checking cycles for " + str(w_tuple))
                find_next_letter(w,list(w))



    def _addNondecreasingTuple(self,w):
        w_without_last=tuple(w[0:-1])
        if w_without_last in self._nondecreasing:
            self._nondecreasing[w_without_last].append(w[-1])
        else:
            self._nondecreasing[w_without_last]=[w[-1]]

    def _findQw_once(self,w_tuple,Qw_prev):
        #find set of possible weight coefficients for input w_tuple
        w_tuple_without_first=w_tuple[1:]
        w0=w_tuple[0]
        if w_tuple_without_first in self._Qw_w:
            C=self._algForParallelAdd.sumOfSets([w0],self._Qw_w[w_tuple_without_first])

            #Qw_prev=self._Qw_w[w_tuple[0:-1]]
            Qww=[]
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

            to_add=[]

            if self._method ==10:    #each value covered separately by the point closest to point of gravity of covering values
                raise ValueErrorParAdd('Method 10 has been deleted. (Bez synergii to vubec nefunguje)')

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
                else:

                    if self._method ==0:    	    #original - add the first element in the first shortest list
                        num=2
                        while not to_add:
                            for covered in C_covered_by:
                                if len(C_covered_by[covered])==num:    #then add first value of list with length num
                                    to_add.append(C_covered_by[covered][0])
                                    break
                            num+=1

                    elif self._method ==1: #find the smallest covering coefficients from the shortest lists
                        num=2
                        while not to_add:
                            list_of_shortest=[]
                            for covered in C_covered_by:
                                if len(C_covered_by[covered])==num:
                                    list_of_shortest.append(Set(C_covered_by[covered]))
                            if list_of_shortest:
                                to_add=self._minimalCovering(list_of_shortest)[0]
                            num+=1

                    elif self._method in [2,3,4,7,8,11,22,12,23,15,21]:
                        num=2
                        while not to_add:
                            shortest=[]
                            for covered in C_covered_by:
                                if len(C_covered_by[covered])==num:
                                    shortest+=C_covered_by[covered]
                            if shortest:
                                if self._method==2:    	    #random from the shortest lists
                                    chosen_element=shortest[ZZ.random_element(len(shortest))]
                                elif self._method==3:        #pick element from the shortest lists lexicographically according to coordinates in lattice
                                    chosen_element=self._pick_element(shortest)
                                elif self._method==4:        #pick element from the shortest list which is the closest (according to lattice) to rounded center of gravity of points in shortest lists
                                    chosen_element=self._pick_element_close_PoG_by_lattice(shortest,self.point_of_gravity(shortest))
                                elif self._method==7:        #pick element from the shortest list which is the closest (in absolute value) to rounded center of gravity of points in shortest lists
                                    chosen_element=self._pick_element_close_PoG(shortest,self.point_of_gravity(shortest))
                                elif self._method==8:    #pick element from the shortest list which is the closest (in absolute value) to center of gravity of points in shortest lists
                                    chosen_element=self._pick_element_close_PoG_CC(shortest)
                                elif self._method==11:    #pick element from the shortest lists which is the smallest (in absolute value)   PROBLEM - implementation dependent
                                    chosen_element=self._algForParallelAdd._findSmallest(shortest)
                                elif self._method==22:    #pick element from the shortest lists which is the smallest (in absolute value)
                                    chosen_element=self._pick_element(self._algForParallelAdd._findAllSmallest(shortest))
                                elif self._method==12:    #pick element from the shortest lists which is the smallest (beta-norm)
                                #PROBLEM - implementation dependent
                                    chosen_element=self._algForParallelAdd._findSmallest_norm(shortest)
                                elif self._method==23:    #pick element from the shortest lists which is the smallest (beta-norm)
                                    chosen_element=self._pick_element(self._algForParallelAdd._findAllSmallest_norm(shortest))
                                elif self._method==15:    #pick element from the shortest lists which is closest to already added (absolute value)
                                    chosen_element=self._pick_element_closest_to_point(shortest, self.point_of_gravity_CC(Qww))
                                elif self._method==21:    #pick element from the shortest lists which is closest to already added (beta norm)
                                    chosen_element=self._pick_element_closest_to_point_betaNorm(shortest, self.point_of_gravity_Qomega(Qww))

                                if chosen_element!=None:
                                    to_add=[chosen_element]
                            num+=1

                    elif self._method in [5,9,17]:
                        elements=[]
                        for covered in C_covered_by:
                            elements+=C_covered_by[covered]        #adding all

                        if self._method==5:        #pick element from all resting lists which is the closest (according to lattice) to rounded center of gravity of points in all resting lists
                            to_add=[self._pick_element_close_PoG_by_lattice(elements, self.point_of_gravity(elements))]
                        elif self._method==9:        #pick element from all resting lists which is the closest (in absolute value) to center of gravity of points in all resting lists
                            to_add=[self._pick_element_close_PoG_CC(elements)]
                        elif self._method==17:    #pick element from all resting lists which is the closest (in beta norm) to the center of gravity of already added
                            to_add=[self._pick_element_closest_to_point_betaNorm(elements, self.point_of_gravity_Qomega(Qww))]

                    elif self._method==6:    	    #find the smallest covering coefficients from all resting lists
                        if not to_add:
                            list_of_all=[]
                            for covered in C_covered_by:
                                list_of_all.append(Set(C_covered_by[covered]))
                            to_add=self._minimalCovering(list_of_all)[0]

                    elif self._method in [13,14,16,24]:
                            occur={}
                            for covering in C_covered_by.values():
                                for q in covering:
                                    if q not in occur:
                                        occur[q]=1
                                    else:
                                        occur[q]+=1
                            max_occur=0
                            q_with_max_occur=[]
                            for q in occur:
                                if occur[q]>max_occur:
                                    q_with_max_occur=[q]
                                    max_occur=occur[q]
                                elif occur[q]==max_occur:
                                    q_with_max_occur.append(q)

                            if self._method ==13:    	    #highest occurrencies, closest to 0 in beta-norm
                                to_add=[self._algForParallelAdd._findSmallest_norm(q_with_max_occur)]
                            if self._method ==24:    	    #highest occurrencies, closest to 0 in beta-norm
                                to_add=[self._pick_element(self._algForParallelAdd._findAllSmallest_norm(q_with_max_occur))]
                            elif self._method ==14:    	    #highest occurrencies, closest center of gravity of already added (in absolute value)
                                to_add=[self._pick_element_closest_to_point(q_with_max_occur, self.point_of_gravity_CC(Qww))]
                            elif self._method ==16:    	    #highest occurrencies, closest center of gravity of already added (in beta norm)
                                to_add=[self._pick_element_closest_to_point_betaNorm(q_with_max_occur, self.point_of_gravity_Qomega(Qww))]

                    elif self._method in [18,19,20]:        #according to alphabet PROBLEM - implementation dependent
                        elements=[]
                        for covered in C_covered_by:
                            elements+=C_covered_by[covered]
                        if Qww:
                            cov_alph=self.coveringAlphabets(Qww,w_tuple[0])
                            for alph in cov_alph:
                                if self._method in [18,20]:
                                    to_add=alph.intersection(Set(elements)).list()
                                    if to_add:
                                        break
                                elif self._method ==19:
                                    to_add+=alph.intersection(Set(elements)).list()

                        if not to_add:
                            if self._method in [18,19]:
                                to_add=[self._algForParallelAdd._findSmallest(elements)]
                            elif self._method ==20:
                                #to_add=[self._algForParallelAdd._findGreatest(elements)]
                                to_add=[self._algForParallelAdd._findSmallest_norm(elements)]
                    else:
                        raise  ValueErrorParAdd("Method number %s for WeightFunctionSearch is not implemented" % self._method)

                for covered in copy(C_covered_by):
                    for added in to_add:
                        if added in C_covered_by[covered]:
                            C_covered_by.pop(covered)    #remove covered elements from dictionary
                            break

                if self._verbose>=2:
                    print 'Elements to add:', to_add
                Qww+=to_add


            if self._verbose>=1:
                print "Qw_w for ", w_tuple, " before completing: "
                print Qww

            if self._verbose>=1:
                print "Qw_w for ", w_tuple, " was found: "
                print Qww

            #self._Qw_w[w_tuple]=self.convex(w_tuple,Qww)
            self._Qw_w[w_tuple]=Qww
            #if len(Qw_prev)==len(Qww) and len(Qww)>1:
             #   print w_tuple



#            self.opravy(w_tuple)
            return Qww
        else:
            raise  RuntimeErrorParAdd("There is no Qww for: ", w_tuple_without_first)

    def findWeightFunction(self, max_input_length):
        # checks different w \in alphabet + alphabet, it extends the window if there is no unique weight coefficient
        betaQ=[]
        for q in self._weightCoefSet:
            betaQ.append(self._base*q)
        if not Set(self._algForParallelAdd.sumOfSets(self._algForParallelAdd._inputAlphabet, self._weightCoefSet)).issubset(Set(self._algForParallelAdd.sumOfSets(self._alphabet, betaQ))):
            raise RuntimeErrorParAdd('B+Q is not subset of A+beta Q.')
        self._Qw_w[()]=self._weightCoefSet
        combinations=[()]
        self._k=0
        while combinations:
            if self._k>=max_input_length:
                raise  RuntimeErrorParAdd("Inputs are longer than given maximum: "+ str(max_input_length))
            num_prev_comb=len(combinations)
            combinations=self._find_weightCoef_for_comb_B(combinations)
            self._k+=1
            self._numbersOfSavedCombinations.append(num_prev_comb*len(self._B) - len(combinations))
            if self._verbose>=1: print "Length of the window: ", self._k,", Number of saved combinations of input digits: " ,self._numbersOfSavedCombinations[-1], ", To next iteration: " ,len(combinations)
            self._algForParallelAdd.addLog("Length of the window: "+ str(self._k) + ", Number of saved combinations of input digits: " + str(self._numbersOfSavedCombinations[-1]) + ", To next iteration: " + str(len(combinations)))

            self._nondecreasing_prev=self._nondecreasing
            self._nondecreasing={}
        return self._weightFunction

    def check_one_letter_inputs(self, max_input_length):
        #check if there is a unique weight coefficient for inputs given by repetition of one letter
        betaQ=[]
        for q in self._weightCoefSet:
            betaQ.append(self._base*q)
        if not Set(self._algForParallelAdd.sumOfSets(self._algForParallelAdd._inputAlphabet, self._weightCoefSet)).issubset(Set(self._algForParallelAdd.sumOfSets(self._alphabet, betaQ))):
            raise RuntimeErrorParAdd('B+Q is not subset of A+beta Q.')

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
                    raise  RuntimeErrorParAdd("Inputs are longer than the given maximum: %s" %(max_input_length))
                w_tuple = w_tuple+(a,)
                Qww=self._findQw(w_tuple)    #find Qww for the tuple and save weight coefficient if there is only one element in Qww
                if self._verbose>=1:  print Qww
                if prevQww==Set(Qww):
                    self._algForParallelAdd.addLog("There is no unique weight coefficient for finite input gained by repetition of letter %s using method number %s" %(a,self._method))
                    self._algForParallelAdd._problematicLetters.append(a)
                    break
                if len(Qww)==1:
                    self._weightFunction.addWeightCoefToInput(w_tuple, Qww[0])
                    self._algForParallelAdd.addLog('The weight coefficient for the finite input gained by repetition of letter %s is %s' %(a, Qww[0]))
                inp_len+=1
                prevQww=Set(Qww)
            if len(w_tuple)>len(longest[0]):
                longest=[w_tuple]
            elif len(w_tuple)==len(longest[0]):
                longest.append(w_tuple)
        if self._algForParallelAdd._problematicLetters:
            raise  RuntimeErrorParAdd("There is no unique weight coefficient for finite input gained by repetition of letters %s using method number %s" %(self._algForParallelAdd._problematicLetters,self._method))
        return longest

    def _pick_element(self,elements):
        #pick the element with smallest absolute, then linear, quadratic... coefficient in Z[omega] (lexicographically)
        if elements:
            chosen=[]
            for elem in elements:
                chosen.append(self._algForParallelAdd._ring(elem))    #coercion into Z[omega]
            k=0
            while len(chosen)>1:
                min_k=[chosen[0]]
                for elem in chosen[1:]:
                    if elem.list()[k]<min_k[0].list()[k]:
                        min_k=[elem]
                    elif elem.list()[k]==min_k[0].list()[k]:
                        min_k.append(elem)
                chosen=copy(min_k)
                k+=1
                if k==self._algForParallelAdd.getMinPolynomial().degree():
                    break
            return chosen[0]
        else:
            return None

    def _pick_element_close_PoG_by_lattice(self,elements, PoG):
        #pick the element with the smallest absolute, then linear, quadratic... coefficient closest to PoG in Z[omega]
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
        #pick the element from elements which is closest in absolute value to the center of gravity PoG from Zomega
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
        #pick the element from elements which is closest in absolute to the center of gravity in CC
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

    def _pick_element_closest_to_point(self,elements, point):
        #pick the element from elements which is closest in absolute to the point
        if elements:
            min_abs=[elements[0]]
            for elem in elements[1:]:
                if abs(point-self._algForParallelAdd.ring2CC(elem))<abs(point-self._algForParallelAdd.ring2CC(min_abs[0])):
                    min_abs=[elem]
                elif abs(point-self._algForParallelAdd.ring2CC(elem))==abs(point-self._algForParallelAdd.ring2CC(min_abs[0])):
                    min_abs.append(elem)
            return self._pick_element(min_abs)
        else:
            return None

    def _pick_element_closest_to_point_betaNorm(self,elements, point):
        if elements:
            min_norm=[self._algForParallelAdd._ring.coerce(elements[0])]
            for elem in elements[1:]:
                elem=self._algForParallelAdd._ring.coerce(elem)
                if self._algForParallelAdd.betaNorm_vect(point-vector(elem.list()))<self._algForParallelAdd.betaNorm_vect(point-vector(min_norm[0].list())):
                    min_norm=[elem]
                elif self._algForParallelAdd.betaNorm_vect(point-vector(elem.list()))==self._algForParallelAdd.betaNorm_vect(point-vector(min_norm[0].list())):
                    min_norm.append(elem)
            return self._pick_element(min_norm)
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
            return 0
        for coef in self._algForParallelAdd._ring(sum(numbers)).list():
            point.append(round(coef/num))
        return self._algForParallelAdd.list2Ring(point)

    def point_of_gravity_Qomega(self, numbers):
        point=[]
        num=len(numbers)
        if num==0:
            return 0
        for coef in self._algForParallelAdd._ring(sum(numbers)).list():
            point.append(coef/num)
        return vector(point)

    def point_of_gravity_CC(self, numbers):
        if numbers:
            point=0
            for num in numbers:
                point+=self._algForParallelAdd.ring2CC(num)
            return point/len(numbers)
        else:
            return 0

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
                raise   RuntimeErrorParAdd('Stopped afer searching subsets of size '+str(k-1)+ '.')

    def opravy(self, w_tuple):
        omega=alg.getRingGenerator()
        if w_tuple==(4,):
            self._Qw_w[w_tuple]+=[-omega-2,-2*omega-2]
        if w_tuple==(-4,):
            self._Qw_w[w_tuple]+=[omega+2,2*omega+2]
        if w_tuple==(3,):
            self._Qw_w[w_tuple]+=[-2, -2-omega, 0, -omega, -2+omega]
        if w_tuple==(3,3):
            self._Qw_w[w_tuple]+=[-2, 0]
        if w_tuple==(-3,):
            self._Qw_w[w_tuple]+=[2, 2+omega, 0, omega, 2-omega]
        if w_tuple==(-3,-3):
            self._Qw_w[w_tuple]+=[2, 0]
        if w_tuple==(2,):
            self._Qw_w[w_tuple]+=[ -3]
        if w_tuple==(-2,):
            self._Qw_w[w_tuple]+=[ 3]

    def convex(self, w_tuple, Qww):
        not_added=Set(self._Qw_w[w_tuple[0:-1]]).difference(Qww)
        pairs=Subsets(Qww,2)
        to_add=[]
        for el in not_added:
            for pair in pairs:
                ratio= self._algForParallelAdd.ring2NumberField(el-pair.list()[1])/self._algForParallelAdd.ring2NumberField(pair.list()[0]-pair.list()[1])
                if ratio in RR and 0<ratio and ratio<1:
                    to_add.append(el)
                    break
        return Set(Qww+to_add).list()

    def coveringAlphabets(self,Q,shift):
        Q=Set(Q).list()
        coveringValues={}
        for q in Q:
            q_shifted=q+shift
            for a in self._alphabet:
                w=self._algForParallelAdd.divideByBase(q_shifted-a)
                if w!=None:
                    if w not in coveringValues:
                        coveringValues[w]=1
                    else:
                        coveringValues[w]+=1
        shifted_alphabets=[]
        for w in sorted(coveringValues, key=coveringValues.get, reverse=True):
            shifted_alph=[]
            for a in self._alphabet:
                shifted_alph.append(a+self._base*w)
            shifted_alphabets.append(Set(shifted_alph))
        return shifted_alphabets

