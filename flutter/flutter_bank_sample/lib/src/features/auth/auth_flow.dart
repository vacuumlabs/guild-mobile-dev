import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/features/auth/biometrics/biometrics_offer.dart';
import 'package:flutter_bank_sample/src/features/auth/intro/intro.dart';
import 'package:flutter_bank_sample/src/features/auth/password/password_page.dart';
import 'package:flutter_bank_sample/src/features/auth/username/username_page.dart';
import 'package:flutter_bank_sample/src/features/dashboard/dashboard_flow.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication_bloc.dart';

class AuthFlow extends StatefulWidget {
  static const String routePrefix = "auth";

  const AuthFlow({
    Key? key,
    required this.setupPageRoute,
  }) : super(key: key);

  final String setupPageRoute;

  @override
  _AuthFlowState createState() => _AuthFlowState();
}

class _AuthFlowState extends State<AuthFlow> {
  final GlobalKey<_StepNavigationState> _navigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onExitPressed() async {
    final isConfirmed = await _isExitDesired();
    if (isConfirmed && mounted) {
      _exitSetup();
    }
  }

  Future<bool> _isExitDesired() async {
    if (_navigationKey.currentState?._navigateToPrevious() == true) return false;
    return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('If you exit device setup, your progress will be lost.'),
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

  void _exitSetup() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExitDesired,
      child: Scaffold(
        appBar: _buildFlowAppBar(),
        body: BlocProvider(
          create: (context) {
            return AuthenticationBloc(
              authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: _StepNavigation(key: _navigationKey),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildFlowAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: _onExitPressed,
        icon: const Icon(Icons.chevron_left),
      ),
      title: const Text('Auth flow'),
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
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => context.read<AuthenticationBloc>().add(const AuthenticationLoadBiometrics()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.passed) Navigator.pushReplacementNamed(context, DashboardFlow.routePrefix);
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return _contentWidget(state);
        },
      ),
    );
  }

  Widget _contentWidget(AuthenticationState state) {
    late Widget page;
    switch (state.status) {
      case AuthenticationStatus.initial:
        page = const LoginIntroPage();
        break;
      case AuthenticationStatus.username:
        page = const UsernamePage();
        break;
      case AuthenticationStatus.password:
        page = const PasswordPage();
        break;
      case AuthenticationStatus.offerBiometrics:
        page = const BiometricsOfferPage();
        break;
      case AuthenticationStatus.passed:
        page = Container();
        break;
      default:
        page = const LoginIntroPage();
    }
    return page;
  }

  bool _navigateToPrevious() {
    if (context.read<AuthenticationBloc>().state.status != AuthenticationStatus.initial) {
      context.read<AuthenticationBloc>().add(const AuthenticationPreviousStepRequested());
      return true;
    }
    return false;
  }
}
