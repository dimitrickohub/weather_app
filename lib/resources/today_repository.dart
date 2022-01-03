import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

const String _kKye = '286bcef11450bc68f75fb791713f7be2';

class TodayRepository {
  WeatherFactory ws = WeatherFactory(_kKye);
  Future<Weather> queryWeatherGeolocator() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.openAppSettings();
        await Geolocator.openLocationSettings();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double? latitude = position.latitude;
    double? longitude = position.longitude;

    Weather weather = await ws.currentWeatherByLocation(latitude, longitude);

    return weather;
  }
}
