part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.section = DashboardSection.accounts,
  });

  DashboardState copyWith({
    DashboardSection? section,
  }) {
    return DashboardState(
      section: section ?? this.section,
    );
  }

  final DashboardSection section;

  @override
  List<Object> get props => [section];
}
