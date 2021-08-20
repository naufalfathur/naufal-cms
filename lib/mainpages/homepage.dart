import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F9F9F9"),
      appBar: appbar(context, strTitle: "Hi Jane!"),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        color: Colors.white,
        //padding: EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text("potential",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
            divider(MediaQuery.of(context).size.width),
            potentialList(),
          ],
        ),
      ),
    );
  }

  potentialList() {
    return Expanded(
      child: ListView.builder(
        itemCount: leads.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: squareAvatar(),
                  title: Text(
                    leads[index].name,
                    style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ),
                  subtitle: Text(
                    leads[index].lastcall.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                  trailing: Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    runSpacing: 5.0,
                    children: [
                      circleButton(Icons.phone, Colors.green, () {}),
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
        },
      ),
    );
  }
}
