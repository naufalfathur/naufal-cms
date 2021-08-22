import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:naufal_cms/widgets/localdata.dart';
import 'package:naufal_cms/widgets/widgets.dart';

class Callpage extends StatefulWidget {
  String email;
  int pageIndex;
  dynamic callDetail;
  Callpage({required this.email, this.pageIndex = 0, this.callDetail});
  @override
  _CallpageState createState() => _CallpageState(
      email: email, pageIndex: pageIndex, callDetail: callDetail);
}

class _CallpageState extends State<Callpage> {
  String email;
  int pageIndex = 0;
  dynamic callDetail;
  _CallpageState({required this.email, this.pageIndex = 0, this.callDetail});

  List<Leads> _leads = [];
  List<Calls> _calls = [];
  TextEditingController _title = TextEditingController();
  TextEditingController _notes = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (callDetail != null) {
      _calls = callDetail;
    }
    _leads.add(leads[leads.indexWhere((element) => element.email == email)]);
  }

  @override
  Widget build(BuildContext context) {
    if (pageIndex == 0) {
      return onboard();
    } else if (pageIndex == 1) {
      return noteScreen();
    } else {
      return conclussionScreen();
    }
  }

  onboard() {
    return Scaffold(
      backgroundColor: HexColor("#F3F3F3"),
      body: Container(
        padding: EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 20,
          children: [
            Text(
              "Call Confirmation",
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              height: 400,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 25,
                  spreadRadius: -10,
                )
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    _leads[0].name,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ),
                  detailList(Icons.mail, _leads[0].email),
                  detailList(Icons.phone, _leads[0].phone.toString()),
                  detailList(Icons.calendar_today, _leads[0].dob.toString()),
                  detailList(Icons.location_pin, _leads[0].address),
                  detailList(Icons.location_pin, _leads[0].postcode),
                ],
              ),
            ),
            greenWidget(
              Icons.phone,
              "Start Call",
              _leads[0].phone.toString(),
              () {
                setState(() {
                  pageIndex = 1;
                });
              },
            ),
            circleButton(Icons.close, Colors.red, () {}),
          ],
        ),
      ),
    );
  }

  greenWidget(IconData icon, String title, String subtitle, Function() function,
      {dynamic col}) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 0.0),
            blurRadius: 25,
            spreadRadius: -10,
          )
        ], color: HexColor("#1C8F96"), borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            ListTile(
              onTap: function,
              leading: circleButton(icon, Colors.white, () {}),
              title: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ),
              subtitle: Text(
                subtitle,
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
            Offstage(
                offstage: col == null,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: col,
                ))
          ],
        ));
  }

  detailList(IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  callList(String title, String field) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          field,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  noteScreen() {
    return Scaffold(
      appBar: appbar(context, strTitle: "Call Note"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(bottom: 80),
        child: Column(
          children: [
            greenWidget(Icons.supervised_user_circle, _leads[0].name,
                "Tap to see profile", () {}),
            SizedBox(
              height: 10,
            ),
            textField("Tap to edit title", _title, needFooter: true),
            Divider(
              color: Colors.white,
            ),
            Expanded(
                child: textField(
              "Lorem ipsum ...",
              _notes,
              multiline: true,
            ))
          ],
        ),
      ),
      bottomSheet: button("Save", () {
        setState(() {
          _calls.add(Calls(DateTime.now().toString(), _leads[0].email,
              _title.text, DateTime.now(), DateTime.now(), true, _notes.text));
          pageIndex = 2;
        });
      }, Theme.of(context).accentColor, Colors.white),
    );
  }

  conclussionScreen() {
    return Scaffold(
      appBar: appbar(context, strTitle: "Call Details"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(bottom: 80),
        child: ListView(
          children: [
            greenWidget(Icons.supervised_user_circle, _leads[0].name,
                "Tap to see profile", () {},
                col: Wrap(
                  runSpacing: 5,
                  children: [
                    Divider(
                      color: Colors.white,
                    ),
                    Text(
                      "Call Details",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    callList("date", _calls[0].startDate.toString()),
                    callList("start", _calls[0].startDate.toString()),
                    callList("end", _calls[0].startDate.toString()),
                    callList("duration", "1" + "Minutes"),
                    callList("status", _calls[0].isSuccess.toString()),
                    Divider(
                      color: Theme.of(context).accentColor,
                    ),
                  ],
                )),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 25,
                  spreadRadius: -10,
                )
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  textField("Tap to edit title", _title, isEnabled: false),
                  textField("Lorem ipsum ...", _notes,
                      multiline: true, isEnabled: false)
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: button("Edit", () {
        setState(() {
          pageIndex = 1;
        });
      }, Theme.of(context).accentColor, Colors.white),
    );
  }

  Row callFailed() {
    return Row();
  }
}
