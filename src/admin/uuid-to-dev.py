#!/usr/bin/env python
# Simple script to replace root=UUID=<uuid> with 
#                          root=/dev/<root device> 
# Uses blkid 
# 
import sys
import subprocess
filename = sys.argv[1]

grubfile = open(filename)
contents = grubfile.readlines()
grubfile.close()
for l in contents:
	words = l.split()
	for token in words:
		if 'root=UUID=' in token:
			uuid=token.replace("root=UUID=","")
			try:
				p = subprocess.Popen("blkid -U %s" % uuid, 
					shell=True, stdout=subprocess.PIPE)
				device = p.stdout.readline().strip()
				if len(device) > 0: 
					output = l.replace(token,"root=%s" % device)
				break
			except:
				output = l 
		else:
			output = l
	sys.stdout.write(output)


