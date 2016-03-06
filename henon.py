from sys import argv

#a, b = .155, .6
#x0, y0 = 1., 2.
a, b = 1.4, .3
x0, y0 = .1, .1

def henon(a, b, xm1, ym1):
    x = ym1 + 1 - (a * xm1 * xm1)
    y = b * xm1
    return (x, y)

def iterate(N, a, b, x0, y0):
    xm1, ym1 = x0, y0
    for i in xrange(N):
        x, y = henon(a, b, xm1, ym1)
        print ' '.join([str(x), str(y)])
        xm1, ym1 = x, y

if __name__ == "__main__":
    iterate(int(argv[1]), a, b, x0, y0)
