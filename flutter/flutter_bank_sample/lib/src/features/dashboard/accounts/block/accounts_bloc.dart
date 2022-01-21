import 'dart:async';

import 'package:bank_data_repository/bank_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({required this.repository}) : super(const AccountsState()) {
    on<AccountsFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final BankDataRepository repository;

  Future<void> _onPostFetched(
      AccountsFetched event,
      Emitter<AccountsState> emit,
      ) async {
    var loadDeposits = true;
    if (!state.hasReachedAccountsMax) {
      try {
        final accounts = await repository.fetchAccounts(startIndex: state.accounts.length, postLimit: _postLimit);
        // load also deposits, when all accounts are loaded already
        loadDeposits = accounts.length < _postLimit;
        accounts.isEmpty
            ? emit(state.copyWith(hasReachedAccountsMax: true))
            : emit(
          state.copyWith(
            status: AccountsStatus.success,
            accounts: List.of(state.accounts)..addAll(accounts),
            hasReachedAccountsMax: false,
          ),
        );
      } catch (_) {
        emit(state.copyWith(status: AccountsStatus.failure));
      }
    }
    if (loadDeposits && !state.hasReachedDepositsMax) {
      try {
        final deposits = await repository.fetchDeposits(startIndex: state.deposits.length, postLimit: _postLimit);
        deposits.isEmpty
            ? emit(state.copyWith(hasReachedDepositsMax: true))
            : emit(
          state.copyWith(
            status: AccountsStatus.success,
            deposits: List.of(state.deposits)..addAll(deposits),
            hasReachedDepositsMax: false,
          ),
        );
      } catch (_) {
        emit(state.copyWith(status: AccountsStatus.failure));
      }
    }
  }
}