import 'package:accordion/accordion.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cowis/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AccordionPage extends StatefulWidget {
  const AccordionPage({Key? key}) : super(key: key);

  @override
  State<AccordionPage> createState() => _AccordionPageState();
}

class _AccordionPageState extends State<AccordionPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
        title: "FAQ\'s",
        buildContext: context,
      ),
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/newbg.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Accordion(
          headerBackgroundColor: Colors.teal.withOpacity(0.4),
          maxOpenSections: 1,
          // header: ,
          // headerTextStyle: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          leftIcon: Icon(Icons.audiotrack, color: Colors.white),
          children: [
            AccordionSection(
              header: AutoSizeText(
                "My money is deducted but order is not showing on the screen?",
                style: TextStyle(color: Colors.white),
              ),
              content: AutoSizeText(
                  'At times,servers of your Bank send late confirmation due to security check policies in India.As the payment is confirmed,order is shown as success'),
            ),
            AccordionSection(
              header: AutoSizeText(
                "What if my order is rejected?",
                maxLines: 1,
                style: TextStyle(color: Colors.white),

              ),
              content: AutoSizeText(
                'In case any outlet/organisation reject your order,server will raise the refund request and money would be transferred back to the original payment source.',
              ),
            ),
            AccordionSection(
              header: AutoSizeText(
                "What is the refund Cycle of Payments?",
                style: TextStyle(color: Colors.white),
              ),
              content: AutoSizeText(
                'It usually takes maximum of 5-7 working days for the refund to reflected in your account..However exact time depends on your bank only.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
