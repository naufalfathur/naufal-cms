import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:naufal_cms/pages/updatelead.dart';
import 'package:naufal_cms/widgets/localdata.dart';
import 'package:naufal_cms/widgets/widgets.dart';
import 'dart:math' as math;

class Listpage extends StatefulWidget {
  @override
  _ListpageState createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F9F9F9"),
      appBar: appbar(context, strTitle: "Leads list"),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text("all",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
            divider(MediaQuery.of(context).size.width),
            leadsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Updatelead();
          }));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }

  leadsList() {
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
                  leading: Container(
                    decoration: BoxDecoration(
                        color: Color(
                                (math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5)),
                    width: 40,
                    height: 40,
                  ),
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
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
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
