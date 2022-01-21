import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/extensions/widget.dart';
import 'package:flutter_bank_sample/src/theme/styling.dart';

class ProfileSection extends StatefulWidget {
  static const String route = "dashboard/profile";

  const ProfileSection({Key? key}) : super(key: key);

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User profile'),
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            iconSize: 26.0,
            onPressed: () {
              // TODO logout here
              Navigator.pop(context);
            },
          ).setPaddings(const EdgeInsets.only(right: Insets.small)),
        ],
      ),
      body: const Text("There will be user profile value list here"),
    );

  }
}
