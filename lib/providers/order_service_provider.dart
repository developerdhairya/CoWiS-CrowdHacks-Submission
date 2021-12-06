import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderServiceProvider extends ChangeNotifier{
  Map<String, int> _orderMap = {};
  int orderQuantity=0;
  int orderAmount=0;


  static OrderServiceProvider instance = OrderServiceProvider();

  OrderServiceProvider() {}

  void addItem(String _itemID,int _amount) {
    if (_orderMap[_itemID] != null) {
      _orderMap[_itemID] = _orderMap[_itemID]! + 1;
    } else {
      _orderMap[_itemID] = 1;
    }
    orderQuantity+=1;
    orderAmount+=_amount;
    notifyListeners();
    print(_orderMap);
  }

  void removeItem(String _itemID,int _amount) {
    if (_orderMap[_itemID] != null) {
      _orderMap[_itemID] = _orderMap[_itemID]! - 1;
      if (_orderMap[_itemID] == 0) {
        _orderMap.remove(_itemID);
      }
      orderQuantity-=1;
      orderAmount-=_amount;
      notifyListeners();
    }
  }

  void resetOrders() {
    _orderMap = {};
    orderAmount=0;
    orderQuantity=0;
  }

  Future<void> createOrder(String _organisationID, String _serviceID) async{
    if (_orderMap != {}) {
      await FirebaseFirestore.instance
          .collection("organisations")
          .doc(_organisationID)
          .collection("services")
          .doc(_serviceID)
          .collection("orders")
          .doc()
          .set({
        "order":_orderMap,
        "orderPlacementTime":DateTime.now(),
      });
      resetOrders();
      debugPrint("Order Placed Successfully");
    }
  }
}
