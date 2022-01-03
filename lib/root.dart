import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/screens/forecast_screen/forecast_view.dart';
import 'package:weather_app/screens/today_screen/today_view.dart';

import 'bloc/root_bloc/root_bloc.dart';

class RootApp extends StatelessWidget {
  const RootApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RootBloc, RootState>(
        builder: (BuildContext context, RootState state) {
          if (state is PageLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LoadedTodayState) {
            return TodayView(snapshot: state.weather);
          }
          if (state is LoadedForecastState) {
            return ForecastView(snapshot: state.weather);
          }
          return const Center(
              child: Text(
            'Something went wrong',
            style: TextStyle(
                color: Colors.red, fontSize: 25, fontWeight: FontWeight.w500),
          ));
        },
      ),
      bottomNavigationBar: BlocBuilder<RootBloc, RootState>(
          builder: (BuildContext context, RootState state) {
        return BottomNavigationBar(
          currentIndex: context.select((RootBloc bloc) => bloc.currentIndex),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.sun_max, color: Colors.black),
              label: 'Today',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cloud_sun, color: Colors.black),
              label: 'Forecast',
            ),
          ],
          onTap: (index) =>
              context.read<RootBloc>().add(PageTapped(index: index)),
        );
      }),
    );
  }
}
