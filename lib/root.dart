import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTab,
      children: [
        // const TodayScreen(),
        // const ForecastScreen(),
      ],
    );
  }

  Widget getFooter() {
    List items = [
      CupertinoIcons.sun_haze,
      CupertinoIcons.cloud_bolt_rain_fill,
    ];
    return Container(
        alignment: Alignment.center,
        height: 70,
        decoration: const BoxDecoration(),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(items.length, (index) {
              return Expanded(
                flex: 2,
                child: IconButton(
                    icon: Icon(items[index],
                        color: activeTab == index ? Colors.blue : Colors.black),
                    onPressed: () {
                      setState(() {
                        activeTab = index;
                      });
                    }),
              );
            })));
  }
}
