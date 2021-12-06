import 'dart:math';

import 'package:cowis/providers/auth_service_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sendgrid_mailer/sendgrid_mailer.dart';

class EmailService {
  static EmailService instance = EmailService();

  void sendOtp() {
    try {
      Mailer mailer = Mailer(
          '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');
      Address toAddress = Address(AuthServiceProvider.instance.userEmailID);
      Address fromAddress = Address('dhairya0192.be20@chitkara.edu.in');
      Content content = Content('text/plain',
          'Dear ${AuthServiceProvider.instance.userName},Your Order has been successfully placed..You will receive the OTP as soon as the outlet confirms the order..');
      String subject = 'Payment Successful';
      Personalization personalization = Personalization([toAddress]);
      Email email =
          Email([personalization], fromAddress, subject, content: [content]);
      mailer.send(email).then((result) {
        print(result);
        print("mail sent");
      });
    } catch (e) {
      print(e);
    }
  }
}
