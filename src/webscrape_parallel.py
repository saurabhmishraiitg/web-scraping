#import the library used to query a website
import time
import sys
import re
import datetime
import multiprocessing
import os
import urllib.request
import random
import pandas as pd
from os import system
from urllib.parse import urlparse
from bs4 import BeautifulSoup

#wiki = "https://en.wikipedia.org/wiki/List_of_state_and_union_territory_capitals_in_India"
simple_page = "https://dataquestio.github.io/web-scraping-pages/simple.html"
parent_page = "https://www.sapdatasheet.org/abap/tabl/eban.html"
child_page = "https://www.sapdatasheet.org/abap/dtel/spras.html"
file_name = parent_page.split("/")[-1].split(".")[0]
output_dir = os.getenv("HOME") + "/"
soup_parser = "lxml"
#using html5lib parser in multiprocessing mode is throwing issues. Hence reverting back to lxml parser
#soup_parser = "html5lib"

#Overall there was drastic performance jump with using Multiprocessing.
#In 1 case, where the original process was taking ~3m to excute, the
#multi process execution with 6 threads, completed in just 20s

#Abstract Method to get some soup out of a webpage


def _get_soup(page):
    #fetch the page
    page_html = urllib.request.urlopen(page)

    #parse the page using html5 parser
    return BeautifulSoup(page_html, soup_parser)


#Parse respective metadata for a single row from given table-row element
def _parse_column(num, html, page, col_q):
    row = BeautifulSoup(html, soup_parser)

    row_arr = list()
    columns = row.find_all("td")

    # try:
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

    #df.loc[num] = row_arr
    col_q.put(row_arr)
    return 0
    # except:
    #     print("[ERROR] Unexpected error:", str(sys.exc_info()))
    #     print(str(columns))
    #     print(columns[1].a.text)


#Parse the top level parent page for necessary metadata
def _parse_parent(page):
    soup = _get_soup(page)

    #listing all the top level div elements in the page having class = container-fluid
    top_divs = soup.find_all("div", {"class": "container-fluid"})

    #picking the 2nd div in the list, since that's having the requisite content
    div_2 = top_divs[1]

    #get the main body of this div
    main = div_2.main
    card = main.find("div", {"class": "card"})
    card_body = card.find("div", {"class": "sapds-card-body"})

    #Assuming first element in this list will be the content table
    table_content = card_body.find("table", {"class": "table-sm"})

    #get the headers
    #table_header = table_content.thead
    header_arr = ['Field', 'ELement', 'Element Definition',
                  'Domain', 'Data Type', 'Length', 'Decimal', 'Description']

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

    # Number of processes to create
    PROCS = multiprocessing.cpu_count() - 1
    print("# of Processes > " + str(PROCS))

    # use all available cores, otherwise specify the number you want as an argument
    pool = multiprocessing.Pool(PROCS)
    col_q = multiprocessing.Manager().Queue()

    for num, row in enumerate(table_body.find_all("tr"), start=1):
        html = str(row)
        pool.apply_async(_parse_column, (num, html, page, col_q, ))
        #print(result.get())
        #_parse_column(num, row, df, page)

    pool.close()
    pool.join()

    i = 0
    while not col_q.empty():
        i += 1
        df.loc[i] = col_q.get()

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


if __name__ == "__main__":
    system('clear')
    print("Start > " + datetime.datetime.now().isoformat())

    #soup_parser = "html5lib"
    df = _parse_parent(parent_page)
    df.to_csv(output_dir + file_name + "-" +
              str(int(time.time())) + ".csv", sep='\t')

    #print(_parse_child(child_page))

    #page_html = urllib.request.urlopen(simple_page)
    #soup = BeautifulSoup(page_html, "html5lib")
    #print(str(soup.body))
    #soup_1 = BeautifulSoup(str(soup.body),"html5lib")
    #print(str(soup_1.p))

    print("End > " + datetime.datetime.now().isoformat())
    sys.exit()
