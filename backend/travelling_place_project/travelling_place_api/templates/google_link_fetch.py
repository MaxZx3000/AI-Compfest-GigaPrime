import requests
import json

class GoogleLinkFetch():
    def _get_image_link(self, item):
        thumbnail_image = None
        try:
            thumbnail_image = item['pagemap']['cse_image'][0]['src']
        except:
            try:
                thumbnail_image = item['pagemap']['metatags'][0]['og:image']
            except:
                thumbnail_image = item['pagemap']['webpage'][0]['image']

        return thumbnail_image

    def get_header_info(self, json_response, LIMIT_LINK_NUMBER = 2):
        header_news_infos = []
        for index, item in enumerate(json_response["items"]):
            # print(index)
            if index == LIMIT_LINK_NUMBER:
                break

            title = item['title']
            link = item['link']
            
            type = None
            try:
                type = item["pagemap"]["metatags"][0]["og:type"]
            except:
                type = "article"

            site_name = None

            try:
                site_name = item["displayLink"]
            except:
                site_name = "Unknown"

            print(f"Thumbnail Image for title {title}:")
            thumbnail_image = self._get_image_link(item)
                
            # print(thumbnail_image)
            if link.endswith("?page=all") == False and link.startswith("https://historia.id/") == False:
                link += "?page=all"

            header_news_info = {
                "title": title,
                "link": link,
                "thumbnail_image": thumbnail_image,
                "type": type,
                "site_name": site_name,
            }

            header_news_infos.append(header_news_info)
            # print(link)
        # print(header_news_infos)
        return header_news_infos

    def fetch_json_from_search_api(self, query, cx_key):
        BASE_LINK = "https://www.googleapis.com/customsearch/v1"
        API_KEY = "AIzaSyAsQSjiOTOUOqz-oRrp71bdmHmoa9eLqyc"
        google_url = f"{BASE_LINK}?key={API_KEY}&cx={cx_key}&q={query}"
        r = requests.get(google_url)
        json_response = json.loads(r.text)

        return json_response