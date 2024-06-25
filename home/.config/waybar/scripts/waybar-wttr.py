import json
import requests

# OpenWeatherMap API key
API_KEY = 'add_your_openweathermap_API'

# City ID
CITY_ID = 'add_your_location_data_from_openweathermap'

WEATHER_CODES = {
    '200': '⛈️',  # Thunderstorm with light rain
    '201': '⛈️',  # Thunderstorm with rain
    '202': '⛈️',  # Thunderstorm with heavy rain
    '210': '⛈️',  # Light thunderstorm
    '211': '⛈️',  # Thunderstorm
    '212': '⛈️',  # Heavy thunderstorm
    '221': '⛈️',  # Ragged thunderstorm
    '230': '⛈️',  # Thunderstorm with light drizzle
    '231': '⛈️',  # Thunderstorm with drizzle
    '232': '⛈️',  # Thunderstorm with heavy drizzle
    '300': '🌧️',  # Light intensity drizzle
    '301': '🌧️',  # Drizzle
    '302': '🌧️',  # Heavy intensity drizzle
    '310': '🌧️',  # Light intensity drizzle rain
    '311': '🌧️',  # Drizzle rain
    '312': '🌧️',  # Heavy intensity drizzle rain
    '313': '🌧️',  # Shower rain and drizzle
    '314': '🌧️',  # Heavy shower rain and drizzle
    '321': '🌧️',  # Shower drizzle
    '500': '🌧️',  # Light rain
    '501': '🌧️',  # Moderate rain
    '502': '🌧️',  # Heavy intensity rain
    '503': '🌧️',  # Very heavy rain
    '504': '🌧️',  # Extreme rain
    '511': '🌨️',  # Freezing rain
    '520': '🌧️',  # Light intensity shower rain
    '521': '🌧️',  # Shower rain
    '522': '🌧️',  # Heavy intensity shower rain
    '531': '🌧️',  # Ragged shower rain
    '600': '❄️',  # Light snow
    '601': '❄️',  # Snow
    '602': '❄️',  # Heavy snow
    '611': '🌨️',  # Sleet
    '612': '🌨️',  # Light shower sleet
    '613': '🌨️',  # Shower sleet
    '615': '🌨️',  # Light rain and snow
    '616': '🌨️',  # Rain and snow
    '620': '🌨️',  # Light shower snow
    '621': '🌨️',  # Shower snow
    '622': '🌨️',  # Heavy shower snow
    '701': '🌫️',  # Mist
    '711': '🌫️',  # Smoke
    '721': '🌫️',  # Haze
    '731': '🌫️',  # Sand, dust whirls
    '741': '🌫️',  # Fog
    '751': '🌫️',  # Sand
    '761': '🌫️',  # Dust
    '762': '🌫️',  # Volcanic ash
    '771': '🌬️',  # Squalls
    '781': '🌪️',  # Tornado
    '800': '☀️',   # Clear sky
    '801': '⛅',    # Few clouds
    '802': '⛅',    # Scattered clouds
    '803': '☁️',   # Broken clouds
    '804': '☁️',   # Overcast clouds
}

data = {}

url = f"http://api.openweathermap.org/data/2.5/weather?id={CITY_ID}&appid={API_KEY}&units=metric"

try:
    response = requests.get(url)
    response.raise_for_status()

    if response.status_code == 200:
        weather_data = response.json()

        # Process current weather condition
        current_weather = weather_data['weather'][0]
        current_temp = weather_data['main']['temp']
        feels_like = weather_data['main']['feels_like']
        weather_code = str(current_weather['id'])

        data['text'] = f"{WEATHER_CODES.get(weather_code, '❓')} {feels_like}°C"

        data['tooltip'] = f"<b>{current_weather['main']} ({current_weather['description']})</b>\n"
        data['tooltip'] += f"Temperature: {current_temp}°C\n"
        data['tooltip'] += f"Feels like: {feels_like}°C\n"
        data['tooltip'] += f"Humidity: {weather_data['main']['humidity']}%\n"
        data['tooltip'] += f"Wind Speed: {weather_data['wind']['speed']} m/s\n"
        data['tooltip'] += f"Cloudiness: {weather_data['clouds']['all']}%\n"

    else:
        data['text'] = "❓"
        data['tooltip'] = "Weather data unavailable"

except requests.exceptions.RequestException as e:
    print("Error fetching weather data:", e)
    data['text'] = "❓"
    data['tooltip'] = "Error fetching weather data"

print(json.dumps(data))
