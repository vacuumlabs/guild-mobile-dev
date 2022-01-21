import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

enum DashboardSection {
  accounts,
  makePayment,
  profile,
}

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<DashboardSectionRequested>((event, emit) async {
      await _onSectionRequested(event, emit);
    });
  }

  Future<void> _onSectionRequested(
      DashboardSectionRequested event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(
      section: event.section,
    ));
  }
}
