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