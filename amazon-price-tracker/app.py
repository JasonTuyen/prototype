import requests
from bs4 import BeautifulSoup

# List of Amazon product URLs
product_urls = [
    "https://a.co/d/dAHBvdl",
    "https://a.co/d/6iWt7aT",
    "https://a.co/d/1WrBuSJ",
    # Add more product URLs here
]

total = 0.00

for url in product_urls:
    # Send HTTP request
    response = requests.get(url)

    # Parse HTML
    soup = BeautifulSoup(response.content, "html.parser")

    # Extract product price
    price_element = soup.select_one(".a-price-whole")

    if price_element:
        soup = BeautifulSoup(response.content, "html.parser")
        price_element = soup.select_one('span.a-price').select_one('span.a-offscreen')
        print(price_element.text)
        price = float(price_element.text.strip("$"))
        total = total + price
    else:
        print(f"Price not found for {url}")
        print("-" * 30)

print(f"Total: ${total:.2f}")
