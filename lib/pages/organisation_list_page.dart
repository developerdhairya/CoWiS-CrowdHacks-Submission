// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cowis/components/custom_app_bar.dart';
import 'package:cowis/pages/service_page.dart';
import 'package:cowis/services/navigation_service.dart';
import 'package:flutter/material.dart';

class OrganisationListPage extends StatefulWidget {
  const OrganisationListPage({Key? key}) : super(key: key);

  @override
  State<OrganisationListPage> createState() => _OrganisationListPageState();
}

class _OrganisationListPageState extends State<OrganisationListPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late Stream<QuerySnapshot> _organisationsStream;

  _OrganisationListPageState() {
    _organisationsStream =
        FirebaseFirestore.instance.collection('organisations').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: CustomAppBar(buildContext: context,title: "Select Organisation",appBar: AppBar(),),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/newbg.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: _organisationsStream,
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

  Card _getOrganisationCard({
    required BuildContext context,
    required String text,
    required String image,
    required String organisationID,
  }) {
    return Card(
      color: Colors.teal.withOpacity(0.4),
      child: ListTile(
        onTap: () {
          NavigationService.instance
              .navigateToMPR(ServicePage(organisationID: organisationID));
        },
        title: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),
        ),
        leading: Container(
          height: 50,
          width: 50.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
