// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late Stream<QuerySnapshot> _offeringsStream;

  _OrderPageState(){
    _offeringsStream =
        FirebaseFirestore.instance.collection('organisations').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Make Your Order",
        ),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.live_help_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.share_outlined)),
              SizedBox(
                width: 8.0,
              ),
            ],
          )
        ],
      ),
      body: Container(
          height: _deviceHeight,
          width: _deviceWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: _offeringsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox();
              }
              return ListView(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
                  return _getOrganisationCard(
                    context: context,
                    image: data["organisationImage"],
                    text: data["organisationName"],
                    organisationID: document.id.toString(),
                  );
                }).toList(),
              );
            },
          ),
      ),
    );
  }
}
