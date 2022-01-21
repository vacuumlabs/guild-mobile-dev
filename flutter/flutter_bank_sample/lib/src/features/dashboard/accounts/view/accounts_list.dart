import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/extensions/widget.dart';
import 'package:flutter_bank_sample/src/features/dashboard/accounts/block/accounts_bloc.dart';
import 'package:flutter_bank_sample/src/features/dashboard/accounts/view/account_list_item.dart';
import 'package:flutter_bank_sample/src/theme/styling.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_loader.dart';

class AccountList extends StatefulWidget {
  const AccountList({Key? key}) : super(key: key);

  @override
  _AccountListState createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        switch (state.status) {
          case AccountsStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case AccountsStatus.success:
            if (state.accounts.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return _prepareListViewBuilder(state);
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  ListView _prepareListViewBuilder(AccountsState state) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _item(context, index, state);
      },
      itemCount: _itemCount(state),
      controller: _scrollController,
    );
  }

  int _itemCount(AccountsState state) {
    var count = 0;
    if (state.accounts.isNotEmpty) {
      // account header and loaded accounts
      count += 1 + state.accounts.length;
    }
    if (state.deposits.isNotEmpty) {
      // deposits header and loaded accounts
      count += 1 + state.deposits.length;
    }
    if (!state.hasReachedAccountsMax || !state.hasReachedDepositsMax) count += 1;
    return count;
  }

  Widget _item(BuildContext context, int index, AccountsState state) {
    if (state.accounts.isNotEmpty) {
      if (index == 0) return const _Header(label: "Accounts");
      index = index - 1;
      if (index < state.accounts.length) return AccountListItem(account: state.accounts[index]);
      index -= state.accounts.length;
    }
    if (state.deposits.isNotEmpty) {
      if (index == 0) return const _Header(label: "Deposits");
      index = index - 1;
      if (index < state.deposits.length) return AccountListItem(account: state.deposits[index]);
    }
    return const BottomLoader();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<AccountsBloc>().add(AccountsFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class _Header extends StatelessWidget {

  const _Header({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.headline5,
    ).setPaddings(const EdgeInsets.all(Insets.large));
  }

}
