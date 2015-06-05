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
        self._weightCoefSetIncrements=[]
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
        if self._printLogLatex: show(self.plot(self._inputAlphabet, color='blue')+self.plotAlphabet())
        self.addLog("Minimal polynomial of ring generator: ")
        self.addLog(self.getMinPolynomial(), latex=True)
        self.addLog("Embedding: ")
        self.addLog(self._genCCValue, latex=True)
        self.addLog("Base: ")
        self.addLog(self._base, latex=True)
        self.addLog("Minimal polynomial of base:")
        self.addLog(self._base.minpoly(), latex=True)
        if self._printLogLatex: show(self.plotLattice())

    def setAlphabet(self,A):
        self._alphabet=[]
        maxA=0
        for a in A:
            if a in self._ring:
                self._alphabet.append(a)    #adding to alphabet
                if abs(self.ring2CC(a))>maxA:
                    maxA=self.ring2CC(a)
            else:
                raise TypeError("Value %s is not element of Ring (omega = %s (root of %s)) so it cannot be used for alphabet." %(a, self._genCCValue, self._minPolynomial))
        self._maximumOfAlphabet=maxA

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
        maxB=0
        for b in self._inputAlphabet:
            if abs(self.ring2CC(b))>maxB:
                maxB=self.ring2CC(b)
        self._maximumOfInputAlphabet=maxB

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

    def getBaseCC(self):
        #returns complex value of base
        return self.ring2CC(self._base)

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

    def plot(self, nums_from_ring, labeled=True, color='red', size=20, fontsize=10):
        #plots numbers from Ring
        to_plot = []
        allReal=True
        zeros=[]
        label_plot=plot([])
        for num in nums_from_ring:
            numCC=self.ring2CC(num)
            to_plot.append(numCC)
            zeros.append(0)
            if labeled:
                label_plot+=text('$'+latex(num)+ '$', self.getCoordinates(num)+vector([0.1,0.1]) ,
                                 color=color, horizontal_alignment='left', fontsize=fontsize )
            if not self.ring2CC(num) in RR:
                allReal=False
        if self._verbose==1:
            print "Plotting:"
            show(nums_from_ring)
        if allReal:
            p=list_plot(zip(to_plot,zeros), color=color,  size=size, axes_labels=['Re', 'Im'])
        else:
            p=list_plot(to_plot, color=color,  size=size, axes_labels=['Re', 'Im'])
        if labeled:
            p+=label_plot
        p.set_aspect_ratio(1)
        return p

    def addWeightCoefSetIncrement(self, increment):
        self._weightCoefSetIncrements.append(increment)

    def _findWeightCoefSet(self, max_iterations, method):
        #finds and sets Weight Coefficients set
        weightCoefSet=WeightCoefficientsSetSearch(self,method)
        self._weightCoefSet=copy(weightCoefSet.findWeightCoefficientsSet(max_iterations))
        return self._weightCoefSet

    def _findWeightFunction(self, max_input_length,method):
        #finds and sets Weight Function using the set of weight coefficients
        if not self._weightCoefSet:
            raise ValueError("There are no values in the weight coefficient set Q.")
        else:
            self._weightFunSearch=WeightFunctionSearch(self, self._weightCoefSet, method)
            self.addLog("Checking one letter inputs...")
            longest=self._weightFunSearch.check_one_letter_inputs(max_input_length)
            self.addLog("The longest inputs are:")
            self.addLog(longest, latex=True)
            self.addLog("Length of one letter input: %s: " %len(longest[0]))
            self.addLog("Number of letters with longest input: %s" %len(longest))
            self._weightFunction = copy(self._weightFunSearch.findWeightFunction(max_input_length))

    def findWeightFunction(self, max_iterations, max_input_length, method_weightCoefSet=2, method_weightFunSearch=4):
        #finds and sets Weight Function
        self.addLog("Searching the Weight Coefficient Set using method %s..." %method_weightCoefSet)
        self._findWeightCoefSet(max_iterations,method_weightCoefSet)

        self.addLog("The Weight Coefficient Set is:")
        self.addLog(self._weightCoefSet,latex=True)
        self.addLog("Number of elements: " + str(len(self._weightCoefSet)))
        if self._printLogLatex: show(self.plotWeightCoefSet(estimation=True))

        self.addLog("Searching the Weight Function using method %s..." %method_weightFunSearch)
        self._findWeightFunction(max_input_length, method_weightFunSearch)
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
                line=' '
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

    def parallelConversion(self,_x):
        x=copy(_x)
        #converts x = [x_0, x_1, ...] with digits from input alphabet to number in BaseRing with digits in alphabet A
        if self._verbose== 2 : print "Converting: ", x
        maxLength=self._weightFunction.getMaxLength()
        x.extend([0]*(maxLength+1))    #padding by zeros in greater exponents
        x[:0]=([0]*(maxLength))    #prepending zeros in smaller exponents
        z=[]
        q_i_prev=0
        if self._verbose>=2:
            print 'Converting: ', _x
        for i in range(maxLength,len(x)):
            #input_tuple=x[i:i+maxLength+1]    #input to weight function
            input_tuple=x[i-maxLength:i+1]    #input to weight function
            q_i=self._weightFunction(reversed(input_tuple))        #getting weight coefficient
            z_i=x[i]+q_i_prev-self._base*q_i
            if not z_i in self._alphabet:
                raise RuntimeError("Digit %s of sequence %s was converted to %s which is not in the alphabet A!" %(x[i],x,z_i))
            z.append(z_i)                    #conversion to alphabet A
            q_i_prev=q_i
            if self._verbose==2 :print "Converted digit:", z[-1]
        if self._verbose>=2:
            print '----------> ', z
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
        z_i=x[0]+q_i_prev-self._base*q_i        #conversion to alphabet A
        if not z_i in self._alphabet:
            raise RuntimeError("Digit %s of sequence %s was converted to %s which is not in the alphabet A!" %(x[0],x,z_i))
        return z_i

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
            if self._verbose>=1:
                print 'Converting', num_list
                print '----------> ', num_converted
            if not self.list2BaseRing(num_converted) == self.list2BaseRing(num_list):
                if self._verbose>=0:
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
            print '#------------LIMITATIONS----------------'
            print '#maximum of iterations in searching weight coefficient set'
            print 'max_interations = 100'
            print ''
            print '#maximal length of input of weight function'
            print 'max_input_length =  100'
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
            print 'saveSetting=False'
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

    def getCoordinates(self, num):
        numCC=self.ring2CC(num)
        return vector([real(numCC), imag(numCC)])

    def plotPhase1(self,legend_xshift=8,
                  font_size=20,
                  font_size_legend=30,
                  axis_fontsize=15,
                  circle_big=100, #80,
                  circle_middle=50, #40,
                  circle_small=40): #30):
        def polygon_shifted(points,shift=0, enlargement=1, color='green'):
            vertices=[]
            for point in points:
                    vertices.append(enlargement*self.getCoordinates(point) +self.getCoordinates(shift))
            p= Polyhedron(vertices)
            tmp=CandidateSetSearch(alg)
            shift_divided=tmp.divideByBase(shift)
            return (p.plot(point=False, line=color, polygon=False)
                    +text('$\\beta\\cdot('+latex(shift_divided)+ ')$',
                          self.getCoordinates(shift) + vector([0,-0.2]) ,
                          color=color, horizontal_alignment='center',fontsize=font_size)
                    +text('$'+latex(shift_divided)+ '$',
                          self.getCoordinates(shift_divided) + vector([0,-0.2]) ,
                          color='black', horizontal_alignment='center',fontsize=font_size)
                   +self.plot([shift], color='green', size=circle_big, labeled=False)
                   +arrow(self.getCoordinates(shift_divided),self.getCoordinates(shift), color='black', linestyle='dashed', width=1))

        def legend(k,covered, new, alphabet):
            xshift=legend_xshift
            p=(text('$\\mathcal{Q}_{%s}$' %k,(xshift,2), color='red', horizontal_alignment='left', fontsize=font_size_legend)
                   + text('$\\mathcal{A} + \\mathcal{A} + \\mathcal{Q}_{%s}$' %k,(xshift,1), color='black', horizontal_alignment='left', fontsize=font_size_legend))
            if covered:
                p+=(text('$\\mathcal{A} + \\beta \\cdot \\mathcal{Q}_{%s}$' %k,(xshift,-1), color='orange', horizontal_alignment='left', fontsize=font_size_legend)
                    + text('$?\\, \\subset \\,?$',(xshift,0), color='black', horizontal_alignment='left', fontsize=font_size_legend))
            if new:
                p+=text('$\\mathcal{Q}_{%s} \\backslash  \\mathcal{Q}_{%s}$' %(k+1,k),(xshift,-2), color='blue', horizontal_alignment='left', fontsize=font_size_legend)
            if alphabet:
                p+=text('$\\mathcal{A} + \\beta \\cdot (' +latex(alphabet) + ')$',(xshift,-1), color='green', horizontal_alignment='left', fontsize=font_size_legend)
            return p

        Q=self._weightCoefSetIncrements

        betaQ=[]
        Q_total=[]
        for _Q in Q:
            Q_total+=_Q
            betaQ.append((self._base*vector(Q_total)).list())

        iterations=len(Q)
        q=range(0,iterations)
        q_new=range(0,iterations)

        to_cover=range(0,iterations)
        covered=range(0,iterations)
        Q_total=[]

        for i in range(0,iterations):
            Q_total+=Q[i]
            q[i]=self.plot(Q_total, color='red', size=circle_big, labeled=False, fontsize=font_size)
            q_new[i]=self.plot(Q[i], color='blue', size=circle_big, fontsize=font_size)
            covered[i]=self.plot(self.sumOfSets(self.getAlphabet(),betaQ[i]), color='orange', size=circle_small, labeled=False, fontsize=font_size)
            to_cover[i]=self.plot(self.sumOfSets(self.getInputAlphabet(),Q[i]), color='black', size=circle_middle, labeled=False,  fontsize=font_size)

        imgs=[q_new[0]+ text('$\\mathcal{Q}_{0}$',(6,2), color='blue', horizontal_alignment='left', fontsize=font_size_legend)]

        q_for_centers=[]
        centers=[]
        for i in range(1,iterations-1):
            q_for_centers.append(Q[i][0])
            centers.append(self._base*Q[i][0])

        for l in range(0,iterations-1):
            imgs+=[
                to_cover[l]+q[l] +legend(l, False, False, False),
                to_cover[l]+covered[l]+q[l] +legend(l, True, False, False),
                ]
            if l<iterations-2:
                imgs+=[to_cover[l]+covered[l]+q[l]+polygon_shifted(self.getAlphabet(),centers[l], 1.2) +legend(l, False, False, q_for_centers[l]),
                       to_cover[l]+covered[l]+q[l]+polygon_shifted(self.getAlphabet(),centers[l], 1.2)+q_new[l+1] +legend(l, False, True, q_for_centers[l])]


        imgs.append(q[l]+text('$\\mathcal{Q}=\\mathcal{Q}_{'+ str(iterations-2)+ '}$',(6,2), color='red', horizontal_alignment='left', fontsize=font_size_legend))

        xmin=0
        xmax=0
        ymin=0
        ymax=0
        for im in imgs:
            axes_range=im.get_axes_range()
            if axes_range['xmin']< xmin:
                xmin=axes_range['xmin']
            if axes_range['xmax']> xmax:
                xmax=axes_range['xmax']
            if axes_range['ymin']< ymin:
                ymin=axes_range['ymin']
            if axes_range['ymax']> ymax:
                ymax=axes_range['ymax']

        for im in imgs:
            im.set_axes_range(xmin,xmax,ymin,ymax)
            im.fontsize(axis_fontsize)
        return imgs

    def plotPhase2(self, digits,
                  legend_xshift=4,
                  legend_yshift=1,
                  legend_distance_factor=1,
                  font_size=25,
                  font_size_legend=35,
                  axis_fontsize=20,
                  circle_big=120, #80,
                  circle_middle=60, #40,
                  circle_small=50): #30):

        def polygon_shifted2(points,shift=0, enlargement=1, color='green'):
            vertices=[]
            for point in points:
                    vertices.append(enlargement*self.getCoordinates(point) +self.getCoordinates(shift))
            p= Polyhedron(vertices)
            tmp=CandidateSetSearch(alg)
            shift_divided=tmp.divideByBase(shift)
            return (p.plot(point=False, line=color, polygon=False)
                    +alg.plot([shift_divided], color='blue', size=circle_big, labeled=False))

        Q_covering=[]#[self._weightCoefSet]
        Q_to_cover=[]
        window_length=len(digits)
        for i in range(0,len(digits)+1):
            Q_covering.append(self._weightFunSearch._Qx_x[digits[0:i]])

            if len(Q_covering[-1])==1:
                window_length=i
                break
            Q_to_cover.append(self._weightFunSearch._Qx_x[digits[1:i+1]])

        betaQx=[]
        for _Q in Q_covering:
            betaQx.append((self._base*vector(_Q)).list())
        betaQx.append([])

        Qx_plot=[]
        Qx_plus_w=[]
        betaQx_plus_A=[]
        w_plot=self.plot([digits[0]], color='red', size=circle_big, fontsize=font_size)

        for i in range(0,window_length):
            Qx_plot.append(self.plot(Q_covering[i+1], color='blue', size=circle_big, labeled=True, fontsize=font_size))
            Qx_plus_w.append(self.plot(self.sumOfSets(Q_to_cover[i],[digits[0]]), color='black', size=circle_middle, labeled=False, fontsize=font_size))
            tmp=plot([])
            for q in Q_covering[i+1]:
                tmp+=polygon_shifted2(self.getAlphabet(),self._base*q,1.2)
            betaQx_plus_A.append(tmp)

        Qx_str_to_cover='\\mathcal{Q}'
        Qx_str_covering='\\mathcal{Q}'
        seq_covering=''
        seq_to_cover=''
        xshift=legend_xshift
        imgs2=[self.plot(self._weightCoefSet, color='blue', size=circle_big, labeled=False, fontsize=font_size)
               +text('$'+Qx_str_covering+'$' ,(xshift,1*legend_distance_factor+legend_yshift), color='blue', horizontal_alignment='left', fontsize=font_size_legend)]
        for l in range(0,window_length):
            seq_covering+=latex(digits[l])
            Qx_str_covering='\\mathcal{Q}_{['+seq_covering+']}'

            legend_black=text('$'+latex(digits[0])+'+'+Qx_str_to_cover+'$' ,(xshift,1*legend_distance_factor+legend_yshift), color='black', horizontal_alignment='left', fontsize=font_size_legend)
            imgs2.append(w_plot+Qx_plus_w[l]+legend_black)
            covering=(betaQx_plus_A[l]
                        +Qx_plus_w[l]
                      +legend_black)
            imgs2.append(covering
                        + text('$?\\, \\subset \\,?$',(xshift,0*legend_distance_factor+legend_yshift), color='black', horizontal_alignment='left', fontsize=font_size_legend)
                         +text('$\\mathcal{A} + \\beta \\cdot '+Qx_str_covering+'$',(xshift,-1*legend_distance_factor+legend_yshift), color='green', horizontal_alignment='left', fontsize=font_size_legend))
            imgs2.append(covering
                         + text('$\\subset$',(xshift,0*legend_distance_factor+legend_yshift), color='black', horizontal_alignment='left', fontsize=font_size_legend)
                         +text('$\\mathcal{A} + \\beta \\cdot '+Qx_str_covering+'$',(xshift,-1*legend_distance_factor+legend_yshift), color='green', horizontal_alignment='left', fontsize=font_size_legend)
                         + Qx_plot[l]
                        +text('$'+Qx_str_covering+'$' ,(xshift,-2*legend_distance_factor+legend_yshift), color='blue', horizontal_alignment='left', fontsize=font_size_legend))
            imgs2.append(Qx_plot[l]
                        +text('$'+Qx_str_covering+'$' ,(xshift,1*legend_distance_factor+legend_yshift), color='blue', horizontal_alignment='left', fontsize=font_size_legend))

            if l<window_length-1:
                seq_covering+=','
                seq_to_cover+=latex(digits[l+1])
            Qx_str_to_cover='\\mathcal{Q}_{['+seq_to_cover+']}'
            seq_to_cover+=','

        imgs2[-1]+=text('$=q('+seq_covering+')$' ,(xshift,0*legend_distance_factor+legend_yshift), color='blue', horizontal_alignment='left', fontsize=font_size_legend)

        xmin=0
        xmax=0
        ymin=0
        ymax=0
        for im in imgs2:
            axes_range=im.get_axes_range()
            if axes_range['xmin']< xmin:
                xmin=axes_range['xmin']
            if axes_range['xmax']> xmax:
                xmax=axes_range['xmax']
            if axes_range['ymin']< ymin:
                ymin=axes_range['ymin']
            if axes_range['ymax']> ymax:
                ymax=axes_range['ymax']

        for im in imgs2:
            im.set_axes_range(xmin,xmax-1,ymin,ymax)
            im.fontsize(axis_fontsize)

        return imgs2


    def saveImages(self,images, folder,name, img_size=10):
        d = os.path.dirname(folder+'/')
        if not os.path.exists(d):
            os.makedirs(d)
        k=1
        for im in images:
            im.save(folder+'/'+name+ '_image_{0}.png'.format(k), figsize=img_size)
            k+=1
        self.addLog("Images "+ name+ ' saved to '+ folder)

    def plotLattice(self,):
        self.addLog("Plotting lattice and shifts of alphabet centered in points divisible by base: ")

        lattice=[]

        max_range=3*self._maximumOfAlphabet
        max_coef=0
        while abs(max_coef+max_coef*self._genCCValue)<max_range:
            max_coef+=1

        for a in range(0,max_coef):
            for b in range(0,max_coef):
                lattice.append(a+b*self._ringGenerator)
                lattice.append(-a-b*self._ringGenerator)
                lattice.append(a-b*self._ringGenerator)
                lattice.append(-a+b*self._ringGenerator)

        def polygon_shifted(points,shift=0, enlargement=1.2, color='green'):
            vertices=[]
            for point in points:
                    vertices.append(enlargement*self.getCoordinates(point) +self.getCoordinates(shift))
            p= Polyhedron(vertices)
            return (p.plot(point=False, line=color, polygon=False))

        tiles=plot([])

        for point in lattice:
            if abs(self.ring2CC(point*self.getBase()))<max_range:
                tiles+=polygon_shifted(self.getAlphabet(),shift=self.getBase()*point)

        return self.plot(lattice)+tiles

    def plotAlphabet(self):
        return self.plot(self.getAlphabet())

    def plotWeightCoefSet(self,estimation=False):
        p=self.plot(self._weightCoefSet)
        if estimation:
            p+=circle((0,0),(self._maximumOfAlphabet+self._maximumOfInputAlphabet)/(abs(self.getBaseCC())-1))
        return p