import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:naufal_cms/pages/callpage.dart';
import 'package:naufal_cms/pages/updatelead.dart';
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
  int pageIndex = 0;
  TextEditingController name = TextEditingController();
  TextEditingController emails = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postcode = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Status? _status;

  List<DropdownMenuItem<Status>> _dropdownMenuItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _status = status[leads.indexWhere((element) => element.email == email)];
    _leads.add(leads[leads.indexWhere((element) => element.email == email)]);
    _calls = List.from(calls.where((element) => element.email == email));
    name.text = _leads[0].name;
    emails.text = _leads[0].email;
    phone.text = _leads[0].phone;
    address.text = _leads[0].address;
    postcode.text = _leads[0].postcode;
    selectedDate = _leads[0].dob;
    _dropdownMenuItems = buildDropDownMenuItems(status);
  }

  List<DropdownMenuItem<Status>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<Status>> _categories = [];
    for (Status listItem in listItems) {
      _categories.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return _categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#1C8F96"),
      appBar: appbar(context,
          strTitle: _leads[0].name,
          whiteTitle: true,
          disappearedBackButton: false,
          row: homeOption()),
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
      bottomSheet: button("Phone Call", () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Callpage(
                    email: email,
                  )),
        );
      }, HexColor("#F6F6F6"), Theme.of(context).accentColor, icon: Icons.phone),
    );
  }

  overviewWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
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
            subtitle: GestureDetector(
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Update Status'),
                  content: Container(
                    child: DropdownButton<Status>(
                        value: _status,
                        items: _dropdownMenuItems,
                        onChanged: (value) {
                          setState(() {
                            _status = value!;
                            print(_status!.name);
                            leads[leads.indexWhere(
                                    (element) => element.email == email)]
                                .status = _status!.name;
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Status Updated')));
                          });
                        }),
                  ),
                ),
              ),
              child: Text("Update Status",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.w700,
                          fontSize: 12))),
            ),
          ),
          Text("-- Last call on " + dayFormat.format(_leads[0].lastcall),
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                      fontSize: 12))),
        ],
      ),
    );
  }

  leadDetails() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 40),
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
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
                                bottom:
                                    BorderSide(width: 4, color: Colors.black))
                            : Border()),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: Text("History",
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
                                bottom:
                                    BorderSide(width: 4, color: Colors.black))
                            : Border()),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: Text("Info",
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
            pageIndex == 0 ? historyLead() : infoLead()
          ],
        ),
      ),
    );
  }

  historyLead() {
    return Expanded(
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
    );
  }

  infoLead() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          inputRow(Icons.supervised_user_circle, "full name", name, context,
              "textfield",
              isDisabled: true),
          inputRow(Icons.email, "email", emails, context, "textfield",
              isDisabled: true),
          inputRow(Icons.phone, "phone", phone, context, "textfield",
              isDisabled: true),
          inputRow(Icons.date_range, "DoB", phone, context, "datetime",
              funciton: () => _selectDate(context),
              selectedDate: selectedDate,
              isDisabled: true),
          inputRow(
              Icons.location_city, "address", address, context, "textfield",
              isDisabled: true),
          inputRow(
              Icons.location_pin, "postcode", postcode, context, "textfield",
              isDisabled: true),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  callsWidget(
      int index, String title, DateTime date, bool status, String note) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                "Called on " + dayFormat.format(date),
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
                    onTap: () async {
                      final success = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Callpage(
                                    email: email,
                                    pageIndex: 2,
                                    callDetail: _calls[index],
                                  )));
                      if (success != null || success == "deleted") {
                        setState(() {
                          _calls = List.from(
                              calls.where((element) => element.email == email));
                        });
                        print(success);
                      }
                    },
                    child: Icon(
                      Icons.info_outline,
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

  Widget _simplePopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Edit Leads"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Delete Leads"),
          ),
        ],
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        onSelected: (value) async {
          if (value == 1) {
            final success = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Updatelead(
                        isEdit: true,
                        email: email,
                      )),
            );
            setState(() {});
          } else {
            leads.removeWhere((item) => item.email == email);
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Leads Deleted')));
          }
        },
      );

  Row homeOption() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          child: _simplePopup(),
        ),
      ],
    );
  }
}
