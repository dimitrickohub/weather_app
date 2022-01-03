part of 'root_bloc.dart';

@immutable
abstract class RootState extends Equatable {
  const RootState([List props = const []]) : super();
}

class CurrentIndexChanged extends RootState {
  final int currentIndex;

  CurrentIndexChanged({required this.currentIndex}) : super([currentIndex]);

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';

  @override
  List<Weather> get props => [];
}

class PageLoading extends RootState {
  @override
  String toString() => 'PageLoading';

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoadedTodayState extends RootState {
  const LoadedTodayState({required this.weather});

  final Weather weather;

  @override
  List<Object> get props => [weather];
}

class LoadedForecastState extends RootState {
  const LoadedForecastState({required this.weather});

  final List<Weather> weather;

  @override
  List<Object> get props => [weather];
}
