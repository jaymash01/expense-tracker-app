import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/dashboard_model.dart';

class DashboardState extends Equatable {
  final bool isLoading;
  final DashboardResponseData? data;

  const DashboardState({this.isLoading = false, this.data});

  DashboardState copyWith({bool? isLoading, DashboardResponseData? data}) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isLoading, data];
}
