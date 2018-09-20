#import the library used to query a website
import urllib.request
from bs4 import BeautifulSoup
from os import system

#clears the terminal before starting execution
system('clear')

#wiki = "https://en.wikipedia.org/wiki/List_of_state_and_union_territory_capitals_in_India"
#page = "https://dataquestio.github.io/web-scraping-pages/simple.html"
page = "https://www.sapdatasheet.org/abap/tabl/t148t.html"

#fetch the page
page = urllib.request.urlopen(page)

#parse the page using html5 parser
soup = BeautifulSoup(page, "html5lib")

#data = soup.find('div', attrs={'class': 'card-header sapds-card-header'})
tables = soup.find_all("table")

#print(str(table))

print("Hello")

#first find all table tags
for table in tables:
    if table.findParent("table") is None:
        print(str(table))
        #for row in table.findAll("tr"):
            #for column in row.findAll("td"):
                #if len(column.attrs) != 0:
                    #if(column['class'][0] == "sapds-gui-label" or column['class'][0] == "sapds-gui-field"):
                        #print(column.string)

print("Bye")

#rows = soup.find_all("table", "class")

#for row in rows:
    #print(row)
    

#print(data.text)
#print(soup.prettify())
