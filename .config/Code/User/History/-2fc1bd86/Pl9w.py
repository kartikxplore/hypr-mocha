import requests
from bs4 import BeautifulSoup

url = 'https://www.practo.com/delhi/dentist'

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
}

response = requests.get(url, headers=headers)

if response.status_code == 200:
    soup = BeautifulSoup(response.text, 'html.parser')
    doctor_name = soup.find_all('h2', attrs={'class': 'doctor-name'})
    experience_tags = soup.find_all('div', attrs={'data-qa-id': 'doctor_experience'})
    print("Found Doctor Names on Practo")
    for name,experience in zip(doctor_name, experience_tags):
        print(f"Name: {name.text.strip()} | Experience: {experience.text.strip()}")


else:
    print(f"Failed to retrieve the page. Status Code: {response.status_code}")