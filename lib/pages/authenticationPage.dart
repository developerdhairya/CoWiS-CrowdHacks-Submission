import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ieee_chitkara/providers/firebase_auth_service.dart';
import 'package:particles_flutter/particles_flutter.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            CircularParticle(
              key: UniqueKey(),
              awayRadius: 0.0,
              numberOfParticles: 100,
              speedOfParticles: 1,
              height: _deviceHeight,
              width: _deviceWidth,
              onTapAnimation: false,
              particleColor: Theme.of(context).cardColor.withOpacity(0.1),
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
                SizedBox(
                  height: 0.23 * _deviceHeight,
                ),
                SizedBox(
                  height: 0.05 * _deviceHeight,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: Image.asset(
                        "assets/IEEE.png",
                        fit: BoxFit.cover,
                      ),
                      width: 0.25 * _deviceWidth,
                    ),
                    SizedBox(
                      child: Image.asset(
                        "assets/WIE.png",
                        fit: BoxFit.cover,
                      ),
                      width: 0.25 * _deviceWidth,
                    ),
                  ],
                ),
                SizedBox(
                  height: _deviceHeight * 0.15,
                ),
                Card(
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
                Text("For Membership Benifits,"),
                Text(" Log In with IEEE email-id only"),
                SizedBox(
                  height: _deviceHeight * 0.15,
                ),
                SizedBox(
                  child: Image.asset(
                    "assets/chitkara-university-logo.png",
                    fit: BoxFit.cover,
                  ),
                  width: 0.60 * _deviceWidth,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}