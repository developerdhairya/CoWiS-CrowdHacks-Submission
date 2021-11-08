import 'package:cowis/providers/auth_service_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:particles_flutter/particles_flutter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          children: [
            CircularParticle(
              key: UniqueKey(),
              awayRadius: 0.0,
              numberOfParticles: 200,
              speedOfParticles: 1,
              height: _deviceHeight,
              width: _deviceWidth,
              onTapAnimation: false,
              particleColor: Theme.of(context).primaryColor.withOpacity(0.1),
              maxParticleSize: 5,
              isRandSize: false,
              isRandomColor: false,
              awayAnimationCurve: Curves.easeInOutBack,
              enableHover: false,
              hoverColor: Theme.of(context).primaryColor.withOpacity(0.4),
              connectDots: true,
            ),
            Column(
              children: [
                SizedBox(height: .15*_deviceHeight,),
                SizedBox(
                  child: SvgPicture.asset(
                    "assets/cowis.svg",
                    fit: BoxFit.fill,
                  ),
                  width: 0.7 * _deviceWidth,
                  height: .30*_deviceHeight,
                ),
                SizedBox(
                  height: _deviceHeight * 0.10,
                ),
                Center(
                  child: Card(
                    color: Colors.transparent,
                    elevation: 10.0,
                    child: Container(
                      height: 0.08 * _deviceHeight,
                      width: 0.90 * _deviceWidth,
                      child: GestureDetector(
                        onTap: () {
                          AuthServiceProvider.instance.signInWithGoogle();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          height: 0.08 * _deviceHeight,
                          width: 0.80 * _deviceWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/google.png',
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Text(
                                "Continue With Google",
                                style:
                                    GoogleFonts.roboto().copyWith(fontSize: 25.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text("For Service Consumers Only"),
                SizedBox(
                  height: _deviceHeight * 0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 0.12*_deviceHeight,
                      width: 0.35*_deviceWidth,
                      child: Image.asset(
                        "assets/octahacks.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: 0.12*_deviceHeight,
                      width: 0.15*_deviceWidth,
                      child: Image.asset(
                        "assets/Multiply.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: 0.12*_deviceHeight,
                      width: 0.35*_deviceWidth,
                      child: Image.asset(
                        "assets/DSC.png",
                        fit: BoxFit.fill,
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
