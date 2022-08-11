import requests
import json

class GoogleLinkFetch():
    def get_header_info(self, json_response, LIMIT_LINK_NUMBER = 2):
        header_news_infos = []
        for index, item in enumerate(json_response["items"]):
            # print(index)
            if index == LIMIT_LINK_NUMBER:
                break

            title = item['title']
            link = item['link']

            thumbnail_image = None
            try:
                thumbnail_image = item['pagemap']['cse_image'][0]['src']
            except:
                thumbnail_image = item['pagemap']['metatags'][0]['og:image']
   
            # print(f"Thumbnail Image for title {title}:")
            # print(thumbnail_image)
            if link.endswith("?page=all") == False and link.startswith("https://historia.id/") == False:
                link += "?page=all"

            header_news_info = {
                "title": title,
                "link": link,
                "thumbnail_image": thumbnail_image
            }

            header_news_infos.append(header_news_info)
            # print(link)
        # print(header_news_infos)
        return header_news_infos

    def fetch_json_from_search_api(self, query):
        BASE_LINK = "https://www.googleapis.com/customsearch/v1"
        CX_KEY = "e34228993d08f4238"
        API_KEY = "AIzaSyAsQSjiOTOUOqz-oRrp71bdmHmoa9eLqyc"
        google_url = f"{BASE_LINK}?key={API_KEY}&cx={CX_KEY}&q={query}"
        r = requests.get(google_url)
        json_response = json.loads(r.text)

        return json_response