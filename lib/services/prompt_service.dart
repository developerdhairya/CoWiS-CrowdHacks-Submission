import 'dart:math';

import 'package:cowis/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PromptService {
  late BuildContext _buildContext;

  static PromptService instance = PromptService();

  PromptService() {}

  set buildContext(_context) {
    _buildContext = _context;
  }

  void showExitPrompt() {
    showDialog(
      context: _buildContext,
      builder: (_buildContext) => AlertDialog(
        title: Text("IEEE Chitkara"),
        content: Text("Do want want to Exit the App?"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Yes"),
          ),
          TextButton(
            onPressed: () {},
            child: Text("No"),
          )
        ],
      ),
    );
  }

  void showOrderConfirmationPrompt(String _otp) {
    showDialog(
      useSafeArea: true,
      barrierColor: Theme.of(_buildContext).primaryColor.withOpacity(0.4),
      context: _buildContext,
      builder: (_buildContext) => AlertDialog(
        title: Image.asset(
          "assets/octahacks.jpg",
          width: 100,
          height: 50,
        ),
        content: Container(
          height: 90.0,
          width: 250.0,
          child: Column(
            children: [
              Text(
                "Your Order has been placed",
                style: GoogleFonts.montserrat()
                    .copyWith(color: Theme.of(_buildContext).accentColor,fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4.0,),
              Text(
                "Secret PIN:${Random().nextInt(9999)}",
                style: GoogleFonts.montserrat()
                    .copyWith(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                NavigationService.instance.goBack();
                NavigationService.instance.goBack();

              },
              child: Text("Okay"),
            ),
          ),
        ],
      ),
    );
  }
}
