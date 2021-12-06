// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cowis/components/custom_app_bar.dart';
import 'package:cowis/components/order_card.dart';
import 'package:cowis/providers/order_service_provider.dart';
import 'package:cowis/services/email_service.dart';
import 'package:cowis/services/prompt_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class OfferingsPage extends StatefulWidget {
  const OfferingsPage(
      {Key? key, required this.organisationID, required this.serviceID})
      : super(key: key);
  final String organisationID;
  final String serviceID;

  @override
  _OfferingsPageState createState() => _OfferingsPageState();
}

class _OfferingsPageState extends State<OfferingsPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late OrderServiceProvider _orderServiceProvider;



  void onGooglePayResult(paymentResult) async {
    debugPrint(paymentResult.toString());
    await OrderServiceProvider.instance
        .createOrder(widget.organisationID, widget.serviceID);
    EmailService.instance.sendOtp();
    PromptService.instance.showOrderConfirmationPrompt(100.toString());
  }



  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _offeringsStream = FirebaseFirestore.instance
        .collection('organisations')
        .doc(widget.organisationID)
        .collection('services')
        .doc(widget.serviceID)
        .collection('offerings')
        .snapshots();

    PromptService.instance.buildContext = context;

    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider<OrderServiceProvider>.value(
      value: OrderServiceProvider.instance,
      child: Scaffold(
        appBar: CustomAppBar(
            appBar: AppBar(), title: "Make Your Order", buildContext: context),
        body: Container(
          height: _deviceHeight,
          width: _deviceWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/newbg.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Builder(builder: (_context) {
            _orderServiceProvider = Provider.of<OrderServiceProvider>(_context);
            final List<PaymentItem> _paymentItems = [
              PaymentItem(
                label: 'Total',
                amount: _orderServiceProvider.orderAmount.toString(),
                status: PaymentItemStatus.final_price,
              )
            ];
            return Stack(
              children: [
                Padding(
                  padding: _orderServiceProvider.orderAmount!=0?EdgeInsets.only(top: 10.0):EdgeInsets.only(top: 2.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _offeringsStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        children:
                            snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return OfferingCard(
                            itemId: document.id,
                            serviceID: widget.serviceID,
                            organisationID: widget.organisationID,
                            offeringImage: data["offeringImage"],
                            offeringName: data["offeringName"],
                            offeringPrice: data["offeringPrice"].toString(),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                _orderServiceProvider.orderQuantity!=0?Container(
                  height: 0.05 * _deviceHeight,
                  width: _deviceWidth,
                  color: Theme.of(context).accentColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Items X ${_orderServiceProvider.orderQuantity.toString()}",style: GoogleFonts.baloo().copyWith(color: Colors.white,fontWeight: FontWeight.w700),),
                      Text("Total : ₹ ${_orderServiceProvider.orderAmount.toString()}",style: GoogleFonts.baloo().copyWith(color: Colors.white,fontWeight: FontWeight.w700)),
                    ],
                  ),
                ):Container(),
                _orderServiceProvider.orderQuantity!=0?Align(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: GooglePayButton(
                      height: _deviceHeight * .05,
                      width: _deviceWidth * .80,
                      paymentConfigurationAsset: 'gpay.json',
                      paymentItems: _paymentItems,
                      style: GooglePayButtonStyle.black,
                      type: GooglePayButtonType.pay,
                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: onGooglePayResult,
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                ):Container(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
