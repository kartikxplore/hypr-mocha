import requests
from bs4 import BeautifulSoup # Make sure to import BeautifulSoup

# URL and Headers are the same
url = 'https://www.justdial.com/Delhi/Dentists'
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
}

response = requests.get(url, headers=headers)

# Only proceed if the request was successful
if response.status_code == 200:
    # Create a BeautifulSoup object to parse the HTML
    soup = BeautifulSoup(response.text, 'html.parser')

    # Find all the h2 tags that have the class 'result-title'
    clinic_tags = soup.find_all('h2', class_='result-title')

    print("--- Found Clinic Names ---")
    # Loop through each tag we found
    for tag in clinic_tags:
        # .text gets the text content from within the tag
        # .strip() removes any extra whitespace from the beginning or end
        print(tag.text.strip())
else:
    print(f"Failed to retrieve the page. Status Code: {response.status_code}")