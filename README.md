# ParallelAddition - implementation of the extending window method for construction of algorithms for parallel addition

For description of the method, see the Master thesis [Construction of algorithms for parallel addition.pdf](http://jan.legersky.cz/pdf/master_thesis_parallel_addition.pdf).
It contains also a more detailed description of the implementation.

For basic use, load **AlgorithmForParallelAddition.sage**, create an instance of `AlgorithmForParallelAddition` and call `findWeightFunction`.

We also provide an interface - a shell script with given parameters is executed. If the network access is enabled and the modul `gspread` is installed, then results of computation are automatically saved to [Google spreadsheet](https://docs.google.com/spreadsheets/d/1TnhrHdefHfHa0WSeVs4q6XVj3epjPlPlnoekE0E1xeM/edit?usp=sharing). The spreadsheet can be also used for loading input parameters. If you do not want to share results of your computations in this spreadsheet, remove **vysledkyParallel-b1ae50e4c6ea.json** file from your code folder.

We provide two options of loading inputs for running the implemented extending window method. SageMath must be installed as they are executed as shell scripts.

## ewm_inputs.sage
Launch in a shell by typing `sage ewm_inputs.sage`. The parameters are given in the head of the file **ewm_inputs.sage**.

There are four parts to be filled in:

 * The name of the numeration system, minimal polynomial of generator $\omega$, an approximate value of omega, the base beta, alphabet A, input alphabet B and k-block are set in the part INPUTS. Different methods of choice for Phase 1 and 2 can be set. If there are more methods in the lists, then methods for Phase 1 are compared first. Next, each distinct result is processed with each method for Phase 2.

 * For verification of output, `sanityCheck_conversion` is launched according to the boolean value in the part SANITY CHECK. 

 * The boolean values in the part SAVING determines which formats of the outputs are saved. All outputs are saved in the folder *./outputs/\<name>/*, where *\<name>* is the name of the numeration system. General information about the computation can be saved in the LaTeX format, a computed weight function and local digit set conversion in the CSV file format.  A log of the whole computation can be saved as a text file.

 * Figures of the alphabet, input alphabet or weight coefficients set are saved in the PNG format in the folder *./outputs/<name>/img/* according to the boolean values in the part IMAGES. Images of individual steps of both phases of the extending window method can be also saved. For Phase 2, searching for a weight coefficient  is plotted for given input digits.

The program prints out all inputs and then it computes a weight function by calling `findWeightFunction`. Intermediate weight coefficients sets in each iteration of Phase 1 and the obtained weight coefficients set Q are printed out. Non-convergence of Phase 2 for combinations given by repetition b is verified by `check_one_letter_inputs`. The processed length of window is showed during computing of Phase 2. At the end, the final length of window, elapsed time and info about saved outputs are printed. Results are also saved in the [Google spreadsheet](https://docs.google.com/spreadsheets/d/1TnhrHdefHfHa0WSeVs4q6XVj3epjPlPlnoekE0E1xeM/edit?usp=sharing) in the worksheet *results*; and *comparePhase1* if there are more methods for Phase 1.

## ewm_gspreadsheet.sage
The second option of loading input parameters is to run `sage ewm_gspreadsheet.sage`. Parameters are loaded from the worksheet inputs in the [Google spreadsheet](https://docs.google.com/spreadsheets/d/1TnhrHdefHfHa0WSeVs4q6XVj3epjPlPlnoekE0E1xeM/edit?usp=sharing). The column A marks whether a row should be tested. The columns B--G, i.e., Name, Alphabet, Input alphabet, Approximate value of ring generator omega, Minimal polynomial omega and Base must be filled. If the column Input alphabet is empty, then the input alphabet A+A is used. If the column H, i.e., k-block, contains a number k, then the alphabet and base are converted for k-block approach (empty means 1-block, that is classical parallel addition). Methods for Phase 1, resp. 2, are given in the header cell C1, resp. C2.

Program runs in the same way as before, the results are saved according to boolean values in SAVING. Notice that column A and cells with the methods may be changed after executing the script, but other cells or order of rows should not be modified. The reason is that the program reads the methods at the beginning and it remembers position of rows to be tested, but the parameters are loaded on the fly.


