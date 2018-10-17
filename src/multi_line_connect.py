# This script assists HIVE data load by handling records where there is a newline character within some column.
# Expectation is that there is a special character at the start and end of each record, to identify where a new record
# starts and where it ends

import datetime
import os
import sys

#Sample line example
##|AB|CD|DE|EF|
##|XY|MN
# PQ|OP|JH|

#Start delimiter = |
#End delimiter = |

input_file = sys.argv[1]
#input_file = '/Users/s0m0158/Desktop/tmp/a.txt'
output_file = input_file+'.new'
end_delim='\r'

if __name__ == "__main__":
    os.system('clear')
    print("Start > " + datetime.datetime.now().isoformat())

    with open(input_file) as inp, open(output_file, 'a') as out:
        linep = ''
        for line in inp:
            if end_delim in line:
                if linep == '':
                    out.write(line)
                else:
                    out.write(linep.replace('\n', '')+line)
                    linep = ''
            else:
                linep=linep.replace('\n','')+line
            #print line.endswith(end_delim)

    print("End > " + datetime.datetime.now().isoformat())
    sys.exit()
