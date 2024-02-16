import requests
import json

# Replace 'your_api_key' with your actual API key
api_key = 'your_api_key'

# Define the endpoint URL
url = 'https://api.tiktok.com/v1/trending?api_key=' + api_key

# Send a GET request to the API
response = requests.get(url)

# Convert the response to JSON
data = json.loads(response.text)

# Print the data
print(data)
