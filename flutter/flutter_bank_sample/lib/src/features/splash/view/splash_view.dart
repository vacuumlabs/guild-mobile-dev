import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/extensions/build_context.dart';
import 'package:flutter_bank_sample/src/features/auth/intro/intro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../splash.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => context.read<SplashCubit>().startCountDown());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, bool>(
      listener: (context, state) {
        if (!state) {
          Navigator.pushReplacementNamed(context, LoginIntroPage.route);
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            context.isDarkMode() ? "assets/image/vacuumlabs_logo_symbol_inverse_rgb.png" : "assets/image/vacuumlabs_logo_symbol_rgb.png",
            width: 200,
          ),
        ),
      ),
    );
  }
}
