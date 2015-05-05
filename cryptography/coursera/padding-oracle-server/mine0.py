from oracle import *
import sys

def send(c, blocks):
    rc = Oracle_Send(c, blocks)
    # print "Oracle returned: %d" % rc
    return rc

def xor(intA, intB):
    return intA ^ intB

def axor(a, b):
    t = []
    for i in range(0, len(a)):
        v = a[i] ^ b[i]
        t.append(v)
    return t

def to_char(i):
    if(i > 16):
        return chr(i)
    elif(i > 0):
        return chr(i)
    else:
        return '*'

def ints_to_string(a):
    return ''.join([to_char(l) for l in a])

def try_pad_length(c0, rem, l):
    t0 = list(c0)
    i = 16-l
    t0[i] = xor(5, t0[i])
    print "Attempt" + str(t0)
    data = t0+rem
    r = send(data, len(data)/16)
    print r
    return r

def find_pad_length(c0, rem):
    for i in range(16, 0, -1):
        if try_pad_length(c0, rem, i) == 0:
            return i
    return 1

def resolve_next_char(c0, rem, f, newpadlength):
    # xor all numbers from
    newciphertext = list(c0)
    l = len(c0)
    for i in range(l-newpadlength, l):
        newciphertext[i] = f[i] ^ newpadlength
        print f
        print "Attempting padlength " + str(newpadlength)
    c = -1
    for i in range(0, 256):
        # print i
        pos = l-newpadlength
        newciphertext[pos] = i
        # print newciphertext
        data = newciphertext+rem
        r = send(data, len(data)/16)
        print r
        print data
        if r == 1:
            c = i
            break
        else:
            continue

    f[l-newpadlength] = c ^ newpadlength
    return f

def last_byte(c0, c1):
    b = -1
    t0 = list(c0)
    for i in range(0, 256):
        t0[len(t0)-1] = i
        r = send(t0+c1, 2)
        if r == 1:
            b = i
            break
        else:
            continue
    return b

def findFWithStart(c0, c1, p, f):
    for i in range(p+1, len(c0)+1):
        f = resolve_next_char(c0, c1, f, i)
        print ints_to_string(axor(f, c0))
    # return ints_to_string(xor_arrays(ctext[blockstart:blockstart+16], f))
    return axor(f, c0)

def findFForPadded(c0, rem, p):
    l = len(c0)
    f = [-1] * l
    for i in range(l-p, l):
        f[i] = p ^ c0[i]
    print f
    return findFWithStart(c0, c1, p, f)

def findF(c0, c1):
    l = len(c0)
    f = [-1] * l
    f[l-1] = last_byte(c0, c1) ^ 1
    print "Last byte: " + str(f[l-1])
    findFWithStart(c0, c1, 1, f)

def decrypt(ctext):
    print ctext
    c0 = ctext[0:16]
    c1 = ctext[16:32]
    c2 = ctext[32:48]
    print send(c1+c2, 2)
    # p = find_pad_length(c1, c2)
    # print "PAD LENGTH: " + str(p)
    # m2 = findFForPadded(c1, c2, p)
    m1 = findF(c0, c1)
    print ints_to_string(m1)
    # print ints_to_string(m2)

if len(sys.argv) < 2:
    print "Usage: python sample.py <filename>"
    sys.exit(-1)

f = open(sys.argv[1])
data = f.read().strip()
f.close()

ctext = [(int(data[i:i+2],16)) for i in range(0, len(data), 2)]
print "Length: " + str(len(ctext))

Oracle_Connect()

decrypt(ctext)

Oracle_Disconnect()
