import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:naufal_cms/widgets/widgets.dart';

class Updatelead extends StatefulWidget {
  @override
  _UpdateleadState createState() => _UpdateleadState();
}

class _UpdateleadState extends State<Updatelead> {
  bool isEdit = false;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postcode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F9F9F9"),
      appBar: appbar(context, strTitle: isEdit ? "Edit Lead" : "Add Lead"),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            inputRow(
                Icons.verified_user, "full name", name, context, "textfield"),
            inputRow(Icons.verified_user, "email", email, context, "textfield"),
            inputRow(Icons.verified_user, "phone", phone, context, "textfield"),
            inputRow(
                Icons.verified_user, "address", address, context, "textfield"),
            inputRow(Icons.verified_user, "postcode", postcode, context,
                "textfield"),
          ],
        ),
      ),
    );
  }
}
