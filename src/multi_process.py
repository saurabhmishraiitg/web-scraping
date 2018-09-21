#Imports
import sys
import datetime, time
import multiprocessing
import os
import random
from os import system
from multiprocessing import Process, Queue

#Random Method
def _list_append(id, q):
    sl = random.random() * 20
    print("id > " + str(id) + " sl > " + str(sl))

    time.sleep(sl)

    print('module name:', __name__)
    print('parent process:', os.getppid())
    print('process id:', os.getpid())
    q.put(id)

#MultiProcessing using Process objects
if __name__ == "__main__":
    system('clear')
    print("Start > " + datetime.datetime.now().isoformat())

    procs = 5   # Number of processes to create
    print("cpu > " + str(multiprocessing.cpu_count()))

    #job list
    jobs = list()

    q = Queue()

    for i in range(0, procs):
        process = multiprocessing.Process(target=_list_append, args=(i, q))
        jobs.append(process)

    # Start the processes (i.e. calculate the random number lists)
    for j in jobs:
        j.start()

    #Iterate over job list to connect them
    for j in jobs:
        j.join()

    print("List processing complete.")
    while not q.empty():
        print(q.get())

    print("End > " + datetime.datetime.now().isoformat())
    sys.exit()
