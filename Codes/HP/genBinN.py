# gen binary string of large number
# from math import *
n1 = 12764787846358441471   # 20 digit
n2 = 71755440315342536873   # 20 digit 


# n1 = 9576890767
# n2 = 2860486313

n = n1*n2
print('{0:0192b}'.format(n))
print(n)
# print(n%(2**64))
# n1 = n//(2**64)
# print(n1%(2**64))
# n1 = n1//(2**64)
# print(n1)
# print(exp(0.5*sqrt(log(n) * log(log(n)))) + 800)

# 14100 23741
# 22922 23743
# 19808 23747
# 13356 23767

res = [14100, 22922, 19808, 13356]
pri = [23741, 23743, 23747, 23767]

for i in range(4):
    print((res[i] **2)%pri[i], n % pri[i])

