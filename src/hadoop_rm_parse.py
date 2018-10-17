#This script take the page content of RM and parses metrics about data load for a particular user over time
#You also learn to parse JSON strings and navigate them

#How to get the data from RM
#curl 'http://tstr400191.wal-mart.com:8088/cluster/apps/FINISHED' - H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:62.0) Gecko/20100101 Firefox/62.0' - H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' - H 'Accept-Language: en-US,en;q=0.5' - -compressed - H 'DNT: 1' - H 'Connection: keep-alive' - H 'Upgrade-Insecure-Requests: 1'

#Get the output JSON format
#curl -v -X GET -H "Content-Type: application/json" http://tstr400191.wal-mart.com:8088/ws/v1/cluster/apps
#curl -X GET http://tstr400191.wal-mart.com:8088/ws/v1/cluster/info

import requests
import json
import datetime
import os
import sys
import pprint
from pandas.io.json import json_normalize
import pandas as pd

#url = 'http://tstr400191.wal-mart.com:8088/ws/v1/cluster/info'
url = 'http://tstr400191.wal-mart.com:8088/ws/v1/cluster/apps'
#url = 'http://tstr400191.wal-mart.com:8088/ws/v1/cluster/scheduler'

json_filepath = '/Users/s0m0158/Desktop/data.json'
csv_filepath = '/Users/s0m0158/Desktop/data.csv'

#Add any parameters for the request to the Dictionary
params = dict()

#Get response for the given URL with params
def _get_respose(url, params):
    return requests.get(url=url, params=params).content

#Load data from a saved file
def _load_save_file(filepath):
    file = open(filepath, "r")
    return file.read()

#Save data to a file
def _save_to_file(data, path):
    with open(path, 'w') as outfile:
        json.dump(data, outfile)

#Parse binary content as JSON
def _parse_json(binary):
    return json.loads(binary)

#Navigate JSON data to get necessary metrics
def _navigate_json_tree(json_data):
    rm_app = json_data['apps']['app']

    # Filter python objects with list comprehensions
    #output_dict = [x for x in rm_app if x['user'] == 'svcggdat']

    #print("size >", str(len(output_dict)))
    #Loads the JSON data to a dataframe
    df = json_normalize(rm_app)
    df['name'] = df['name'].str.replace('\n', '-')
    #print(df['name'])
    df.to_csv(csv_filepath, sep='\t')

    #Get list of colums in the data
    #print(df.keys())

    #Get count of jobs for each user sorted by count , top 10 rows
    #print("<< Top 10 job submitting users by count >>")
    #print(df['user'].value_counts()[:10])

    #df['startedTime_1'] = pd.to_datetime(df.startedTime)
    #df['startedTime_1'] = pd.to_datetime(df['startedTime']/1000, unit='s') #.dt.date
    #df['finishedTime_1'] = pd.to_datetime(
    #    df['finishedTime']/1000, unit='s') #.dt.date
    #print(df.loc[df['user'] == 'svcggdat'].head(10))
    #print(df[df['user'] == 'svcggdat'].sort_values('startedTime')
    #      [['user', 'startedTime', 'finishedTime', 'id', 'startedTime_1']])

    #print(df[df['user'] == 'svcggdat'].groupby(
    #    'startedTime_1').first()[[ 'startedTime', 'finishedTime', 'queueUsagePercentage', 'clusterUsagePercentage', 'vcoreSeconds', 'memorySeconds', 'elapsedTime']])

    #print(df[df['user'] == 'svcggdat'] [['id', 'vcoreSeconds', 'memorySeconds', 'elapsedTime', 'startedTime_1', 'finishedTime_1', 'state']][:10])
    #print(df[df['user'] == 'svcggdat'].sort_values('startedTime')

if __name__ == "__main__":
    os.system('clear')
    print("Start > " + datetime.datetime.now().isoformat())

    data = _get_respose(url, params)

    #data = _load_save_file(json_filepath)
    json_data = _parse_json(data)
    _navigate_json_tree(json_data)

    #_save_to_file(data, json_filepath)

    print("End > " + datetime.datetime.now().isoformat())
    sys.exit()
