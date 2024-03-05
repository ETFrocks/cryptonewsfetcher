import requests

def get_trending_tiktoks(api_key):
    # Define the endpoint URL
    url = f'https://api.tiktok.com/v1/trending?api_key={api_key}'

    try:
        # Send a GET request to the API
        response = requests.get(url)

        # Raise an exception if the request was unsuccessful
        response.raise_for_status()
    except requests.exceptions.HTTPError as errh:
        print ("HTTP Error:",errh)
    except requests.exceptions.ConnectionError as errc:
        print ("Error Connecting:",errc)
    except requests.exceptions.Timeout as errt:
        print ("Timeout Error:",errt)
    except requests.exceptions.RequestException as err:
        print ("Something went wrong with the request:",err)
        return None

    # Convert the response to JSON
    data = response.json()

    return data

# Replace 'your_api_key' with your actual API key
api_key = 'your_api_key'

data = get_trending_tiktoks(api_key)

if data is not None:
    # Print the data
    print(data)
