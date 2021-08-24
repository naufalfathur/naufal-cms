import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:naufal_cms/pages/callpage.dart';
import 'package:naufal_cms/pages/leadpage.dart';
import 'package:naufal_cms/pages/updatelead.dart';
import 'package:naufal_cms/widgets/localdata.dart';
import 'package:naufal_cms/widgets/widgets.dart';
import 'dart:math' as math;

class Listpage extends StatefulWidget {
  @override
  _ListpageState createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  String selectedCategory = "all";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F9F9F9"),
      appBar: appbar(context, strTitle: "Leads list"),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            category(),
            leadsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Updatelead();
          }));
          setState(() {});
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }

  category() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: status.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Wrap(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = "all";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: selectedCategory == "all"
                                ? Border(
                                    bottom: BorderSide(
                                        width: 4, color: Colors.black))
                                : Border()),
                        margin: EdgeInsets.all(10),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: Text("all",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: selectedCategory == "all"
                                        ? Colors.black
                                        : Colors.black26,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = status[index].name;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: selectedCategory == status[index].name
                                ? Border(
                                    bottom: BorderSide(
                                        width: 4, color: Colors.black))
                                : Border()),
                        margin: EdgeInsets.all(10),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: Text(status[index].name,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: selectedCategory == status[index].name
                                    ? Colors.black
                                    : Colors.black26,
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12))),
                      ),
                    )
                  ],
                );
              } else {
                return Wrap(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = status[index].name;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: selectedCategory == status[index].name
                                ? Border(
                                    bottom: BorderSide(
                                        width: 4, color: Colors.black))
                                : Border()),
                        margin: EdgeInsets.all(10),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: Text(status[index].name,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: selectedCategory == status[index].name
                                    ? Colors.black
                                    : Colors.black26,
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12))),
                      ),
                    ),
                  ],
                );
              }
            }));
  }

  leadsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: leads.length,
        itemBuilder: (BuildContext context, int index) {
          if (leads[index].status == selectedCategory ||
              selectedCategory == "all") {
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
