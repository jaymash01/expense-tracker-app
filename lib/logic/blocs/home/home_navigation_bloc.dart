import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_navigation_state.dart';
import 'home_navigation_event.dart';

class HomeNavigationBloc
    extends Bloc<HomeNavigationEvent, HomeNavigationState> {
  HomeNavigationBloc() : super(const HomeNavigationState()) {
    on<HomeNavigationIndexChanged>(_onHomeNavigationIndexChanged);
  }

  Future<void> _onHomeNavigationIndexChanged(
    HomeNavigationIndexChanged event,
    Emitter<HomeNavigationState> emit,
  ) async {
    emit(state.copyWith(index: event.index));
  }
}
