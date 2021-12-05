
#1006605
#19,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,883,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,17,x,x,x,x,x,x,x,x,x,x,x,x,x,797,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,29

INPUT = [19,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,37,-1,-1,-1,-1,-1,883,-1,
        -1,-1,-1,-1,-1,-1,23,-1,-1,-1,-1,13,-1,-1,-1,17,-1,-1,-1,-1,-1,-1,
        -1,-1,-1,-1,-1,-1,-1,797,-1,-1,-1,-1,-1,-1,-1,-1,-1,41,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,29]

x = -1
TINP = [7,13,x,x,59,x,31,19]

TEST_START = 939
TEST_BUSES = [7,13,59,31,19]

START = 1006605
BUSES = [19,37,883,23,13,17,797,41,29]

 
def wait_time(timestamp, bus):
    r = timestamp % bus
    return bus - r

def part1(start, buses):
    min_wait = None
    min_bus = None
    for bus in buses:
        wait = wait_time(start, bus)
        if min_wait is None or wait < min_wait:
            min_wait = wait
            min_bus = bus
    return min_bus * min_wait


print(part1(TEST_START, TEST_BUSES))
print(part1(START, BUSES))

from functools import reduce

def chinese_remainder(n, a):
    sum = 0
    prod = reduce(lambda a, b: a*b, n)
    for n_i, a_i in zip(n, a):
        p = prod // n_i
        sum += a_i * mul_inv(p, n_i) * p
    return sum % prod
 
def mul_inv(a, b):
    b0 = b
    x0, x1 = 0, 1
    if b == 1: return 1
    while a > 1:
        q = a // b
        a, b = b, a%b
        x0, x1 = x1 - q * x0, x0
    if x1 < 0: x1 += b0
    return x1

def part2(inp):
    N=[]
    A=[]
    for i, n in enumerate(inp):
        if n == -1:
            continue
        N.append(n)
        A.append(n - i)

    print(chinese_remainder(N,A))

part2(INPUT)


