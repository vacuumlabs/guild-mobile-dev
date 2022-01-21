import 'package:bank_data_repository/bank_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/extensions/widget.dart';
import 'package:flutter_bank_sample/src/theme/styling.dart' as styling;

class AccountListItem extends StatelessWidget {
  const AccountListItem({Key? key, required this.account}) : super(key: key);

  final Account account;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Ink(
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.secondary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(styling.Radius.medium)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Ink(
            decoration: ShapeDecoration(
              color: Theme.of(context).canvasColor,
              shape: const CircleBorder(),
            ),
            child: IconButton(
              iconSize: 30.0,
              onPressed: () {},
              icon: const Icon(Icons.account_balance),
              color: Theme.of(context).primaryColor,

            ),
          ).setPaddings(const EdgeInsets.only(right: styling.Insets.small)),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${account.id} ${account.title}', style: textTheme.bodyText2, softWrap: true,),
                Text('${account.body}', style: textTheme.caption, softWrap: true,),
              ],
            ),
          ),
          Text('${account.id} EUR', style: textTheme.headline6,),
        ],
      ).setPaddings(const EdgeInsets.all(styling.Insets.medium))
    ).setPaddings(const EdgeInsets.all(styling.Insets.medium));
  }
}
