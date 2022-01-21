part of 'accounts_bloc.dart';

enum AccountsStatus { initial, success, failure }

class AccountsState extends Equatable {
  const AccountsState({
    this.status = AccountsStatus.initial,
    this.accounts = const <Account>[],
    this.deposits = const <Account>[],
    this.hasReachedAccountsMax = false,
    this.hasReachedDepositsMax = false,
  });

  final AccountsStatus status;
  final List<Account> accounts;
  final List<Account> deposits;
  final bool hasReachedAccountsMax;
  final bool hasReachedDepositsMax;

  AccountsState copyWith({
    AccountsStatus? status,
    List<Account>? accounts,
    List<Account>? deposits,
    bool? hasReachedAccountsMax,
    bool? hasReachedDepositsMax,
  }) {
    return AccountsState(
      status: status ?? this.status,
      accounts: accounts ?? this.accounts,
      deposits: deposits ?? this.deposits,
      hasReachedAccountsMax: hasReachedAccountsMax ?? this.hasReachedAccountsMax,
      hasReachedDepositsMax: hasReachedDepositsMax ?? this.hasReachedDepositsMax,
    );
  }

  @override
  String toString() {
    return '''AccountsState { status: $status, hasReachedMax: $hasReachedAccountsMax, accounts: ${accounts.length} , hasReachedMax: $hasReachedDepositsMax, accounts: ${deposits.length} }''';
  }

  @override
  List<Object> get props => [status, accounts, deposits, hasReachedAccountsMax, hasReachedDepositsMax];
}
