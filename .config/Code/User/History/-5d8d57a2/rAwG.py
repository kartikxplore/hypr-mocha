import requests
from bs4 import BeautifulSoup

# 1. We've changed the URL to our new target
url = 'https://www.practo.com/delhi/dentist'

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
}

response = requests.get(url, headers=headers)

if response.status_code == 200:
    soup = BeautifulSoup(response.text, 'html.parser')

    # 2. We've updated the tag and class to match Practo's structure
    doctor_tags = soup.find_all('h2', class_='doctor-name')

    print("--- Found Doctor Names on Practo ---")
    for tag in doctor_tags:
        print(tag.text.strip())
else:
    print(f"Failed to retrieve the page. Status Code: {response.status_code}")