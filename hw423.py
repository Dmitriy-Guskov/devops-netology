#!/usr/bin/env python3

import os
import sys

path = os.getcwd()
if len(sys.argv)>=2:
  path = sys.argv[1]

bash_command = ["cd " +path, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
#is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        separator='/'
        out=path+separator+prepare_result
        print(out)
#       break
