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
  List<Calls> _calls = [];
  List<bool> _minimize = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _leads.add(leads[leads.indexWhere((element) => element.email == email)]);
    _calls = List.from(calls.where((element) => element.email == email));
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
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _calls.length,
                itemBuilder: (BuildContext context, int index) {
                  _minimize.add(true);
                  return callsWidget(
                      index,
                      _calls[index].title,
                      _calls[index].startDate,
                      _calls[index].isSuccess,
                      _calls[index].note == null ? "" : _calls[index].note);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  callsWidget(
      int index, String title, DateTime date, bool status, String note) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 0.0),
              blurRadius: 25,
              spreadRadius: -10,
            )
          ]),
      child: Column(
        children: [
          ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: circleButton(
                  Icons.phone, status ? Colors.green : Colors.red, () {}),
              title: Text(
                title,
                style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
              subtitle: Text(
                date.toString(),
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              trailing: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                spacing: 10.0,
                children: [
                  Offstage(
                    offstage: !status,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _minimize[index] = !_minimize[index];
                        });
                      },
                      child: Icon(
                        _minimize[index]
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  )
                ],
              )),
          Offstage(
            offstage: note == "" ? true : false,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                note,
                overflow: _minimize[index]
                    ? TextOverflow.ellipsis
                    : TextOverflow.visible,
                style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
