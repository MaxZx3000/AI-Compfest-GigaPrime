import requests
import json

class GoogleLinkFetch():
    def get_all_links(self, json_response, LIMIT_LINK_NUMBER = 2):
        link_urls = []
        for index, item in enumerate(json_response["items"]):
            if index == LIMIT_LINK_NUMBER:
                break
            link = item['link']
            if link.endswith("?page=all") == False and link.startswith("https://historia.id/") == False:
                link += "?page=all"

            link_urls.append(link)
            print(link)

        return link_urls

    def fetch_json_from_search_api(self, query):
        BASE_LINK = "https://www.googleapis.com/customsearch/v1"
        CX_KEY = "e34228993d08f4238"
        API_KEY = "AIzaSyAsQSjiOTOUOqz-oRrp71bdmHmoa9eLqyc"
        google_url = f"{BASE_LINK}?key={API_KEY}&cx={CX_KEY}&q={query}"
        r = requests.get(google_url)
        json_response = json.loads(r.text)

        return json_response