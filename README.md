# ClimateIQ 

This Flutter project is a simple weather app that allows users to check the current weather and forecast for a specific city.

## Features
Current Weather Display: The app fetches and displays the current weather information, including temperature, weather condition (sunny, cloudy, etc.), and an appropriate weather icon.
Hourly Forecast: Users can view the hourly weather forecast for the next few hours. Each forecast includes the predicted temperature, weather condition, and time.
Additional Information: The app provides additional weather-related information such as humidity, wind speed, and atmospheric pressure.
Dark/Light Mode: Users can toggle between dark and light themes for better readability and user experience.

## Screenshots
### Dark Mode
![Screenshot_1714545791](https://github.com/VedantS28/weather_app_flutter/assets/162162564/d5453e6b-9a5e-45df-a037-9aeca0778892)

### Light Mode
![Screenshot_1714545786](https://github.com/VedantS28/weather_app_flutter/assets/162162564/3dfc5b3d-1f20-44a2-b467-9ffb350ec8cf)


## Dependencies
http: A package for making HTTP requests to fetch weather data from the OpenWeatherMap API.
intl: A package for internationalization and date formatting.
provider: A package for state management to handle theme changes.
weather_app: Custom widgets for displaying additional weather information and hourly forecast.

## Usage
To use this app:

Clone this repository to your local machine.
Open the project in your preferred Flutter IDE (e.g., Android Studio, VSCode).
Run flutter pub get to install dependencies.
Replace the OpenWeatherMap API key in the getCurrentWeather() method with your own API key.
Run the app on a simulator or physical device using flutter run.

## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.
