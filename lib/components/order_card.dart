import 'package:auto_size_text/auto_size_text.dart';
import 'package:cowis/components/round_icon_button.dart';
import 'package:cowis/providers/order_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferingCard extends StatefulWidget {
  const OfferingCard({
    Key? key,
    required String itemId,
    required String organisationID,
    required String serviceID,
    required String offeringName,
    required String offeringImage,
    required String offeringPrice,
  })  : _itemId = itemId,
        _organisationID = organisationID,
        _serviceID = serviceID,
        _offeringImage = offeringImage,
        _offeringName = offeringName,
        _offeringPrice = offeringPrice,
        super(key: key);

  final String _organisationID;
  final String _serviceID;
  final String _itemId;
  final String _offeringName;
  final String _offeringImage;
  final String _offeringPrice;

  @override
  State<OfferingCard> createState() => _OfferingCardState();
}

class _OfferingCardState extends State<OfferingCard> {
  int orderQuantity = 0;
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * .05),
      child: Card(
        color: Colors.transparent,
          elevation: 4.0,
          child: Container(
              color: Colors.white.withOpacity(.7),
              width: _deviceWidth * .95,
              child: Row(
                children: [
                  SizedBox(
                    child: Image.network(
                      widget._offeringImage,
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      },
                      height: _deviceHeight * .20,
                      width: _deviceWidth * .40,
                    ),
                    height: _deviceHeight * .20,
                    width: _deviceWidth * .40,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AutoSizeText(
                          widget._offeringName,
                          maxLines: 1,
                          style: GoogleFonts.baloo()
                              .copyWith(color: Colors.teal, fontSize: 25.0),
                        ),
                        AutoSizeText(
                          "₹"+widget._offeringPrice,
                          maxLines: 1,
                          style: GoogleFonts.baloo().copyWith(
                            color: Colors.teal,
                            fontSize: 20.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RoundIconButton(
                                icon: Icons.remove,
                                onPressed: () {
                                  setState(() {
                                    if (orderQuantity != 0) {
                                      orderQuantity -= 1;
                                      OrderServiceProvider.instance
                                          .removeItem(widget._itemId,int.parse(widget._offeringPrice));
                                    }
                                  });
                                }),
                            AutoSizeText(
                              orderQuantity.toString(),
                              maxLines: 1,
                              style: GoogleFonts.baloo().copyWith(
                                color: Colors.teal,
                                fontSize: 18.0,
                              ),
                            ),
                            RoundIconButton(
                                icon: Icons.add,
                                onPressed: () {
                                  setState(() {
                                    orderQuantity += 1;
                                    OrderServiceProvider.instance
                                        .addItem(widget._itemId,int.parse(widget._offeringPrice));
                                    print("done");
                                  });
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}
