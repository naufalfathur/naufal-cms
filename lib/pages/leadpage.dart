import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:naufal_cms/widgets/localdata.dart';
import 'package:naufal_cms/widgets/widgets.dart';

class Leadpage extends StatefulWidget {
  String email;
  Leadpage({required this.email});
  @override
  _LeadpageState createState() => _LeadpageState(email: email);
}

class _LeadpageState extends State<Leadpage> {
  String email;
  _LeadpageState({required this.email});

  List<Leads> _leads = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _leads.add(leads[leads.indexWhere((element) => element.email == email)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#1C8F96"),
      appBar: appbar(context, strTitle: _leads[0].name, whiteTitle: true),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            overviewWidget(),
            leadDetails(),
          ],
        ),
      ),
    );
  }

  overviewWidget() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: squareAvatar(),
            title: Text("Status - " + _leads[0].status,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12))),
            subtitle: Text("Update Status",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w700,
                        fontSize: 10))),
          ),
          Text("Last call on " + _leads[0].lastcall.toString(),
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12))),
        ],
      ),
    );
  }

  leadDetails() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text("Details",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
          ],
        ),
      ),
    );
  }
}
