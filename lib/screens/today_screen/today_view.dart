import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

const String _kKye = '286bcef11450bc68f75fb791713f7be2';

class TodayView extends StatefulWidget {
  const TodayView({Key? key}) : super(key: key);

  @override
  State<TodayView> createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
  late Future myFuture;
  late WeatherFactory ws;
  late List<Weather> _data;
  double? latitude;
  double? longitude;
  Position? position;

  String todayDate = DateFormat('EEEE, d MMM, yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    myFuture = queryWeatherGeolocator();
    ws = WeatherFactory(_kKye);
  }

  @override
  void dispose() {
    super.dispose();
    queryWeatherGeolocator();
  }

  Future<List<Weather>> queryWeatherGeolocator() async {
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
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latitude = position!.latitude;
    longitude = position!.longitude;

    Weather weather = await ws.currentWeatherByLocation(latitude!, longitude!);
    setState(() {
      _data = [weather];
    });
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active &&
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    todayDate,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Icon(
                  CupertinoIcons.snow,
                  size: 120,
                  color: Colors.blueGrey,
                ),
                Center(
                  child: Text(
                    snapshot.data[index].temperature.toString(),
                    style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Center(
                  child: Text(
                    snapshot.data[index].areaName.toString() +
                        ' ' +
                        snapshot.data[index].country.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Divider(thickness: 5, color: Colors.black26),
                Wrap(
                  spacing: 30,
                  direction: Axis.vertical,
                  children: [
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.drop,
                            color: Colors.blueGrey,
                            size: 60,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Humidity: ' +
                                snapshot.data[index].humidity.toString() +
                                ' %',
                            style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 30,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.cloud,
                            color: Colors.blueGrey,
                            size: 60,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Pressure: ' +
                                snapshot.data[index].pressure.toString() +
                                ' hPa',
                            style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 30,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.speedometer,
                            color: Colors.blueGrey,
                            size: 60,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Wind speed: ' +
                                snapshot.data[index].windSpeed.toString() +
                                ' km/h',
                            style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 30,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.cloud,
                            color: Colors.blueGrey,
                            size: 60,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Weather main: ' +
                                snapshot.data[index].weatherMain.toString(),
                            style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 30,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.compass,
                            color: Colors.blueGrey,
                            size: 60,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Wether description: ' +
                                snapshot.data[index].weatherDescription
                                    .toString(),
                            style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 30,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      future: myFuture,
    );
  }
}
