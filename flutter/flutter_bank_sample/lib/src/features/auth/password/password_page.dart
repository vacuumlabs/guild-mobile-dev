import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/theme/colors.dart';
import 'package:flutter_bank_sample/loading_state.dart';
import 'package:flutter_bank_sample/src/features/auth/bloc/authentication_bloc.dart';
import 'package:flutter_bank_sample/src/features/auth/widgets/logo.dart';
import 'package:flutter_bank_sample/src/extensions/widget.dart';
import 'package:flutter_bank_sample/src/theme/styling.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
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
            _PasswordTextField(),
            const Spacer(
              flex: 100,
            ),
            _NextStepButton().setPaddings(const EdgeInsets.all(Insets.extraLarge)),
          ],
        ),
      ],
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous.password.invalid != current.password.invalid,
      builder: (context, state) {
        return TextFormField(
          key: const Key('password_passwordInput_textField'),
          onChanged: (username) => context.read<AuthenticationBloc>().add(AuthenticationPasswordChanged(username)),
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: state.password.invalid ? 'Invalid password' : null,
          ),
        ).setPaddings(const EdgeInsets.all(Insets.extraLarge));
      },
    );
  }
}

class _NextStepButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous.loadingState != current.loadingState,
      builder: (context, state) {
        if (state.loadingState is Loading) {
          return const CircularProgressIndicator();
        }
        return OutlinedButton(
          key: const Key('password_submit'),
          child: Text(
            "Submit",
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
