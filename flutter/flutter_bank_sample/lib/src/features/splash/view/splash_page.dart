import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/features/splash/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_view.dart';

class SplashPage extends StatefulWidget {
  static const String route = "splash";

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(),
      child: const SplashView(),
    );
  }
}
