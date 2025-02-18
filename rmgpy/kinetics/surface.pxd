###############################################################################
#                                                                             #
# RMG - Reaction Mechanism Generator                                          #
#                                                                             #
# Copyright (c) 2002-2021 Prof. William H. Green (whgreen@mit.edu),           #
# Prof. Richard H. West (r.west@neu.edu) and the RMG Team (rmg_dev@mit.edu)   #
#                                                                             #
# Permission is hereby granted, free of charge, to any person obtaining a     #
# copy of this software and associated documentation files (the 'Software'),  #
# to deal in the Software without restriction, including without limitation   #
# the rights to use, copy, modify, merge, publish, distribute, sublicense,    #
# and/or sell copies of the Software, and to permit persons to whom the       #
# Software is furnished to do so, subject to the following conditions:        #
#                                                                             #
# The above copyright notice and this permission notice shall be included in  #
# all copies or substantial portions of the Software.                         #
#                                                                             #
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE #
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     #
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         #
# DEALINGS IN THE SOFTWARE.                                                   #
#                                                                             #
###############################################################################

cimport numpy as np

from rmgpy.kinetics.model cimport KineticsModel
from rmgpy.kinetics.arrhenius cimport Arrhenius, ArrheniusEP
from rmgpy.quantity cimport ScalarQuantity, ArrayQuantity

################################################################################

cdef class StickingCoefficient(KineticsModel):
    
    cdef public ScalarQuantity _A
    cdef public ScalarQuantity _n
    cdef public ScalarQuantity _Ea
    cdef public ScalarQuantity _T0
    cdef public dict _coverage_dependence
    
    cpdef double get_sticking_coefficient(self, double T) except -1

    cpdef change_t0(self, double T0)

    cpdef fit_to_data(self, np.ndarray Tlist, np.ndarray klist, str kunits, double T0=?, np.ndarray weights=?, bint three_params=?)

    cpdef bint is_similar_to(self, KineticsModel other_kinetics) except -2

    cpdef bint is_identical_to(self, KineticsModel other_kinetics) except -2
    
    cpdef change_rate(self, double factor)

    cpdef to_html(self)

cdef class StickingCoefficientBEP(KineticsModel):

    cdef public ScalarQuantity _A
    cdef public ScalarQuantity _n
    cdef public ScalarQuantity _alpha
    cdef public ScalarQuantity _E0
    cdef public dict _coverage_dependence
    cpdef double get_sticking_coefficient(self, double T, double dHrxn=?) except -1
    cpdef double get_activation_energy(self, double dHrxn) except -1
    cpdef StickingCoefficient to_arrhenius(self, double dHrxn)
    cpdef bint is_similar_to(self, KineticsModel other_kinetics) except -2
    cpdef bint is_identical_to(self, KineticsModel other_kinetics) except -2
    cpdef change_rate(self, double factor)

################################################################################
cdef class SurfaceArrhenius(Arrhenius):
    cdef public dict _coverage_dependence
    pass
################################################################################
cdef class SurfaceArrheniusBEP(ArrheniusEP):
    cdef public dict _coverage_dependence
    pass

