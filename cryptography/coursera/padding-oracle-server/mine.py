from oracle import *
import sys

def send(ctext):
    rc = Oracle_Send(ctext, 3)
    # print "Oracle returned: %d" % rc
    return rc

def xor(intA, intB):
    return intA ^ intB

def xor_arrays(a, b):
    t = []
    for i in range(0, len(a)):
        v = a[i] ^ b[i]
        t.append(v)
    return t

def try_pad_length(ctext, blockstart, l):
    t = list(ctext)
    i = blockstart + l-1
    t[i] = xor(1, t[i])
    print "Attempt" + str(t)
    r = send(t)
    print r
    return r

def find_pad_length(ctext, blockstart):
    for i in range(1, 17):
        if try_pad_length(ctext, blockstart, i) == 0:
            return 16 -i +1
    return -1

def resolve_next_char(ctext, blockstart, f, newpadlength):
    # xor all numbers from
    print f
    print "Attempting padlength " + str(newpadlength)
    newciphertext = list(ctext)
    for i in range(16-newpadlength, 16):
        newciphertext[i+blockstart] = f[i] ^ newpadlength
    c = -1
    for i in range(0, 256):
        # print i
        pos = 16+blockstart-newpadlength
        newciphertext[pos] = i
        # print newciphertext
        r = send(newciphertext)
        if r == 1:
            c = i
            break
        else:
            continue

    f[blockstart-newpadlength] = c ^ newpadlength
    return f

def to_char(i):
    if(i > 16):
        return chr(i)
    elif(i > 0):
        return '_'
    else:
        return '*'

def ints_to_string(a):
    return ''.join([to_char(l) for l in a])

def findF(ctext, blockstart):
    p = find_pad_length(ctext, blockstart)
    f = [-1] * 16
    for i in range(16-p, 16):
        f[i] = ctext[i+blockstart] ^ p
    for i in range(p+1, 16+1):
        f = resolve_next_char(ctext, blockstart, f, i)
    # print f
    # return ints_to_string(xor_arrays(ctext[blockstart:blockstart+16], f))
    return f

def decrypt(ctext):
    print ctext
    iv = 0
    b1 = 16
    b2 = 32
    F = findF(ctext, b1)
    c1 = ctext[b1:b1+16]
    c2 = ctext[b2:b2+16]
    m1 = xor_arrays(c1, F)
    print (ints_to_string(xor_arrays(c1, F))

if len(sys.argv) < 2:
    print "Usage: python sample.py <filename>"
    sys.exit(-1)

f = open(sys.argv[1])
data = f.read().strip()
f.close()

ctext = [(int(data[i:i+2],16)) for i in range(0, len(data), 2)]
print "Length: " + str(len(ctext))

Oracle_Connect()

print send(ctext)
decrypt(ctext)

Oracle_Disconnect()
