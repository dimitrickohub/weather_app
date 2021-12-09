import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

const String _kKye = '286bcef11450bc68f75fb791713f7be2';
const double _kLat = 52.1;
const double _kLon = 23.7;

class ColumnView extends StatefulWidget {
  const ColumnView({Key? key}) : super(key: key);

  @override
  State<ColumnView> createState() => _ColumnViewState();
}

class _ColumnViewState extends State<ColumnView> {
  late WeatherFactory ws;
  late List<Weather> _data;
  @override
  void initState() {
    super.initState();
    ws = WeatherFactory(_kKye);
  }

  Future<List<Weather>> queryWeather() async {
    Weather weather = await ws.currentWeatherByLocation(_kLat, _kLon);
    setState(() {
      _data = [weather];
    });
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        if (ConnectionState.active != null && !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (ConnectionState.done != null && snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Icon(
                  CupertinoIcons.snow,
                  size: 120,
                  color: Colors.yellow,
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Row(
                    children: [
                      Text(
                        snapshot.data[index].country.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                      const Divider(
                        height: 30,
                        color: Colors.black12,
                      ),
                      Text(
                        snapshot.data[index].areaName.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Center(
                  child: Text(
                    snapshot.data[index].temperature.toString(),
                    style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 30,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Divider(color: Colors.blue),
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    SizedBox(
                      width: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.drop,
                            color: Colors.yellow,
                            size: 50,
                          ),
                          Text(snapshot.data[index].humidity.toString()),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.cloud,
                            color: Colors.yellow,
                            size: 50,
                          ),
                          Text(snapshot.data[index].pressure.toString()),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.speedometer,
                            color: Colors.yellow,
                            size: 50,
                          ),
                          Text(snapshot.data[index].windSpeed.toString()),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.sun_haze,
                            color: Colors.yellow,
                            size: 50,
                          ),
                          Text(snapshot.data[index].weatherMain.toString())
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.compass,
                            color: Colors.yellow,
                            size: 50,
                          ),
                          Text(snapshot.data[index].weatherDescription
                              .toString())
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
      future: queryWeather(),
    );
  }
}
