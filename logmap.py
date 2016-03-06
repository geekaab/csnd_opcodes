from sys import argv
from argparse import ArgumentParser as ap
import numpy as np

R = 4.1
x0 = 0.1

R_chaos_onset = 3.56995
R_max = 4.0
R_offset = .00001
R_vals = np.arange(R_chaos_onset, R_max+R_offset, R_offset)

def lgmp(R, xm1):
    return R * xm1 * (1.0 - xm1)

def iterate(N, R, x0):
    xm1 = x0
    for i in xrange(N):
        x = lgmp(R, xm1)
        print x
        xm1 = x

if __name__ == "__main__":
    for r in R_vals:
        print ' '.join(['R = ', str(r)])
        iterate(int(argv[1]), r, x0)
        print
