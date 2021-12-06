// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import 'debug_firestore_service.dart';

class DebugScreen extends StatefulWidget {
  const DebugScreen({Key? key}) : super(key: key);

  @override
  State<DebugScreen> createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen> {

  final List<PaymentItem> _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
    print("success");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: GooglePayButton(
          width: 200.0,
          paymentConfigurationAsset: 'gpay.json',
          paymentItems: _paymentItems,
          style: GooglePayButtonStyle.black,
          type: GooglePayButtonType.order,
          margin: const EdgeInsets.only(top: 15.0),
          onPaymentResult: onGooglePayResult,
          loadingIndicator: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        // child: MaterialButton(
        //   color: Colors.red,
        //   onPressed: () {
        //     DebugFirestoreService.instance.cloneService();
        //   },
        // ),
      ),
    ));
  }
}
