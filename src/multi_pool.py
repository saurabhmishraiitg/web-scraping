#Imports
import sys
import datetime
import time
import multiprocessing
import os
import random
from os import system

#Random Method
def _list_append(id, q):
    sl = random.random() * 20
    print("id > " + str(id) + " sl > " + str(sl))

    time.sleep(sl)

    print('module name:', __name__)
    print('parent process:', os.getppid())
    print('process id:', os.getpid())
    q.put(id)

    return sl


result_list = []

def _log_result(result):
    # This is called whenever foo_pool(i) returns a result.
    # result_list is modified only by the main process, not the pool workers.
    result_list.append(result)

#MultiProcessing using Process objects
if __name__ == "__main__":
    system('clear')
    print("Start > " + datetime.datetime.now().isoformat())

    procs = 5   # Number of processes to create
    print("cpu > " + str(multiprocessing.cpu_count()))

    # use all available cores, otherwise specify the number you want as an argument
    pool = multiprocessing.Pool(procs)
    m = multiprocessing.Manager()
    q = m.Queue()

    for i in range(0, 10):
        #pool.apply_async(_list_append, (i,q, ), callback=_log_result)
        pool.apply_async(_list_append, (i, q, ))

    time.sleep(5)

    pool.close()
    pool.join()

    #print(result_list)

    print("List processing complete.")
    while not q.empty():
        print(q.get())

    print("End > " + datetime.datetime.now().isoformat())
    sys.exit()
