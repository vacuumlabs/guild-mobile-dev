import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/theme/colors.dart';
import 'package:flutter_bank_sample/loading_state.dart';
import 'package:flutter_bank_sample/src/features/auth/bloc/authentication_bloc.dart';
import 'package:flutter_bank_sample/src/features/auth/widgets/logo.dart';
import 'package:flutter_bank_sample/src/extensions/widget.dart';
import 'package:flutter_bank_sample/src/theme/styling.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginIntroPage extends StatefulWidget {
  static const String route = "auth/login";

  const LoginIntroPage({Key? key}) : super(key: key);

  @override
  State<LoginIntroPage> createState() => _LoginIntroPageState();
}

class _LoginIntroPageState extends State<LoginIntroPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Logo(),
        _IntroContent(),
      ],
    );
  }
}

class _IntroContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous.loadingState != current.loadingState,
      builder: (context, state) {
        if (state.loadingState is Loading) {
          return const Center(child: CircularProgressIndicator(),);
        }
        return Column(
          children: [
            const Spacer(
              flex: 80,
            ),
            Align(
              alignment: const Alignment(0.0, 0.5),
              child: _LoginButton(),
            ),
            TextButton(
              child: const Text("Forgot credentials?"),
              onPressed: _moveToForgot,
            ),
            Align(
              alignment: const Alignment(0.0, 0.5),
              child: _BiometricsButton(),
            ),
            const Spacer(
              flex: 100,
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Issue with signing-in? You can contact us on mail ",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                TextSpan(
                    text: "mail@mail.com",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _launchSupportEmail();
                      })
              ]),
            ).setPaddings(const EdgeInsets.all(Insets.extraLarge)),
          ],
        );
      },
    );
  }

  void _moveToForgot() {
    Fluttertoast.showToast(
      msg: "Forgot password not implemented.",
    );
  }

  void _launchSupportEmail() async {
    await EmailLauncher.launch(Email(to: ["mail@mail.com"]));
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return OutlinedButton(
          child: Text(
            "Login with credentials",
            style: Theme.of(context).textTheme.button?.copyWith(
              color: CustomColors.buttonLabelColor,
            ),
          ),
          onPressed: () {
            context.read<AuthenticationBloc>().add(const AuthenticationNextStepRequested());
          },
        );
      },
    );
  }
}

class _BiometricsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous.biometrics != current.biometrics,
      builder: (context, state) {
        var enabled = state.biometrics.loginPresent && state.biometrics.available;
        if (!enabled) return Container();
        return OutlinedButton(
          child: Text(
            "Login with biometrics",
            style: Theme.of(context).textTheme.button?.copyWith(
              color: CustomColors.buttonLabelColor,
            ),
          ),
          onPressed: () {
            context.read<AuthenticationBloc>().add(const AuthenticationBiometricLogin());
          },
        );
      },
    );
  }
}
