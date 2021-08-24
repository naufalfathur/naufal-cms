import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboardpage extends StatefulWidget {
  @override
  _OnboardpageState createState() => _OnboardpageState();
}

class _OnboardpageState extends State<Onboardpage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image(
          image: AssetImage(onboardData[pageIndex].url),
          fit: BoxFit.contain,
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), topLeft: Radius.circular(25)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text("Connect with your leads\nbetter, faster, Wherever",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 17))),
                SizedBox(
                  height: 15,
                ),
                Text(onboardData[pageIndex].subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                            fontSize: 14))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (pageIndex == 0) {
                      setState(() {
                        pageIndex = 2;
                      });
                    } else {
                      setState(() {
                        pageIndex--;
                      });
                    }
                  },
                  child: Text(pageIndex == 0 ? "Skip" : "Prev",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.w800,
                              fontSize: 15))),
                ),
                GestureDetector(
                  onTap: () {
                    if (pageIndex != 2) {
                      setState(() {
                        pageIndex++;
                      });
                    } else {
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text(pageIndex == 2 ? "Start" : "Next",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 15))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OnboardData {
  OnboardData(this.url, this.subtitle);
  String url;
  String subtitle;
}

List<OnboardData> onboardData = <OnboardData>[
  OnboardData("assets/images/onboard1.png",
      "With QuickDesk CRM you can access your leads details everywhere"),
  OnboardData("assets/images/onboard2.png",
      "Make a call and take note with handy in app note taking features!"),
  OnboardData("assets/images/onboard3.png",
      "Better leads organizer with status update features inside the app"),
];
