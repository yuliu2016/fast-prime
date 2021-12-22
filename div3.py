
# https://stackoverflow.com/questions/52216489/how-to-know-number-is-divisible-by-3-or-any-odd-number-using-bitwise-operator-in

def divis3(x):
    while x > 3:   # added more bitwiseness :) instead of (x > 3)
        sum = 0
        while (x):
            sum += x & 3  # extract two least significant bits
            x >>= 2       # shift value to get access to the next pair of bits
        x = sum
    return x #(x == 0 or x==3)

"""
do {
    sum = 0
    do {
        sum = sum + x & 3
        x = x >> 2
    } while (x)
    x = sum
} while x > 3

return x == 3
"""

for i in range (0, 100):
    print(f"{i}->x={divis3(i)}")