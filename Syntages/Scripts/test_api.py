import requests, json

response = requests.get('https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=Gin')
#print(len(json.loads(response.text)['drinks']))

print(json.dumps(json.loads(response.text), indent=3))
