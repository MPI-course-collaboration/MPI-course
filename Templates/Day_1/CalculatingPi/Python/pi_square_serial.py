finval = 10000000

pi_square = 0.0

for i in range(finval):
    pi_square += 1.0 / (float(i+1)**2)

print("Pi^2 = {:.10f}".format(pi_square*6.0))
