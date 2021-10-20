from time import process_time
import math
import sys


n = int(sys.argv[1])


#turn on the stop watch
starttime = process_time()

#calculate the interval size, same for X and Y
h = math.pi / float(n)

mysum = 0.0

#distribute work in the X axis
for i in range(n):
    x = h * (i + 0.5)
    #do regular integration in the Y axis
    for j in range(n):
        y = h * (j + 0.5)
        mysum += math.sin(x + y)

integral = h**2 * mysum

#turn off the stop watch
endtime = process_time()

#print results on the root rank
print("Integral value is %.18f, Error is %.18f" % (integral, abs(integral - 0.0)))
print("Time for loop and reduce is %.16f seconds" % (endtime-starttime))
