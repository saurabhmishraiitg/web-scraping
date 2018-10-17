#This script take the page content of RM and parses metrics about data load for a particular user over time
#You also learn to parse JSON strings and navigate them without using Pandas
###
#The output file getting generated has header row
###
#Sample Command - python2.7 /u/users/svcggapp/scripts/bots/cluster_usage.py -wd /u/users/svcggdat/tmp/bots/cluster_usage -u http://tstr400191.wal-mart.com:8088/ws/v1/cluster/apps -d /user/svcggdat/bots/cluster_usage
import requests
import os
import sys
import datetime
import json
import csv
import pprint
import subprocess
from argparse import ArgumentParser

#url = 'http://tstr400191.wal-mart.com:8088/ws/v1/cluster/info'
#url = 'http://tstr400191.wal-mart.com:8088/ws/v1/cluster/apps'
#url = 'http://tstr400191.wal-mart.com:8088/ws/v1/cluster/scheduler'

#Add any parameters for the request to the Dictionary
params = dict()

#WORKING_DIR = '/tmp/python'
#json_filepath = '/Users/s0m0158/Desktop/data.json'
#csv_filepath = '/Users/s0m0158/Desktop/data.csv'

#Get response for the given URL with params
def _get_respose(url, params):
    return requests.get(url=url, params=params).content

#Load data from a saved file
def _load_save_file(filepath):
    file = open(filepath, "r")
    return file.read()

#Save data to a file
def _save_to_file(apps_data, path):
    # open a file for writing
    application_history = open(path, 'w')

    # create the csv writer object
    csvwriter = csv.writer(application_history, delimiter='|', lineterminator='\n')

    count = 0
    for app in apps_data:
        if count == 0:
            header = app.keys()
            csvwriter.writerow(header)
            count += 1
        csvwriter.writerow(app.values())

    print("records written to file > ", str(count))
    application_history.close()

#Parse binary content as JSON
def _parse_json(binary):
    return json.loads(binary)


if __name__ == "__main__":
    os.system('clear')
    print("Start > " + datetime.datetime.now().isoformat())

    parser = ArgumentParser()
    parser.add_argument("-wd", dest="working_dir",
                        help="local folder where to download the json and convert to csv for HDFS load", metavar="FOLDER", required=True)
    parser.add_argument("-u", "--url", dest="rm_url",
                        help="resource manager URL for getting application details", metavar="RM_URL",required=True)
    parser.add_argument("-d", "--dir", dest="hdfs_dir",
                        help="HDFS directory for putting the new feed file", metavar="HDFS_DIR", required=True)

    args = parser.parse_args()

    print("parameters recieved > "+str(args))

    #Get the JSON data from the Resource Manager API
    data = _get_respose(args.rm_url, params)

    #data = _load_save_file(json_filepath)
    json_data = _parse_json(data.replace('\\n', ''))
    apps_data = json_data['apps']['app']

    #Deleting previous day's feed file
    cmd_clearlocal = "rm -v -f " + args.working_dir+"/apps_list.csv"
    process = subprocess.Popen(
        cmd_clearlocal.split(), stdout=subprocess.PIPE, cwd=args.working_dir)
    output, error = process.communicate()
    print(output, error)

    #Generating the CSV file with latest output on the local
    _save_to_file(apps_data, args.working_dir+"/apps_list.csv")

    #Creating HDFS partition directory
    current_timedir = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
    hdp_create = "hadoop fs -mkdir -p " + \
        args.hdfs_dir + "/load_date=" + current_timedir

    process = subprocess.Popen(
        hdp_create.split(), stdout=subprocess.PIPE, cwd=args.working_dir)
    output, error = process.communicate()
    print(output, error)

    #Put the daily CSV file in HDFS
    hdp_put = "hadoop fs -put " + args.working_dir+"/apps_list.csv " + \
        args.hdfs_dir + "/load_date=" + current_timedir

    process = subprocess.Popen(
        hdp_put.split(), stdout=subprocess.PIPE, cwd=args.working_dir)
    output, error = process.communicate()
    print(output, error)

    print("End > " + datetime.datetime.now().isoformat())
    sys.exit()
