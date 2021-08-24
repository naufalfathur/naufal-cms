import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math' as math;

divider(double width) {
  return Container(
    width: width,
    height: 4,
    decoration: BoxDecoration(
        color: Colors.black, borderRadius: BorderRadius.circular(20)),
  );
}

PreferredSize appbar(context,
    {required String strTitle,
    disappearedBackButton = true,
    whiteTitle = false,
    disableTabBar = true,
    dynamic row}) {
  return PreferredSize(
      preferredSize: Size.fromHeight(disappearedBackButton ? 100 : 120),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: disappearedBackButton
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    Offstage(
                      offstage: disappearedBackButton,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.chevron_left,
                          color:
                              whiteTitle ? Colors.white : HexColor("#C4C4C4"),
                          size: 40,
                        ),
                      ),
                    ),
                    Container(
                      width: row == null
                          ? MediaQuery.of(context).size.width - 50
                          : MediaQuery.of(context).size.width / 2 - 20,
                      child: Text(
                        strTitle,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: whiteTitle ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 28)),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                  ],
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

inputRow(IconData icon, String name, TextEditingController text,
    BuildContext context, String types,
    {dynamic funciton, dynamic selectedDate, bool isDisabled = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 15,
        children: [
          Icon(icon),
          Text(
            name,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 13.0,
                  color: Colors.black45,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      if (types == "textfield")
        Expanded(
          flex: 2,
          child: TextField(
            enabled: !isDisabled,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
            ),
            textAlign: TextAlign.end,
            controller: text,
            decoration: InputDecoration(
                hintText: name,
                hintStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black26),
                ),
                border: InputBorder.none),
          ),
        ),
      if (types == "datetime")
        GestureDetector(
          onTap: isDisabled ? () {} : funciton, // Refer step 3
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
    ],
  );
}

squareAvatar() {
  return Container(
    decoration: BoxDecoration(
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(0.4),
        borderRadius: BorderRadius.circular(5)),
    width: 40,
    height: 40,
  );
}

textField(String hint, TextEditingController text,
    {bool multiline = false,
    bool needFooter = false,
    IconData footerIcon = Icons.edit,
    bool isEnabled = true,
    bool isWhite = true}) {
  return Container(
    alignment: Alignment.topRight,
    decoration: needFooter
        ? BoxDecoration(
            border: Border(
            bottom: BorderSide(width: 2.0, color: Colors.black),
          ))
        : multiline
            ? BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black12),
                borderRadius: BorderRadius.circular(10))
            : BoxDecoration(),
    child: Row(
      children: [
        Flexible(
          child: TextField(
            textAlign: TextAlign.start,
            controller: text,
            enabled: isEnabled,
            style: TextStyle(
                fontWeight: multiline ? FontWeight.w400 : FontWeight.bold),
            keyboardType:
                multiline ? TextInputType.multiline : TextInputType.text,
            maxLines: multiline ? null : 1,
            minLines: multiline ? null : 1,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontWeight: FontWeight.normal),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: isWhite ? Colors.white : Colors.grey.withOpacity(0.2),
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
        Offstage(
          offstage: !needFooter,
          child: Container(
            alignment: Alignment.centerRight,
            child: Icon(footerIcon),
          ),
        )
      ],
    ),
  );
}

button(String text, dynamic function, Color bgColor, Color txtColor,
    {IconData? icon, double height = 60, bool rounded = false}) {
  return GestureDetector(
    onTap: function,
    child: Container(
      height: height,
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius:
              rounded ? BorderRadius.circular(5) : BorderRadius.circular(0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Offstage(
            offstage: icon == null,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                icon,
                color: txtColor,
              ),
            ),
          ),
          Text(
            text,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: txtColor, fontWeight: FontWeight.w800, fontSize: 13),
            ),
          ),
        ],
      ),
    ),
  );
}
