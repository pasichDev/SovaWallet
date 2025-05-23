import 'package:flutter/material.dart';
import 'package:sovawallet/ui/pages/payment/screen/screen_payment.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/address_wallet.dart';
import '../../theme/style/text_style.dart';

class PaymentPage extends StatefulWidget {
  final Address address;
  final String receiver;

  const PaymentPage({Key? key, required this.address, this.receiver = ""})
      : super(key: key);

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.createPayment,
                textAlign: TextAlign.start,
                style: AppTextStyles.dialogTitle)),
        body:
            PaymentScreen(address: widget.address, receiver: widget.receiver));
  }
}
