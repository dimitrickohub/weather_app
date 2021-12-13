import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/screens/forecast_screen.dart';
import 'package:weather_app/screens/today_screen/today_screen.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: getFooter(),
        body: getBody(),
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTab,
      children: const [
        TodayScreen(),
        ForecastScreen(),
      ],
    );
  }

  Widget getFooter() {
    List items = [
      CupertinoIcons.sun_max,
      CupertinoIcons.cloud_sun,
    ];

    return Container(
      alignment: Alignment.center,
      height: 70,
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          items.length,
          (index) {
            return Expanded(
              flex: 2,
              child: IconButton(
                iconSize: 35,
                icon: Icon(items[index],
                    color: activeTab == index ? Colors.blue : Colors.black),
                onPressed: () {
                  setState(
                    () {
                      activeTab = index;
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
