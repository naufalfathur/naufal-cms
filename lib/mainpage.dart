import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naufal_cms/mainpages/historypage.dart';
import 'package:naufal_cms/mainpages/homepage.dart';
import 'package:naufal_cms/mainpages/listpage.dart';
import 'package:naufal_cms/mainpages/profilepage.dart';
import 'package:naufal_cms/onboardpage.dart';
import 'package:naufal_cms/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  bool isSignedIn = false;
  PageController pageController = PageController(initialPage: 0);
  int getPageIndex = 0;
  TextEditingController uname = TextEditingController();
  TextEditingController pwd = TextEditingController();

  onTapChangePage(int pageIndex) {
    pageController.jumpToPage(pageIndex);
  }

  whenPageChanges(int pageIndex) {
    setState(() {
      this.getPageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return homeScreen();
    } else {
      return loginScreen();
    }
  }

  homeScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Homepage(),
          Listpage(),
          Historypage(),
          Profilepage(),
        ],
        controller: pageController,
        onPageChanged: whenPageChanges,
        physics: NeverScrollableScrollPhysics(),
      ),
      extendBody: false,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 0),
            blurRadius: 25,
            spreadRadius: -5,
          )
        ]),
        child: DotNavigationBar(
          currentIndex: getPageIndex,
          margin: EdgeInsets.symmetric(horizontal: 40),
          onTap: onTapChangePage,
          enableFloatingNavBar: false,
          // dotIndicatorColor: Colors.black,
          items: [
            DotNavigationBarItem(
              icon: Icon(Icons.home),
              selectedColor: Colors.purple,
            ),
            DotNavigationBarItem(
              icon: Icon(Icons.list),
              selectedColor: Colors.pink,
            ),
            DotNavigationBarItem(
              icon: Icon(Icons.history),
              selectedColor: Colors.pink,
            ),
            DotNavigationBarItem(
              icon: Icon(Icons.person),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }

  loginScreen() {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  child: Image(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Text("Connect with your leads\nbetter, faster, Wherever",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18))),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 150,
                  child: Image(
                    image: AssetImage("assets/images/landing.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Text("Lets get started",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15))),
                textField("Username", uname, isWhite: false),
                textField("Password", uname, isWhite: false),
                button("Sign In", () {
                  setState(() {
                    isSignedIn = true;
                  });
                }, Colors.black, Colors.white, rounded: true, height: 50),
                Divider(
                  color: Colors.black38,
                  thickness: 1,
                ),
                button("Continue with Google", () async {
                  final success = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return Onboardpage();
                  }));
                  if (success != null && success == true) {
                    setState(() {
                      isSignedIn = true;
                    });
                  }
                }, Theme.of(context).accentColor, Colors.white,
                    icon: FontAwesomeIcons.google, rounded: true, height: 50),
                Text(
                    "Account will be created automatically if you're not registered",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 10))),
              ],
            ),
          ),
        ));
  }
}
