// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cowis/components/custom_app_bar.dart';
import 'package:cowis/pages/offerings_page.dart';
import 'package:cowis/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key, required this.organisationID}) : super(key: key);

  final String organisationID;

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late Stream<QuerySnapshot> _organisationsStream;

  _ServicePageState() {
    try {
      _organisationsStream = FirebaseFirestore.instance
          .collection('organisations')
          .doc(widget.organisationID)
          .collection("services")
          .snapshots();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(),title: "Services",buildContext: context,),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/newbg.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('organisations')
            .doc(widget.organisationID)
            .collection("services")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          }

          return GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return _getServiceCard(
                  text: data["serviceName"],
                  image: data["serviceImage"],
                  serviceID: document.id,
                  organisationID: widget.organisationID);
            }).toList(),
          );
        },
      )),
    );
  }

  Padding _getServiceCard(
      {required String text,
      required String image,
      required String serviceID,
      required String organisationID}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 0.01 * _deviceHeight, horizontal: 0.01 * _deviceWidth),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTap: (){
              NavigationService.instance.navigateToMPR(OfferingsPage(organisationID: organisationID, serviceID: serviceID));
            },
            child: Card(
              color: Colors.white60.withOpacity(.4),
              elevation: 5.0,
              child: Column(
                children: [
                  Container(
                    height: constraints.maxHeight * .65,
                    width: constraints.maxWidth,
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * .10,
                  ),
                  Text(
                    text,
                    style: GoogleFonts.montserrat().copyWith(fontSize: 20),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
