# Algorithn
# Take original message and tag and keep modifying  one letter at a time until it's transformed to new message

from oracle import *
import sys

if len(sys.argv) < 2:
    print "Usage: python sample.py <filename>"
    sys.exit(-1)

f = open(sys.argv[1])
data = f.read()
f.close()

Oracle_Connect()

goal_message = "I, the server, hereby agree that I will pay $100 to this student"

tag = Mac(data, len(data))

print str(len(data))
print str(data)
print str(len(goal_message))
print str(goal_message)
print str(len(tag))
print str(tag)

ret = Vrfy(data, len(data), tag)
print
print ret
if (ret==1):
    print "Message verified successfully!"
else:
    print "Message verification failed."

Oracle_Disconnect()
