import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/theme/colors.dart';
import 'package:flutter_bank_sample/src/features/auth/bloc/authentication_bloc.dart';
import 'package:flutter_bank_sample/src/features/auth/widgets/logo.dart';
import 'package:flutter_bank_sample/src/extensions/widget.dart';
import 'package:flutter_bank_sample/src/theme/styling.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({Key? key}) : super(key: key);

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
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
            _UsernameTextField(),
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

class _UsernameTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous.username.invalid != current.username.invalid,
      builder: (context, state) {
        return TextFormField(
          key: const Key('username_usernameInput_textField'),
          initialValue: state.username.value,
          onChanged: (username) => context.read<AuthenticationBloc>().add(AuthenticationUserNameChanged(username)),
          decoration: InputDecoration(
            labelText: 'Username',
            errorText: state.username.invalid ? 'Invalid username' : null,
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
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return OutlinedButton(
          key: const Key('username_nextStep_button'),
          child: Text(
            "Next step",
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
