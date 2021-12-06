import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';

class NavigationService{

  late GlobalKey<NavigatorState> navigatorKey;

  static NavigationService instance=NavigationService();

  NavigationService(){
    navigatorKey=GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateTo(String _routeName){
    return navigatorKey.currentState!.pushNamed(_routeName);
  }

  Future<dynamic> navigateToMPR(Widget _route){
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => _route,));
  }

  Future<dynamic> navigateToReplacement(String _routeName){
    return navigatorKey.currentState!.pushReplacementNamed(_routeName);
  }

  Future<dynamic> navigateToMPRReplacement(Widget _route){
    return navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context) => _route,));
  }

  void goBack(){
    return navigatorKey.currentState!.pop();
  }


}