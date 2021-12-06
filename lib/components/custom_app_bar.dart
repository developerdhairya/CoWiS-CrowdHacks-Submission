// ignore_for_file: prefer_const_constructors

import 'package:cowis/pages/accordion_page.dart';
import 'package:cowis/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      required this.appBar,
      required this.title,
      required this.buildContext})
      : super(key: key);

  final AppBar appBar;
  final String title;
  final BuildContext buildContext;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (_context) {
      return AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Theme.of(context).accentColor.withOpacity(.1)),
        leading: GestureDetector(
          onTap: () {
            NavigationService.instance.goBack();
          },
          child: Icon(Icons.arrow_back_ios_outlined),
        ),
        centerTitle: true,
        title: Text(title,
            style: GoogleFonts.lato().copyWith(color: Colors.white)),
        backgroundColor: Theme.of(context).accentColor.withOpacity(.8),
        elevation: 0.3,
        actions: [
          IconButton(
            icon: Icon(
              Icons.live_help_outlined,
              color: Colors.white,
              size: 27.0,
            ),
            onPressed: () {
              NavigationService.instance.navigateToMPR(AccordionPage());
            },
          ),
          IconButton(
            icon: Icon(
              Icons.share_outlined,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              Share.share(
                  "Checkout \"COWIS\" our hack for OctaHacks4.0 at https://devfolio.co/octahacks4/dashboard");
            },
          ),
          const SizedBox(
            width: 9.0,
          ),
        ],
      );
    });
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
