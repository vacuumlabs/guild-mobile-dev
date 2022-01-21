import 'package:biometric_storage/biometric_storage.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/theme/colors.dart';
import 'package:flutter_bank_sample/src/features/auth/bloc/authentication_bloc.dart';
import 'package:flutter_bank_sample/src/features/auth/widgets/logo.dart';
import 'package:flutter_bank_sample/src/extensions/widget.dart';
import 'package:flutter_bank_sample/src/theme/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricsOfferPage extends StatefulWidget {
  static const String route = "auth/biometricsOffer";

  const BiometricsOfferPage({Key? key}) : super(key: key);

  @override
  State<BiometricsOfferPage> createState() => _BiometricsOfferPageState();
}

class _BiometricsOfferPageState extends State<BiometricsOfferPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Logo(),
        Column(
          children: [
            const Spacer(
              flex: 80,
            ),
            Align(
              alignment: const Alignment(0.0, 0.5),
              child: _BiometricsSetupButton(),
            ),
            _SkipButton(),
            const Spacer(
              flex: 100,
            ),
          ],
        ),
      ],
    );
  }
}

class _BiometricsSetupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return OutlinedButton(
          child: Text(
            "Setup biometrics login",
            style: Theme.of(context).textTheme.button?.copyWith(
              color: CustomColors.buttonLabelColor,
            ),
          ),
          onPressed: () {
            context.read<AuthenticationBloc>().add(const AuthenticationSaveBiometrics());
          },
        );
      },
    );
  }
}

class _SkipButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return TextButton(
          child: const Text("Skip biometrics setup"),
          onPressed: () {
            context.read<AuthenticationBloc>().add(const AuthenticationSkipBiometrics());
          },
        );
      },
    );
  }
}
