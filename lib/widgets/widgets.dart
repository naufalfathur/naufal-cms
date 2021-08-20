import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

divider(double width) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
    height: 4,
    decoration: BoxDecoration(
        color: Colors.black, borderRadius: BorderRadius.circular(20)),
  );
}

PreferredSize appbar(context,
    {required String strTitle,
    disappearedBackButton = true,
    disableTabBar = true,
    dynamic row}) {
  return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: AppBar(
        automaticallyImplyLeading: false, // hides leading widget
        flexibleSpace: Container(
            padding: EdgeInsets.only(
              top: 40,
              left: 20,
              right: 10,
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: row == null
                      ? MediaQuery.of(context).size.width - 50
                      : MediaQuery.of(context).size.width / 2 - 20,
                  child: Text(
                    strTitle,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 28)),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
                row == null ? Text("") : row
              ],
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
}

circleButton(IconData icon, Color color, Function() function) {
  return Container(
    width: 40,
    height: 40,
    decoration:
        BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
    child: IconButton(
        icon: Icon(
          icon,
          size: 19,
        ),
        color: color,
        onPressed: function),
  );
}

iconButton(IconData iconData, Function() function, {bool shaddow = true}) {
  return GestureDetector(
    onTap: function,
    child: Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          shaddow
              ? BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 25,
                  spreadRadius: -8,
                )
              : BoxShadow(color: Colors.white),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(iconData, color: Colors.black),
    ),
  );
}
