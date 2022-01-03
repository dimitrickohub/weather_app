import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/resources/forecast_repository.dart';
import 'package:weather_app/resources/today_repository.dart';
part 'root_state.dart';
part 'root_event.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  final TodayRepository todayRepository;
  final ForecastRepository foreRepository;
  int currentIndex = 0;
  RootBloc({required this.todayRepository, required this.foreRepository})
      : super(PageLoading()) {
    on<PageTapped>(_onStarted);
  }

  void _onStarted(RootEvent event, Emitter<RootState> emit) async {
    emit(CurrentIndexChanged(currentIndex: currentIndex));

    if (event is PageTapped) {
      currentIndex = event.index;
      emit(CurrentIndexChanged(currentIndex: currentIndex));
      emit(PageLoading());

      if (currentIndex == 0) {
        final weather = await todayRepository.queryWeatherGeolocator();
        emit(LoadedTodayState(weather: weather));
      }
      if (currentIndex == 1) {
        final weather = await foreRepository.queryWeatherGeolocator();
        emit(LoadedForecastState(weather: weather));
      }
    }
  }
}
