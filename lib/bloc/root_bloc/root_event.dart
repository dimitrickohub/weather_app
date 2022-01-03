part of 'root_bloc.dart';

abstract class RootEvent extends Equatable {
  const RootEvent([List props = const []]) : super();
}

class AppStarted extends RootEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Weather> get props => [];
}

class PageTapped extends RootEvent {
  final int index;

  PageTapped({required this.index}) : super([index]);

  @override
  String toString() => 'PageTapped: $index';

  @override
  List<Weather> get props => [];
}
