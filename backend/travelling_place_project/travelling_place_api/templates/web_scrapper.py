import requests
from bs4 import BeautifulSoup

class WebScraper():
    def retrieve_content_from_scraper_api(self, url):
        API_KEY = "012663f1577c99d16387b5aba5f54712"
        web_url = f"http://api.scraperapi.com?api_key={API_KEY}&url={url}"
        request = requests.get(web_url)
        return request.text

    def get_relevant_paragraphs_only(self, web_content):
        beautiful_soup = BeautifulSoup(web_content)
        texts = [element.text for element in beautiful_soup.find_all('p')]
        texts += [element.text for element in beautiful_soup.find_all('p span')]
        texts += [element.text for element in beautiful_soup.find_all('div', {"class": "post-body-inner"})]
        
        return texts