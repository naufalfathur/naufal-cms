import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:naufal_cms/widgets/localdata.dart';
import 'package:naufal_cms/widgets/widgets.dart';

class Updatelead extends StatefulWidget {
  bool isEdit;
  String email;
  Updatelead({this.isEdit = false, this.email = ""});
  @override
  _UpdateleadState createState() =>
      _UpdateleadState(isEdit: isEdit, email: email);
}

class _UpdateleadState extends State<Updatelead> {
  bool isEdit;
  String email;
  _UpdateleadState({this.isEdit = false, this.email = ""});
  TextEditingController name = TextEditingController();
  TextEditingController emails = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postcode = TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<Leads> _leads = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (email != "") {
      _leads.add(leads[leads.indexWhere((element) => element.email == email)]);
      name.text = _leads[0].name;
      emails.text = _leads[0].email;
      phone.text = _leads[0].phone;
      selectedDate = _leads[0].dob;
      address.text = _leads[0].address;
      postcode.text = _leads[0].postcode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F9F9F9"),
      appBar: appbar(context,
          strTitle: isEdit ? "Edit Lead" : "Add Lead",
          disappearedBackButton: false),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            inputRow(Icons.supervised_user_circle, "full name", name, context,
                "textfield"),
            inputRow(Icons.email, "email", emails, context, "textfield"),
            inputRow(Icons.phone, "phone", phone, context, "textfield"),
            inputRow(Icons.date_range, "DoB", phone, context, "datetime",
                funciton: () => _selectDate(context),
                selectedDate: selectedDate),
            inputRow(
                Icons.location_city, "address", address, context, "textfield"),
            inputRow(
                Icons.location_pin, "postcode", postcode, context, "textfield"),
          ],
        ),
      ),
      bottomSheet: button("Save", () {
        if (isEdit) {
          leads[leads.indexWhere((element) => element.email == email)].name =
              name.text;
          leads[leads.indexWhere((element) => element.email == email)].email =
              emails.text;
          leads[leads.indexWhere((element) => element.email == email)].phone =
              phone.text;
          leads[leads.indexWhere((element) => element.email == email)].dob =
              selectedDate;
          leads[leads.indexWhere((element) => element.email == email)].address =
              address.text;
          leads[leads.indexWhere((element) => element.email == email)]
              .postcode = postcode.text;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Leads Updated')));
          Navigator.pop(context);
        } else {
          final addLead;
          addLead = Leads(name.text, emails.text, phone.text, selectedDate,
              address.text, postcode.text, DateTime.now(), "Potential");
          setState(() {
            leads.add(addLead);
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Leads Updated')));
          Navigator.pop(context);
        }
      }, Theme.of(context).accentColor, Colors.white),
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
}
