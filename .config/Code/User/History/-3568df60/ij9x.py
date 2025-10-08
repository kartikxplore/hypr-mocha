import requests
from bs4 import BeautifulSoup
import csv # 1. Import the csv library

url = 'https://www.yellowpages.com/los-angeles-ca/dental-clinics'
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
}

# 2. Open a new file to save the data. 'w' means 'write mode'.
# newline='' prevents extra blank rows from being created.
with open('clinic_leads.csv', 'w', newline='', encoding='utf-8') as f:
    # 3. Create a csv writer object
    writer = csv.writer(f)
    
    # 4. Write the header row for our spreadsheet
    writer.writerow(['Business Name', 'Website', 'Phone Number'])

    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        clinics = soup.find_all('div', class_='result')
        
        for clinic in clinics:
            # --- Your data extraction code is perfect and stays the same ---
            name_tag = clinic.find('a', class_="business-name")
            website_tag = clinic.find('a', class_="track-visit-website")
            phone_tag = clinic.find('div', class_="phone")
            
            if name_tag is not None:
                name =  name_tag.text.strip()
            else:
                name = 'N/A'
            
            if website_tag is not None:
                website =  website_tag['href']
            else:
                website = 'N/A'

            if phone_tag is not None:
                phone =  phone_tag.text.strip()
            else:
                phone = 'N/A'

            # 5. Instead of printing, write the data as a new row in the CSV
            writer.writerow([name, website, phone])
    
    else:
        print(f"Failed to retrieve the page. Status Code: {response.status_code}")

print("Scraping complete! Check the 'clinic_leads.csv' file.")