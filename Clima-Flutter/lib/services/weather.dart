import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const _apiKey = "6dceb3ba11e53cf5f94130b488b84150";
const _openWeatherMapUrl = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  LocationService locationService = LocationService();

  Future<dynamic> getLocationWeather({String city}) async {
    await locationService.getCurrentLocation();

      String url =
        '$_openWeatherMapUrl?lat=${locationService.lastPosition.latitude}&lon=${locationService.lastPosition.longitude}&appid=$_apiKey&units=imperial';
    if(city != null) {
      url = '$_openWeatherMapUrl?q=$city&appid=$_apiKey&units=imperial';
    }

    print('Getting request from...\n$url');

    var networkingService = NetworkingService(url: url);
    var weatherData = await networkingService.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp == null) {
      return 'Uh oh! An error occurred.';
    }
    if (temp > 90) {
      return 'It\'s 🍦 time';
    } else if (temp > 75) {
      return 'Time for shorts and 👕';
    } else if (temp < 50) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
