import 'package:flutter/material.dart';
import 'package:weather_app/screens/today_screen/app_bar.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: TodayAppBar(),
      ),
    );
  }
}
