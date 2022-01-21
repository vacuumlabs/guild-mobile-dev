import 'package:bank_data_repository/bank_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/extensions/widget.dart';
import 'package:flutter_bank_sample/src/features/dashboard/accounts/block/accounts_bloc.dart';
import 'package:flutter_bank_sample/src/features/dashboard/accounts/view/accounts_list.dart';
import 'package:flutter_bank_sample/src/theme/styling.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountsSection extends StatefulWidget {
  static const String route = "dashboard/accounts";

  const AccountsSection({Key? key}) : super(key: key);

  @override
  State<AccountsSection> createState() => _AccountsSectionState();
}

class _AccountsSectionState extends State<AccountsSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bankRepo = RepositoryProvider.of<BankDataRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 26.0,
            onPressed: () {
              Fluttertoast.showToast(
                msg: "Search not implemented.",
              );
            },
          ).setPaddings(const EdgeInsets.only(right: Insets.small)),
        ],
      ),
      body: BlocProvider(
        create: (_) => AccountsBloc(repository: bankRepo)..add(AccountsFetched()),
        child: const AccountList(),
      ),
    );

  }
}
