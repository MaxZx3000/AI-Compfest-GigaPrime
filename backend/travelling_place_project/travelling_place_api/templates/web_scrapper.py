import requests
from bs4 import BeautifulSoup

class WebScraper():
    def retrieve_content_from_scraper_api(url):
        API_KEY = "717eff6cd42e32317db238748c935241"
        web_url = f"http://api.scraperapi.com?api_key={API_KEY}&url={url}"
        request = requests.get(web_url)
        return request.text

