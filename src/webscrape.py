#import the library used to query a website
import urllib.request
from bs4 import BeautifulSoup
from os import system
import datetime
import pandas as pd
from urllib.parse import urlparse
import time
import sys
import re

#clears the terminal before starting execution
system('clear')
print("Start > " + datetime.datetime.now().isoformat())

#wiki = "https://en.wikipedia.org/wiki/List_of_state_and_union_territory_capitals_in_India"
#page = "https://dataquestio.github.io/web-scraping-pages/simple.html"
parent_page = "https://www.sapdatasheet.org/abap/tabl/t148t.html"
child_page = "https://www.sapdatasheet.org/abap/dtel/spras.html"

def _parse_parent(page):
    #fetch the page
    page_html = urllib.request.urlopen(page)

    #parse the page using html5 parser
    soup = BeautifulSoup(page_html, "html5lib")

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
        row_arr = []
        columns = row.find_all("td")

        #Adding Field and href
        #row_arr.append(columns[1].a.text + " >> " + columns[1].a['href'])
        row_arr.append(columns[1].a.text)

        #Adding key flag
        # if 'checked' in columns[2].input.attrs:
        #     row_arr.append(columns[2].input['checked'])
        # else:
        #     row_arr.append('NA')

        documentation = _parse_child(_get_domain(page) + columns[3].a['href'])

        #Adding Element and href
        row_arr.append(columns[3].a.text)
        row_arr.append(re.sub(r"\n", "_NL_", documentation))

        #Adding Domain and href
        #row_arr.append(columns[4].a.text + " >> " + columns[4].a['href'])
        row_arr.append(columns[4].a.text)

        #Adding datatype
        #row_arr.append(columns[5].a.text + " >> " + columns[5].a['href'])
        row_arr.append(columns[5].a.text)

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

        df.loc[num]=row_arr

    return df

#parsing the documentation from the child page
def _parse_child(page):
    #Open up the web page
    page_html = urllib.request.urlopen(page)

    #Parse and load the page
    soup = BeautifulSoup(page_html, 'html5lib')

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


df = _parse_parent(parent_page)
df.to_csv("/Users/s0m0158/Desktop/datamodel" + str(int(time.time())) + ".csv", sep='\t')
#print(_parse_child(child_page))
print()

print("End > " + datetime.datetime.now().isoformat())
