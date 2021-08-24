import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:naufal_cms/widgets/localdata.dart';
import 'package:naufal_cms/widgets/widgets.dart';

class Profilepage extends StatefulWidget {
  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, strTitle: "Profile"),
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          children: [
            profileBar(),
            SizedBox(
              height: 30,
            ),
            menu()
          ],
        ),
      ),
    );
  }

  profileBar() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black,
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              user[0].name,
              style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
            ),
            Text(
              user[0].email,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 12)),
            ),
          ],
        ),
      ],
    );
  }

  menu() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          menuOption(Icons.edit, "Update Profile", () {}),
          menuOption(Icons.update, "Add Leads Status", () {}),
          menuOption(Icons.logout, "Log Out", () async {}),
        ],
      ),
    );
  }

  menuOption(IconData iconData, String option, dynamic function) {
    return GestureDetector(
      onTap: function,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Icon(
          iconData,
          color: Colors.black54,
        ),
        title: Text(
          option,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 12)),
        ),
      ),
    );
  }
}
