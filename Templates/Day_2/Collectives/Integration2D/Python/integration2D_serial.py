import time
import math
import sys

n = int(sys.argv[1])

starttime = time.time()

# interval size (same for X and Y)
h = math.pi / n

mysum = 0.0

for i in range(n):
    x = h * (i + 0.5)
    for j in range(n):
        y = h * (j + 0.5)
        mysum += math.sin(x + y)

integral = h**2 * mysum

endtime = time.time()

print("Integral value is %e, Error is %e" % (integral, abs(integral - 0.0)))
print("Time spent: %.2f sec" % (endtime-starttime))
