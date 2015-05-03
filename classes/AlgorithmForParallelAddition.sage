load('WeightCoefficientsSetSearch.sage')
load('WeightFunctionSearch.sage')
load('WeightFunction.sage')

class AlgorithmForParallelAddition(object):
    """
    zastresujici trida pro hledani algoritmu paralelniho scitani s abecedou v alphabetRing (Z[\omega]) s prepisovacim pravidlem x-base, base \in baseRing \subset alphabetRing
    """
    def __init__(self, minPol_str, embd, alphabet, base, name='NumerationSystem', inputAlphabet='', printLog=True, printLogLatex=False, verbose=0):
        P.<x>=ZZ[]
        minPol=sage.misc.sage_eval.sage_eval(minPol_str,locals={'x':x}, cmds='P.<x>=ZZ[]')
            #evaluation of minimal polynomial
        if not minPol.is_irreducible():
            raise ValueError("For the construction of Ring, polynomial %s must be irreducible." %minPol)
        if not minPol.is_monic():
            raise ValueError("For parallel addition algorithms, polynomial %s must be monic." %minPol)
        N.<ratRingGenator> = NumberField(minPol, embedding=embd)
            # Rational Polynomials with variable ratRingGenerator mod minPol, beta is the closest root of minPol to embd
        self._ratRingGen=N.gen()
            #the generator of rational polynomials
        self._genCCValue=CC(self._ratRingGen)
            #complex value of ring generator
        IntegerPolynomials.<t> = PolynomialRing(ZZ)
            #Integer polynomials with variable t
        Zomega.<omega> = PolynomialQuotientRing(IntegerPolynomials,IntegerPolynomials(N.polynomial()) )
            #construction of alphabetRing
        self._ring = Zomega
            #the ring (Z[omega])
        self._minPolynomial=Zomega.modulus()
            #minimal polynomial of generator of the ring, i.e. modulus of Z[omega]
        self._ringGenerator = Zomega.gen()
            #generator of alphabetRing (omega)
        def latexZomega(self):
            return self._polynomial._latex_('\\omega')  #self.parent().latex_variable_names()[0])
        self._ring.element_class._latex_=latexZomega
            #latex output
        self.setAlphabet(sage.misc.sage_eval.sage_eval(alphabet, locals={'omega':self._ringGenerator}))
            #alphabet
        self.setBase(sage.misc.sage_eval.sage_eval(base, locals={'omega':self._ringGenerator}))
            #base of numeration system
        if inputAlphabet:
            self.setInputAlphabet(sage.misc.sage_eval.sage_eval(inputAlphabet, locals={'omega':self._ringGenerator}))
            #different input alphabet (if None, then alphabet + alphabet is used)
        else:
            self._inputAlphabet=self.sumOfSets(self._alphabet, self._alphabet)
        self._weightCoefSet=[]
            #set of potential coefficients
        self._weightFunction = None
            #Weight Function
        self._name=name
            #name of the numeration system
        self._log=[]
            #list of logs
        self._printLog=printLog
            #log are printed if True
        self._printLogLatex=printLogLatex
            #log are printed using latex if True
        self._verbose=verbose

        self.addLog("Inicialization...")
        self.addLog("Numeration system: ")
        self.addLog(self._name, latex=True)
        self.addLog("Alphabet: ")
        self.addLog(self._alphabet, latex=True)
        self.addLog("Input alphabet: ")
        self.addLog(self._inputAlphabet, latex=True)
        self.addLog("Minimal polynomial of ring generator: ")
        self.addLog(self.getMinPolynomial(), latex=True)
        self.addLog("Embedding: ")
        self.addLog(self._genCCValue, latex=True)
        self.addLog("Base: ")
        self.addLog(self._base, latex=True)
        self.addLog("Minimal polynomial of base:")
        self.addLog(self._base.minpoly(), latex=True)

    def setAlphabet(self,A):
        self._alphabet=[]
        for a in A:
            if a in self._ring:
                self._alphabet.append(a)    #adding to alphabet
            else:
                raise TypeError("Value %s is not element of Ring (omega = %s (root of %s)) so it cannot be used for alphabet." %(a, self._genCCValue, self._minPolynomial))

    def setInputAlphabet(self,B):
        alphabetPlusAlphabet=self.sumOfSets(self._alphabet, self._alphabet)
        if B:
            self._inputAlphabet=[]
            for b in B:
                if b in alphabetPlusAlphabet:
                    self._inputAlphabet.append(b)    #adding to input alphabet
                else:
                    raise ValueError("Value %s is not element of alphabet + alphabet so it cannot be used for inputAlphabet." %b)
            for a in self._alphabet:
                if not a in self._inputAlphabet:
                    raise ValueError("Value %s from alphabet must be used in the inputAlphabet." %a)
            if len(self._inputAlphabet)==len(self._alphabet):
                raise ValueError("Input alphabet cannot equal to alphabet.")
        else:
            self._inputAlphabet=alphabetPlusAlphabet

    def setVerbose(self,verb):
        self._verbose=verb

    def setBase(self, base):
        if base in self._ring:
                self._base=self._ring.coerce(base)
                self._minimalPolynomialOfBase=self._base.minpoly()
        else:
            raise TypeError("Value %s is not element of Ring (omega = %s (root of %s)) so it cannot be used for base." %(a, self._genCCValue, self._minPolynomial))

    def __repr__(self):
        return "Instance of AlgorithmForParallelAddition with beta %s (root of %s) and alphabet %s" %(self._genCCValue, self._minPolynomial, self._alphabet)

    def getMinPolynomial(self):
        #returns modulus of Ring
        return self._minPolynomial

    def getMinPolynomialOfBase(self):
        #returns modulus of BaseRing
        return self._minimalPolynomialOfBase

    def getRingGenerator(self):
        #returns generator of Ring
        return self._ringGenerator

    def getBase(self):
        #returns base
        return self._base

    def getAlphabet(self):
        return self._alphabet

    def getInputAlphabet(self):
        return self._inputAlphabet

    def getName(self):
        return self._name

    def getWeightCoefSet(self):
        return self._weightCoefSet

    def getWeightFunction(self):
        return self._weightFunction

    def getDictOfSetting(self):
        setting={}
        setting['alphabet']=str(self._alphabet)
        setting['inputAlphabet']=str(self._inputAlphabet)
        setting['minPol_alpGen']=str(self._minPolynomial(x).expand())
        setting['base']=str(self._base)
        setting['embedding']=self._genCCValue
        setting['name']=self._name
        return setting

    def sumOfSets(self,A,B):
        #outputs set sum of A and B if A and B are subsets of Ring
        for a in A+B:
            if not(a in self._ring):
                raise TypeError("Value %s is not element of Ring (omega = %s (root of %s))." %(a, self._genCCValue, self._minPolynomial))
        res=Set([])
        for a in A:
            for b in B:
                res=res+Set([a+b])
        return res.list()

    def ring2NumberField(self, num_from_ring):            #puvodne getValue
        #converts number from Ring to NumberField
        res=0
        coef=num_from_ring.list()
        coef.reverse()
        for a in coef:    #Horner scheme
            res*=self._ratRingGen
            res+=a
        return res

    def list2BaseRing(self, _digits):        #puvodne listToNumber
        #converts list [a_0, a_1, ..., a_k] to a_0 + a_1*base + ... + a_k*base^k
        res=0
        digits=copy(_digits)
        digits.reverse()
        for a in digits:    #Horner scheme
            res*=self._base
            res+=a
        return res

    def list2Ring(self, _digits):
        #converts list [a_0, a_1, ..., a_k] to a_0 + a_1*alphabetGen + ... + a_k*alphabetGen^k
        res=0
        digits=copy(_digits)
        digits.reverse()
        for a in digits:    #Horner scheme
            res*=self._ringGenerator
            res+=a
        return res

    def ring2CC(self, num_from_ring):        #puvodne getComplexValue
        #converts numbers from Ring to complex
        return CC(self.ring2NumberField(num_from_ring))

    def plot(self, nums_from_ring):
        #plots numbers from Ring
        to_plot = []
        allReal=True
        zeros=[]
        for num in nums_from_ring:
            to_plot.append(self.ring2CC(num))
            zeros.append(0)
            if not self.ring2CC(num) in RR:
                allReal=False
        if self._verbose==1:
            print "Plotting:"
            show(nums_from_ring)
        if allReal:
            return list_plot(zip(to_plot,zeros), color='red')
        else:
            return list_plot(to_plot, color='red')

    def _findWeightCoefSet(self,method):
        #finds and sets Weight Coefficients set
        weightCoefSet=WeightCoefficientsSetSearch(self,method)
        self._weightCoefSet=copy(weightCoefSet.findWeightCoefficientsSet())
        return self._weightCoefSet

    def _findWeightFunction(self,method):
        #finds and sets Weight Function using the set of weight coefficients
        if not self._weightCoefSet:
            raise ValueError("There are no values in the weight coefficient set Q.")
        else:
            self._weightFunSearch=WeightFunctionSearch(self, self._weightCoefSet, method)
            self._weightFunction = copy(self._weightFunSearch.findWeightFunction())

    def findWeightFunction(self, method_weightCoefSet=2, method_weightFunSearch=3):
        #finds and sets Weight Function
        self.addLog("Searching the Weight Coefficient Set...")
        self._findWeightCoefSet(method_weightCoefSet)

        self.addLog("The Weight Coefficient Set is:")
        self.addLog(self._weightCoefSet,latex=True)
        self.addLog("Number of elements: " + str(len(self._weightCoefSet)))
        show(self.plot(self.getWeightCoefSet()))

        self.addLog("Searching the Weight Function...")
        self._findWeightFunction(method_weightFunSearch)
        self.addLog("Info about Weight Function:")
        self.addLog("Maximal input length: %s" %self._weightFunction.getMaxLength())
        self.addLog("Number of inputs: "+ str(len(self._weightFunction.getMapping().keys())))


    def printWeightFunction(self):
        print "Weight Function for RingGenerator omega %s (root of %s), alphabet %s and input alphabet %s:" %(self._genCCValue, self._minPolynomial, self._alphabet, self._inputAlphabet)
        self._weightFunction.printMapping()

    def printWeightFunctionInfo(self):
        print "Info about Weight Function for RingGenerator omega %s (root of %s), alphabet %s and input alphabet %s" %(self._genCCValue, self._minPolynomial, self._alphabet, self._inputAlphabet)
        if not self._weightFunction is None:
            self._weightFunction.printInfo()
        else:
            "There is no Weight Function."

    def printWeightCoefSet(self):
        print "Weight Coefficient Set is:"
        show(self._weightCoefSet)
        print "Number of elements: ", len(self._weightCoefSet)

    def printLatexInfo(self):
        print "Numeration System:", self._name, '\n'
        print "Alphabet: " + '$' + latex(self.getAlphabet()) + '$\n'
        print "Input alphabet: " + '$' + latex(self.getInputAlphabet()) + '$\n'
        print "Base: " + '$' + latex(self.getBase()) + '$\n'
        print "Minimal polynomial of base: " + '$' + latex(self.getBase().minpoly()) + '$\n'
        print "Weight Coefficient Set:"
        print "\\begin{dmath*}"
        print latex(self._weightCoefSet)
        print "\\end{dmath*}"
        print '\n'
        print "Number of elements in the weight coefficient set: " + '$' + latex(len(self._weightCoefSet)) + '$\n'
        print "Weight function Info:\n"
        if self._weightFunction:
            self._weightFunction.printLatexInfo()

    def saveInfoToTexFile(self, filename):
        with open(filename+".tex", 'w') as fp:
            stdout = sys.stdout
            sys.stdout = fp

            print "\\documentclass{article}"
            print "\\usepackage[utf8]{inputenc}"
            print "\\usepackage{amsmath, amsthm}"
            print "\\usepackage{breqn}"
            print "\n"

            print "\\textwidth 17 cm \\textheight 27 cm"
            print "\n"

            print "\\begin{document}"
            self.printLatexInfo()
            print '\\end{document}'

            sys.stdout = stdout
        self.addLog("Info about algorithm for parallel addition saved to "+filename+".tex")

    def saveLog(self, filename):
        with open(filename+"_log.txt", 'w') as fp:
            stdout = sys.stdout
            sys.stdout = fp

            for log in self._log:
                print log

            sys.stdout = stdout
        self.addLog("Log saved to "+filename+"_log.txt")

    def saveUnsolvedInputsToCsv(self, filename):
        with open(filename+"_unsolved_inputs_after_interrupt.csv", 'w') as fp:
            stdout = sys.stdout
            sys.stdout = fp
            self._weightFunSearch._weightFunction.printCsvMapping()
            self._weightFunSearch.printCsvQxx()
            sys.stdout = stdout
        self.addLog("Solved and unsolved inputs saved to "+filename+"_unsolved_inputs_after_interrupt.csv")

    def saveLocalConversionToCsvFile(self, filename):
        self.addLog("Saving local conversion...")
        with open(filename+"-localConversion.csv", 'w') as fp:
            stdout = sys.stdout
            sys.stdout = fp

            header='x_j; '
            for i in range(1, self._weightFunction.getMaxLength()+1):
                header=header+ ('x_j-%s; ' %i)
            header=header+ 'output digit'
            print header

            allNumbers = list(CartesianProduct(*(self._inputAlphabet for i in range(0,self._weightFunction.getMaxLength()+1))))
            for num_list in allNumbers:
                out_digit=self.localConversion(num_list)
                line=''
                for digit in num_list:
                    line=line+ str(digit)+'; '
                line=line+ str(out_digit)
                print line

            sys.stdout = stdout
        self.addLog("Local conversion ("+str(len(allNumbers))+  " lines) saved to "+filename+"-localConversion.csv")

    def saveWeightFunctionToTexFile(self, filename):
        with open(filename+"-weightFunction.tex", 'w') as fp:
            stdout = sys.stdout
            sys.stdout = fp

            print "\\documentclass{article}"
            print "\\usepackage[utf8]{inputenc}"
            print "\usepackage{amsmath, amsthm}"
            print "\n"
            print "\\begin{document}"

            self._weightFunction.printLatexMapping()

            print '\end{document}'

            sys.stdout = stdout
        self.addLog("Weight function saved to "+filename+"-weightFunction.tex")

    def saveWeightFunctionToCsvFile(self, filename):
        with open(filename+"-weightFunction.csv", 'w') as fp:
            stdout = sys.stdout
            sys.stdout = fp
            header='x_j; '
            for i in range(1, self._weightFunction.getMaxLength()):
                header=header+ ('x_j-%s; ' %i)
            header=header+ 'weight coefficient'
            print header

            self._weightFunction.printCsvMapping()

            sys.stdout = stdout
        self.addLog("Weight function saved to "+filename+"-weightFunction.csv")

    def addParallel(self,a,b):
        #a, b are numbers in BaseRing saved as lists, a=\sum_{i=0}^n a[i] base^i, a[i] \in alphabet A
        for a_i in a:
            if not a_i in self._alphabet:
                raise ValueError("The digit %s of the number %s is not in the alphabet A." %(a_i,a))
        for b_i in b:
            if not b_i in self._alphabet:
                raise ValueError("The digit %s of the number %s is not in the alphabet A." %(b_i,b))
        x=[]
        for i in range(0, min(len(a),len(b))):    #adding digits of common part
            x.append(a[i]+b[i])
        if len(a)<len(b):            #prolonging to the longer one
            x.extend(b[len(a):])
        else:
            x.extend(a[len(b):])
        z=self.parallelConversion(x)
        return z

    def parallelConversion_old(self,x):
        #converts x with digits from input alphabet to number in BaseRing with digits in alphabet A
        if self._verbose== 2 : print "Converting: ", x
        maxLength=self._weightFunction.getMaxLength()
        x.extend([0]*(maxLength+1))    #padding by zeros in greater exponents
        #minLength=1
        z=[]
        q_i_prev=0
        for i in range(0,len(x)):
            if not x[i] in self._inputAlphabet:
                raise ValueError("Digit %s is not in the input alphabet" %x[i])
        for i in range(0,len(x)):
            input_tuple=(x[i],)    #input to weight function
         #   for k in range(0,minLength-1):
         #       input_tuple= input_tuple + (x[i-k],)
            if self._verbose==2 : print "working with ", x[i], "in tuple" , input_tuple
            shift=1
            while not input_tuple in self._weightFunction.getMapping():    #until the input is found in the weight function
                input_tuple=input_tuple + (x[i-shift],)                    #take longer if not
                shift+=1
                if shift>maxLength:
                    raise RuntimeError("Input tuple " + str(input_tuple) + " is longer than maxLength of Weight function.")
            if self._verbose==2 : print "input of weight function:", input_tuple
            q_i=self._weightFunction(input_tuple)        #getting of output of weight function
            z.append(x[i]+q_i_prev-self._base*q_i)                    #conversion to alphabet A
            q_i_prev=q_i
            if self._verbose==2 :print "Converted digit:", z[-1]
        return z

    def parallelConversion(self,x):
        #converts x = [x_0, x_1, ...] with digits from input alphabet to number in BaseRing with digits in alphabet A
        if self._verbose== 2 : print "Converting: ", x
        maxLength=self._weightFunction.getMaxLength()
        x.extend([0]*(maxLength+1))    #padding by zeros in greater exponents
        z=[]
        q_i_prev=0
        for i in range(0,len(x)):
            #input_tuple=x[i:i+maxLength+1]    #input to weight function
            input_tuple=x[i-maxLength:i+1]    #input to weight function
            q_i=self._weightFunction(reversed(input_tuple))        #getting of output of weight function
            z.append(x[i]+q_i_prev-self._base*q_i)                    #conversion to alphabet A
            q_i_prev=q_i
            if self._verbose==2 :print "Converted digit:", z[-1]
        return z

    def parallelConversion_using_localConversion(self,x):
        #converts x = [x_0, x_1, ...] with digits from input alphabet to number in BaseRing with digits in alphabet A
        z=[]
        x=list(x)
        maxLength=self._weightFunction.getMaxLength()
        x.extend([0]*(maxLength+1))    #padding by zeros in greater exponents
        for i in range(0,len(x)):
            input_x=copy(x[0:i+1])
            input_x.reverse()
            z.append(self.localConversion(input_x))
        return z


    def localConversion(self,x):
        #outputs digit z_j to x = x_j x_j-1... with digits from input alphabet
        maxLength=self._weightFunction.getMaxLength()
        q_i_prev=self._weightFunction(x[1:1+maxLength+1])
        q_i=self._weightFunction(x[0:maxLength+1])
        return x[0]+q_i_prev-self._base*q_i        #conversion to alphabet A

    def sanityCheck_addition(self, num_digits):
        #tries to add all possible combinations of numbers with num_digits digits
        #returns number of errors
        errors=0
        allNumbers = list(CartesianProduct(*(self._alphabet for i in range(0,num_digits))))    #all posible number with num_digits digits from alphabet
        for (ind, a) in enumerate(allNumbers):
            for b in allNumbers[ind:]:                #testing all pairs
                a_AlphRing=self.list2BaseRing(a)
                b_AlphRing=self.list2BaseRing(b)
                aplusb=self.addParallel(a, b)
                if not self.list2BaseRing(aplusb) == (a_AlphRing+b_AlphRing):
                    if self._verbose>=1:
                        print 'problem: %s + %s' %(a, b)
                    errors+=1
        if self._verbose>=1: print "Number of errors", errors
        return errors

    def sanityCheck_conversion(self, num_digits):
        #tries to convert all possible number of lenght num_digits with digits from input alphabet
        allNumbers = list(CartesianProduct(*(self._inputAlphabet for i in range(0,num_digits))))
        errors=0
        self.addLog("Sanity check of %s digits..." %num_digits)
        for num_list in allNumbers:
            num_converted=self.parallelConversion(num_list)
            if not self.list2BaseRing(num_converted) == self.list2BaseRing(num_list):
                if self._verbose>=1:
                    print 'problem: %s does not equal to  %s' %(num_list, num_converted)
                errors+=1
        if self._verbose>=1:
            print "Tested: ", len(allNumbers)
            print "Number of errors", errors
        self.addLog("Tested: " + str(len(allNumbers)))
        self.addLog("Number of errors: " + str(errors))
        return errors

    def addLog(self,_log, latex=False):
        if self._printLog:
            if latex and self._printLogLatex:
                show(_log)
            else:
                print _log
                sys.stdout.flush()
        self._log.append(_log)

    def inputSettingToSageFile(self, filename):
        with open(filename+".sage", 'w') as fp:
            stdout = sys.stdout
            sys.stdout = fp

            print '#---------------INPUTS---------------'
            print '#Name of the numeration system'
            print 'name = \'', self._name, "'"
            print ''
            print '#Minimal polynomial of ring generator (use variable x)'
            print 'minPol =\'', self._minPolynomial(x).expand(), "'"
            print ''
            print '#Embedding (the closest root of minimal polynomial to this value is taken as the ring generator)'
            print 'omegaCC=', self._genCCValue
            print ''
            print '#Alphabet (use \'omega\' as ring generator)'
            print 'alphabet = \'', self._alphabet, "'"
            print ''
            print '#Input alphabet (if empty, A + A is used)'
            print 'inputAlphabet = \'', self._inputAlphabet, "'"
            print ''
            print '#Base (use \'omega\' as ring generator)'
            print 'base =\'' ,self._base, "'"
            print ''
            print ''
            print '#------------SAVING----------------'
            print '#save general info to .tex file'
            print 'info=True'
            print ''
            print '#save Weight function to .csv file'
            print 'WFcsv=True'
            print ''
            print '#save Local conversion to .csv file'
            print 'localConversionCsv=False'
            print ''
            print '#save Inputs setting'
            print 'saveSetting=True'
            print ''
            print '#save Log file'
            print 'saveLog=True'
            print ''
            print '#save Unsolved inputs after interruption'
            print 'saveUnsolved=True'
            print ''
            print '#run sanity check'
            print 'sanityCheck=True'

            sys.stdout = stdout
