import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:naufal_cms/pages/callpage.dart';
import 'package:naufal_cms/pages/leadpage.dart';
import 'package:naufal_cms/pages/updatelead.dart';
import 'package:naufal_cms/widgets/localdata.dart';
import 'package:naufal_cms/widgets/widgets.dart';
import 'dart:math' as math;

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#F9F9F9"),
        //appBar: appbar(context, strTitle: "Hi Jane!"),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 300,
                floating: false,
                elevation: 0,
                collapsedHeight: 100,
                backgroundColor: HexColor("#F9F9F9"),
                automaticallyImplyLeading: false,
                pinned: true,
                snap: false,
                flexibleSpace: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 60,
                          left: 20,
                          right: 10,
                        ),
                        child: Wrap(
                          direction: Axis.vertical,
                          runSpacing: 30,
                          children: [
                            Text(
                              "Hi " + user[0].name + " !",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 28)),
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 110,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Quick access",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            quickAccess(),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 15,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.3),
                              offset: Offset(0, -20),
                              blurRadius: 65,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: Container(
            color: Colors.white,
            //padding: EdgeInsets.all(30),
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(20),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor("#495D6E")),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      dashboardWidget("Leads Called", calls.length),
                      dashboardWidget(
                          "Failed Call",
                          calls
                              .indexWhere(
                                  (element) => element.isSuccess == false)
                              .bitLength),
                      dashboardWidget(
                          "Interested",
                          leads
                              .indexWhere(
                                  (element) => element.status == "Interested")
                              .bitLength),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageIndex = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: pageIndex == 0
                                ? Border(
                                    bottom: BorderSide(
                                        width: 4, color: Colors.black))
                                : Border()),
                        margin: EdgeInsets.all(10),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: Text("Potential",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: pageIndex == 0
                                        ? Colors.black
                                        : Colors.black26,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageIndex = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: pageIndex == 1
                                ? Border(
                                    bottom: BorderSide(
                                        width: 4, color: Colors.black))
                                : Border()),
                        margin: EdgeInsets.all(10),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: Text("Interested",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: pageIndex == 1
                                        ? Colors.black
                                        : Colors.black26,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12))),
                      ),
                    ),
                  ],
                ),
                leadList(pageIndex == 0 ? "Potential" : "Interested"),
              ],
            ),
          ),
        ));
  }

  dashboardWidget(String title, int amount) {
    return Column(
      children: [
        Text(amount.toString(),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 30))),
        Text(title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 10))),
      ],
    );
  }

  quickAccess() {
    List<Leads> _leads = [];
    List<Calls> _calls = List.from(calls);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 140,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: _calls.length,
          itemBuilder: (BuildContext context, int index) {
            _leads.add(leads[leads.indexWhere(
                (element) => element.email == _calls[index].email)]);
            return Container(
              margin: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width - 80,
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: squareAvatar(),
                    title: Text(
                      _leads[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    subtitle: Text(
                      _leads[index].status,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: HexColor("#E0E0E0"),
                            fontSize: 11,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Last call on " +
                            dayFormat.format(leads[index].lastcall),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: HexColor("#E0E0E0"),
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      circleButton(Icons.phone, Colors.white, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Callpage(
                                    email: leads[index].email,
                                  )),
                        );
                      }),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }

  leadList(String category) {
    return Expanded(
      child: ListView.builder(
        itemCount: leads.length,
        itemBuilder: (BuildContext context, int index) {
          if (leads[index].status == category) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: squareAvatar(),
                    title: Text(
                      leads[index].name,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                    subtitle: Text(
                      "Last call on " + dayFormat.format(leads[index].lastcall),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ),
                    trailing: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.center,
                      runSpacing: 5.0,
                      children: [
                        circleButton(Icons.phone, Colors.green, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Callpage(
                                      email: leads[index].email,
                                    )),
                          );
                        }),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Leadpage(email: leads[index].email);
                            }));
                          },
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.black,
                          ),
                        )
                      ],
                    )),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
