import 'package:expense_tracker/data/repositories/dashboard_repository.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository dashboardRepository = DashboardRepository();
  final AuthBloc authBloc;

  DashboardBloc({required this.authBloc}) : super(const DashboardState()) {
    on<LoadDashboard>(_onLoadDashboard);
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final token = authBloc.state.token ?? '';

      final response = await dashboardRepository.fetchDashboard(token);
      emit(state.copyWith(data: response.data, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
