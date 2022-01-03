import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/resources/forecast_repository.dart';
import 'package:weather_app/resources/today_repository.dart';
import 'package:weather_app/root.dart';

import 'bloc/root_bloc/root_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // ignore: avoid_print
    print(transition);
  }
}

void main() {
  SimpleBlocObserver();
  runApp(
    MyApp(
      todayRepository: TodayRepository(),
      foreRepository: ForecastRepository(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key, required this.todayRepository, required this.foreRepository})
      : super(key: key);
  final TodayRepository todayRepository;
  final ForecastRepository foreRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<RootBloc>(
        create: (context) => RootBloc(
          todayRepository: todayRepository,
          foreRepository: foreRepository,
        )..add(PageTapped(index: 0)),
        child: const RootApp(),
      ),
    );
  }
}
