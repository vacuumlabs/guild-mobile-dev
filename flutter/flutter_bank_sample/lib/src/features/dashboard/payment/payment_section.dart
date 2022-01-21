import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/extensions/widget.dart';
import 'package:flutter_bank_sample/src/theme/styling.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentSection extends StatefulWidget {
  static const String route = "dashboard/payment";

  const PaymentSection({Key? key}) : super(key: key);

  @override
  State<PaymentSection> createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make payment'),
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            iconSize: 26.0,
            onPressed: () {
              Fluttertoast.showToast(
                msg: "QR code loading not implemented.",
              );
            },
          ).setPaddings(const EdgeInsets.only(right: Insets.small)),
        ],
      ),
      body: const Text("There will be make payment action list here"),
    );

  }
}
