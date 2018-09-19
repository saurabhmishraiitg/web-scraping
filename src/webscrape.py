#import the library used to query a website
import urllib.request
from bs4 import BeautifulSoup

#wiki = "https://en.wikipedia.org/wiki/List_of_state_and_union_territory_capitals_in_India"
#simple_page = "https://dataquestio.github.io/web-scraping-pages/simple.html"
page = "https://www.sapdatasheet.org/abap/tabl/t148t.html"

page = urllib.request.urlopen(page)

soup = BeautifulSoup(page, "html5lib")

data = soup.find('div', attrs={'class': 'card-header sapds-card-header'})
print(data.text)
#print(soup.prettify())
