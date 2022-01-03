import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/screens/today_screen/app_bar.dart';

class TodayView extends StatefulWidget {
  const TodayView({Key? key, required this.snapshot}) : super(key: key);
  final Weather snapshot;
  @override
  State<TodayView> createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
  String todayDate = DateFormat('EEEE, d MMM, yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String iconUrl = "http://openweathermap.org/img/w/" +
        widget.snapshot.weatherIcon.toString() +
        '.png';
    String temp = widget.snapshot.temperature.toString();
    String areaName = widget.snapshot.areaName.toString();
    String weatherMain = widget.snapshot.weatherMain.toString();
    String tempMin = widget.snapshot.tempMin.toString();
    String tempMax = widget.snapshot.tempMax.toString();
    String tempFeelsLike = widget.snapshot.tempFeelsLike.toString();
    String humidity = widget.snapshot.humidity.toString();
    String pressure = widget.snapshot.pressure.toString();
    String windSpeed = widget.snapshot.windSpeed.toString();
    String cloudiness = widget.snapshot.cloudiness.toString();
    String windDegree = widget.snapshot.windDegree.toString();
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: TodayAppBar(),
      ),
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.03,
                    ),
                    child: Align(
                      child: Text(
                        areaName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.005,
                    ),
                    child: Align(
                      child: Text(
                        'Today - ' + todayDate, //day
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                    ),
                    child: Align(
                      child: Image.network(
                        iconUrl,
                        scale: 20,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.03,
                    ),
                    child: Align(
                      child: Text(
                        temp,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 40,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.25),
                    child: const Divider(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.005,
                    ),
                    child: Align(
                      child: Text(
                        weatherMain,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.03,
                      bottom: size.height * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tempMin,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                          ),
                        ),
                        const Text(
                          '/',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          tempMax,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                      bottom: size.height * 0.01,
                    ),
                    child: Align(
                      child: Text(
                        'Feels like ' + tempFeelsLike,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.25),
                    child: const Divider(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: buildItems(
                            humidity + '%',
                            CupertinoIcons.cloud_rain,
                            size,
                          ),
                        ),
                        Expanded(
                          child: buildItems(pressure + ' hPa',
                              CupertinoIcons.speedometer, size),
                        ),
                        Expanded(
                          child: buildItems(
                              windSpeed + ' km/h', CupertinoIcons.wind, size),
                        ),
                        Expanded(
                          child: buildItems(
                              cloudiness + '%', CupertinoIcons.cloud, size),
                        ),
                        Expanded(
                          child: buildItems(
                              windDegree + '˚', CupertinoIcons.wind_snow, size),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildItems(String data, IconData weatherIcon, size) {
  return Padding(
    padding: EdgeInsets.all(size.width * 0.025),
    child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.005,
              ),
              child: Icon(
                weatherIcon,
                color: Colors.black,
                size: size.height * 0.04,
              ),
            ),
          ],
        ),
        Text(
          data,
          style: TextStyle(
            color: Colors.black26,
            fontSize: size.height * 0.02,
          ),
        ),
      ],
    ),
  );
}
