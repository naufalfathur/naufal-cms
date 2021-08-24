import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:naufal_cms/pages/callpage.dart';
import 'package:naufal_cms/widgets/localdata.dart';
import 'package:naufal_cms/widgets/widgets.dart';

class Historypage extends StatefulWidget {
  @override
  _HistorypageState createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, strTitle: "History"),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            callHistory(),
          ],
        ),
      ),
    );
  }

  callHistory() {
    List<Leads> _leads = [];
    return Expanded(
      child: ListView.builder(
        itemCount: calls.length,
        itemBuilder: (BuildContext context, int index) {
          _leads.add(leads[leads
              .indexWhere((element) => element.email == calls[index].email)]);
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: circleButton(Icons.phone_in_talk,
                    calls[index].isSuccess ? Colors.green : Colors.red, () {}),
                title: Text(
                  _leads[index].name,
                  style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
                subtitle: Text(
                  dateFormat.format(calls[index].endDate),
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Callpage(
                                    email: _leads[index].email,
                                    pageIndex: 2,
                                    callDetail: calls[index],
                                    enableEdit: false,
                                  )));
                    },
                    child: Icon(Icons.chevron_right)),
              ),
            ),
          );
        },
      ),
    );
  }
}
