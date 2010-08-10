#!/usr/bin/env python

"""This script will show user available and not disabled
users login names and home directories separated with tab.

Use output parsing with AWK for example.
"""

f = open("/etc/passwd", "r")

for line in f.readlines():
    data = line.split(":")
    if data[6].rstrip() != '/bin/false':
        print "%s\t%s" % (data[0], data[5])

f.close()
