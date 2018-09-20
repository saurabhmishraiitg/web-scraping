#import the library used to query a website

import time, sys, re, datetime, multiprocessing, os, urllib.request, random
import pandas as pd
from os import system
from urllib.parse import urlparse
from bs4 import BeautifulSoup
from multiprocessing import Pool, Process

#wiki = "https://en.wikipedia.org/wiki/List_of_state_and_union_territory_capitals_in_India"
simple_page = "https://dataquestio.github.io/web-scraping-pages/simple.html"
parent_page = "https://www.sapdatasheet.org/abap/tabl/ekko.html"
child_page = "https://www.sapdatasheet.org/abap/dtel/spras.html"
file_name = parent_page.split("/")[-1].split(".")[0]
output_dir = os.getenv("HOME") + "/"
soup_parser = "html5lib"

system('clear')
print("Start > " + datetime.datetime.now().isoformat())


#Abstract Method to get some soup out of a webpage
def _get_soup(page):
    #fetch the page
    page_html = urllib.request.urlopen(page)
    
    #parse the page using html5 parser
    return BeautifulSoup(page_html, soup_parser)


#Parse respective metadata for a single row from given table-row element
def _parse_column(num, row, df, page):
    row_arr = []
    columns = row.find_all("td")

    try:
        #Adding Field and href
        #row_arr.append(columns[1].a.text + " >> " + columns[1].a['href'])
        if columns[1].a is not None:
            row_arr.append(columns[1].a.text)
            #print("column #" + str(num) + " name : " + columns[1].a.text)
        else:
            row_arr.append("-")

        #Adding key flag
        # if 'checked' in columns[2].input.attrs:
        #     row_arr.append(columns[2].input['checked'])
        # else:
        #     row_arr.append('NA')

        if columns[3].a is not None:
            documentation = _parse_child(
                _get_domain(page) + columns[3].a['href'])

            #Adding Element and href
            row_arr.append(columns[3].a.text)
            row_arr.append(re.sub(r"\n", "_NL_", documentation))
        else:
            row_arr.append("-")
            row_arr.append("-")

        #Adding Domain and href
        #row_arr.append(columns[4].a.text + " >> " + columns[4].a['href'])
        if columns[4].a is not None:
            row_arr.append(columns[4].a.text)
        else:
            row_arr.append("-")

        #Adding datatype
        #row_arr.append(columns[5].a.text + " >> " + columns[5].a['href'])
        if columns[5].a is not None:
            row_arr.append(columns[5].a.text)
        else:
            row_arr.append("-")

        #Adding Length
        row_arr.append(columns[6].string.strip())

        #Adding Decimal
        row_arr.append(columns[7].string.strip())

        #Adding description
        row_arr.append(columns[8].string.strip())

        #Adding checktable
        # if columns[9].a is None:
        #     row_arr.append('')
        # else:
        #     row_arr.append(columns[9].a.text.strip() + " >> "+ columns[9].a['href'])

        df.loc[num] = row_arr

    except:
        print("[ERROR] Unexpected error:", str(sys.exc_info()))
        print(str(columns))
        print(columns[1].a.text)


#Parse the top level parent page for necessary metadata
def _parse_parent(page):
    soup = _get_soup(page)

    #listing all the top level div elements in the page having class = container-fluid
    top_divs = soup.find_all("div", {"class": "container-fluid"})

    #picking the 2nd div in the list, since that's having the requisite content
    div_2=top_divs[1]

    #get the main body of this div
    main = div_2.main
    card = main.find("div",{"class":"card"})
    card_body = card.find("div", {"class": "sapds-card-body"})

    #Assuming first element in this list will be the content table
    table_content = card_body.find("table", {"class": "table-sm"})

    #get the headers
    #table_header = table_content.thead
    header_arr = ['Field','ELement','Element Definition','Domain','Data Type','Length','Decimal','Description']

    # for th in table_header.find_all("th"):
    #     if th.string is not None:
    #         header_arr.append(th.string)
    #     else:
    #         if th.text.strip() != "":
    #             header_arr.append(th.text)

    #print(header_arr)
    df = pd.DataFrame(columns=header_arr)

    #get table body
    table_body = table_content.tbody

    for num, row in enumerate(table_body.find_all("tr"), start=1):
        _parse_column(num, row, df, page)

    return df


#parsing the documentation from the child page
def _parse_child(page):
    soup = _get_soup(page)

    #loading the top level card
    card = soup.find("div", attrs={"class": "card"})

    docs = card.find_all("div", {"class": "sapds-f1doc"})

    doc_arr = []

    for doc in docs:
        for child in doc.children:

                for content in child.children:
                    try:
                        if content.string is not None:
                            doc_arr.append(content.string)
                    except:
                        print("[ERROR] Unexpected error:", sys.exc_info()[0])
                        print("[ERROR] " + str(child))

    return "\n".join(doc_arr)


#Getting the current domain for href links
def _get_domain(page):
    parsed_uri = urlparse(page)
    domain = '{uri.scheme}://{uri.netloc}'.format(uri=parsed_uri)
    return domain

#Random Method
def list_append(count, id, out_list):
    time.sleep(int(random.random() * 20))
    print("id > " + str(id))
    print('module name:', __name__)
    print('parent process:', os.getppid())
    print('process id:', os.getpid())
    out_list.append(id)
    
    #for i in range(count):
    #out_list.append(random.random())

if __name__ == "__main__":
    #print("html5lib parser")
    #soup_parser = "html5lib"
    #df = _parse_parent(parent_page)
    #df.to_csv(output_dir + file_name + "-" + str(int(time.time())) + ".csv", sep='\t')

    #print(_parse_child(child_page))

    #page_html = urllib.request.urlopen(simple_page)
    #soup = BeautifulSoup(page_html, "html5lib")
    #print(str(soup.a))
    print("Hello")

    size = 100   # Number of random numbers to add
    procs = 2   # Number of processes to create

    # Create a list of jobs and then iterate through
    # the number of processes appending each process to
    # the job list
    jobs = []
    
    manager = multiprocessing.Manager()
    shared_list = manager.list()


    for i in range(0, procs):
        process = multiprocessing.Process(target=list_append,
                                          args=(size, i, shared_list))
        jobs.append(process)

    # Start the processes (i.e. calculate the random number lists)
    for j in jobs:
        j.start()

    # Ensure all of the processes have finished
    for j in jobs:
        j.join()

    print("List processing complete.")
    print(str(shared_list))
    
    print("End > " + datetime.datetime.now().isoformat())
    sys.exit()
