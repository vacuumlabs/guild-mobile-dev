import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/extensions/widget.dart';
import 'package:flutter_bank_sample/src/features/dashboard/accounts/accounts_section.dart';
import 'package:flutter_bank_sample/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter_bank_sample/src/features/dashboard/payment/payment_section.dart';
import 'package:flutter_bank_sample/src/features/dashboard/profile/profile_section.dart';
import 'package:flutter_bank_sample/src/theme/styling.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardFlow extends StatefulWidget {
  static const String routePrefix = "dashboard";

  const DashboardFlow({
    Key? key,
    required this.setupPageRoute,
  }) : super(key: key);

  final String setupPageRoute;

  @override
  _DashboardFlowState createState() => _DashboardFlowState();
}

class _DashboardFlowState extends State<DashboardFlow> {
  final GlobalKey<_StepNavigationState> _navigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _isExitDesired() async {
    if (_navigationKey.currentState?._navigateToDefaultSection() == true) return false;
    return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('You will be logged out and application will be closed.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Leave'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Stay'),
                  ),
                ],
              );
            }) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExitDesired,
      child: BlocProvider(
        create: (context) {
          return DashboardBloc();
        },
        child: _StepNavigation(key: _navigationKey),
      ),
    );
  }
}

class _StepNavigation extends StatefulWidget {
  const _StepNavigation({Key? key}) : super(key: key);

  @override
  _StepNavigationState createState() => _StepNavigationState();
}

class _StepNavigationState extends State<_StepNavigation> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) => previous.section != current.section,
      builder: (context, state) {
        return Scaffold(
          body: _contentWidget(state),
          bottomNavigationBar: BottomAppBar(
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              child: SizedBox(
                height: 75,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const _BottomNavigationItem(
                      section: DashboardSection.accounts,
                    ).setPaddings(const EdgeInsets.only(left: Insets.extraLarge)),
                    const _BottomNavigationItem(
                      section: DashboardSection.makePayment,
                    ).setPaddings(const EdgeInsets.only(right: Insets.extraLarge, left: Insets.extraLarge)),
                    const _BottomNavigationItem(
                      section: DashboardSection.profile,
                    ).setPaddings(const EdgeInsets.only(right: Insets.extraLarge)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _contentWidget(DashboardState state) {
    late Widget page;
    switch (state.section) {
      case DashboardSection.accounts:
        page = const AccountsSection();
        break;
      case DashboardSection.makePayment:
        page = const PaymentSection();
        break;
      case DashboardSection.profile:
        page = const ProfileSection();
        break;
      default:
        page = const AccountsSection();
    }
    return page;
  }

  bool _navigateToDefaultSection() {
    if (context.read<DashboardBloc>().state.section != DashboardSection.accounts) {
      context.read<DashboardBloc>().add(const DashboardSectionRequested(section: DashboardSection.accounts));
      return true;
    }
    return false;
  }
}

class _BottomNavigationItem extends StatelessWidget {
  const _BottomNavigationItem({
    Key? key,
    required this.section,
  }) : super(key: key);

  final DashboardSection section;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
        buildWhen: (previous, current) => previous.section != current.section,
        builder: (context, state) {
          late String label;
          late IconData iconData;
          switch (section) {
            case DashboardSection.accounts: {
              label = "Accounts";
              iconData = Icons.home;
              break;
            }
            case DashboardSection.makePayment: {
              label = "Make payment";
              iconData = Icons.compare_arrows;
              break;
            }
            case DashboardSection.profile: {
              label = "User profile";
              iconData = Icons.face;
              break;
            }
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 30.0,
                icon: Icon(iconData),
                color: section == state.section ? Theme.of(context).primaryColor : Theme.of(context).iconTheme.color,
                onPressed: () {
                  context.read<DashboardBloc>().add(DashboardSectionRequested(section: section));
                },
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          );
        });
  }
}
