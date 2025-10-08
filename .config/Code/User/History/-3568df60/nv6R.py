import requests
from bs4 import BeautifulSoup
import csv

# --- No changes to headers or the file opening part ---
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
}

with open('clinic_leads_50.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['Business Name', 'Website', 'Phone Number'])

    # NEW: Loop through pages 1 and 2
    for page_num in range(1, 3):
        # Create the correct URL for each page
        url = f'https://www.yellowpages.com/los-angeles-ca/dental-clinics?page={page_num}'
        print(f"Scraping page {page_num}...")

        # --- The rest of your scraping code goes inside this new loop ---
        response = requests.get(url, headers=headers)

        if response.status_code == 200:
            soup = BeautifulSoup(response.text, 'html.parser')
            clinics = soup.find_all('div', class_='result')
            
            for clinic in clinics:
                # --- This data extraction part is perfect and remains unchanged ---
                name_tag = clinic.find('a', class_="business-name")
                website_tag = clinic.find('a', class_="track-visit-website")
                phone_tag = clinic.find('div', class_="phones")
                
                name = name_tag.text.strip() if name_tag else 'N/A'
                website = website_tag['href'] if website_tag else 'N/A'
                phone = phone_tag.text.strip() if phone_tag else 'N/A'

                writer.writerow([name, website, phone])
        
        else:
            print(f"Failed to retrieve page {page_num}. Status Code: {response.status_code}")

print("\nScraping complete! Check the 'clinic_leads_50.csv' file.")