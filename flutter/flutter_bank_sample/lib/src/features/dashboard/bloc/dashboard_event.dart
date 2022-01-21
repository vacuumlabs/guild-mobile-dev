part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardSectionRequested extends DashboardEvent {
  const DashboardSectionRequested({required this.section});

  final DashboardSection section;
}
