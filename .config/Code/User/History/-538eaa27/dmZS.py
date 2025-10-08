import requests

# The URL of the page we want to scrape
url = 'https://www.justdial.com/Delhi/Dentists'

# It's good practice to send "headers" to mimic a real browser visit
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
}

# Send the request to the URL and store the server's response
response = requests.get(url, headers=headers)

# Check the status code. 200 means the request was successful!
print(f"Status Code: {response.status_code}")

# Print the first 500 characters of the page's HTML content
print("\n--- Page Content Start ---")
print(response.text[:500])