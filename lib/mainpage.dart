import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:naufal_cms/mainpages/homepage.dart';
import 'package:naufal_cms/mainpages/listpage.dart';
import 'package:naufal_cms/mainpages/profilepage.dart';

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  bool isSignedIn = false;
  PageController pageController = PageController(initialPage: 0);
  int getPageIndex = 0;

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
    return Scaffold(
      body: Container(
        child: homeScreen(),
      ),
    );
  }

  homeScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Homepage(),
          Listpage(),
          Profilepage(),
        ],
        controller: pageController,
        onPageChanged: whenPageChanges,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: DotNavigationBar(
        currentIndex: getPageIndex,
        onTap: onTapChangePage,
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
            icon: Icon(Icons.person),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
