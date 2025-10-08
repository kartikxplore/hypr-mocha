import requests
from bs4 import BeautifulSoup

url = 'https://www.yellowpages.com/los-angeles-ca/dental-clinics'

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
}


response = requests.get(url, headers=headers)

if response.status_code == 200:
    soup = BeautifulSoup(response.text, 'html.parser')
    clinics = soup.find_all('div', class_='result')
    print("Found a clinic.")
    for clinic in clinics:
        name_tag = soup.find('a', class_="business-name")
        website_tag = soup.find('a', class_="track-visit-website")
        phone_tag = soup.find('div', class_="phones")
        if name_tag is not None:
            name =  name_tag.text
        else:
            name = 'N/A'
        
        if website_tag is not None:
            website =  website_tag['href']
        else:
            website = 'N/A'

        if phone_tag is not None:
            phone =  phone_tag['href']
        else:
            phone = 'N/A'

        print(f"Name: {name}, Website: {website}, Phone: {phone}")
