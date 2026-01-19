import 'package:equatable/equatable.dart';

class HomeNavigationEvent extends Equatable {
  const HomeNavigationEvent();

  @override
  List<Object?> get props => [];
}

class HomeNavigationIndexChanged extends HomeNavigationEvent {
  final int index;

  const HomeNavigationIndexChanged(this.index);
}
