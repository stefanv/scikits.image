# -*- python -*-
# cython: cdivision(True)

__all__ = ['sat', 'sat_sum']

import numpy as np
cimport cython
cimport numpy as np

cpdef np.ndarray sat(np.ndarray X):
    """Summed area table / integral image.

    The integral image contains the sum of all elements above and to the
    left of it, i.e.:

    .. math::

       S[m, n] = \sum_{i \leq m} \sum_{j \leq n} X[i, j]

    Parameters
    ----------
    X : ndarray of uint8
        Input image.

    Returns
    -------
    S : ndarray
        Summed area table.

    References
    ----------
    .. [1] F.C. Crow, "Summed-area tables for texture mapping,"
           ACM SIGGRAPH Computer Graphics, vol. 18, 1984, pp. 207-212.

    """
    cdef int s_rows, s_cols
    s_rows = X.shape[0]
    s_cols = X.shape[1]

    cdef np.ndarray[np.uint64_t, ndim=2] S = np.zeros((s_rows, s_cols),
                                                      dtype=np.uint64)

    # First column
    S[0, 0] = X[0, 0]
    for m in range(1, s_rows):
        S[m, 0] = X[m, 0] + S[m - 1, 0]

    # First row
    for n in range(1, s_cols):
        S[0, n] = X[0, n] + S[0, n - 1]

    for m in range(1, s_rows):
        for n in range(1, s_cols):
                S[m, n] = S[m - 1, n] + S[m, n - 1] \
                              - S[m - 1, n - 1] + X[m, n]

    return S

cpdef np.uint64_t sat_sum(np.ndarray sat, int r0, int c0, int r1, int c1):
    """Using a summed area table / integral image, calculate the sum
    over a given window.

    Parameters
    ----------
    sat : ndarray of uint64
        Summed area table / integral image.
    r0, c0 : int
        Top-left corner of block to be summed.
    r1, c1 : int
        Bottom-right corner of block to be summed.

    Returns
    -------
    S : int
        Sum over the given window.

    """
    cdef np.uint64_t S = 0

    S += sat[r1, c1]

    if (r0 - 1 >= 0) and (c0 - 1 >= 0):
        S += sat[r0 - 1, c0 - 1]

    if (r0 - 1 >= 0):
        S -= sat[r0 - 1, c1]

    if (c0 - 1 >= 0):
        S -= sat[r1, c0 - 1]

    return S
