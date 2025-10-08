import requests
from bs4 import BeautifulSoup

url = 'https://www.yellowpages.com/los-angeles-ca/dental-clinics'

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
}