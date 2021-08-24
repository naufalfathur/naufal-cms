import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:naufal_cms/mainpages/profilepage.dart';
import 'package:naufal_cms/widgets/localdata.dart';
//import 'package:naufal_cms/widgets/notificationservice.dart';
import 'package:naufal_cms/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Callpage extends StatefulWidget {
  String email;
  int pageIndex;
  dynamic callDetail;
  bool enableEdit;
  Callpage(
      {required this.email,
      this.pageIndex = 0,
      this.callDetail,
      this.enableEdit = true});
  @override
  _CallpageState createState() => _CallpageState(
      email: email,
      pageIndex: pageIndex,
      callDetail: callDetail,
      enableEdit: enableEdit);
}

class _CallpageState extends State<Callpage> {
  String email;
  int pageIndex = 0;
  dynamic callDetail;
  bool enableEdit;
  _CallpageState(
      {required this.email,
      this.pageIndex = 0,
      this.callDetail,
      this.enableEdit = true});

  List<Leads> _leads = [];
  List<Calls> _calls = [];
  TextEditingController _title = TextEditingController();
  TextEditingController _notes = TextEditingController();
  bool isCalling = false;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(DateTime.now());
    if (callDetail != null) {
      _calls.add(callDetail);
      _title.text = callDetail.title == null ? "" : callDetail.title;
      _notes.text = !callDetail.isSuccess
          ? "Call Failed"
          : callDetail.note == null
              ? ""
              : callDetail.note;
    }

    _leads.add(leads[leads.indexWhere((element) => element.email == email)]);
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  final stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
  }

  Future _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    String trendingNewsId = '5';
    await flutterLocalNotificationsPlugin.show(
        0,
        'Naufal CMS - already calling ?',
        'tap to open notes',
        platformChannelSpecifics,
        payload: trendingNewsId);
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
                  detailList(Icons.phone, _leads[0].phone),
                  detailList(Icons.calendar_today, _leads[0].dob.toString()),
                  detailList(Icons.location_pin, _leads[0].address),
                  detailList(Icons.location_pin, _leads[0].postcode),
                ],
              ),
            ),
            greenWidget(
              Icons.phone,
              "Start Call",
              _leads[0].phone,
              () {
                setState(() {
                  UrlLauncher.launch('tel:+${_leads[0].phone}');
                  isCalling = true;
                  pageIndex = 1;
                  _start = DateTime.now();
                  _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                  _showNotification();
                });
              },
            ),
            circleButton(Icons.close, Colors.red, () {
              Navigator.pop(context);
            }),
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
      appBar: appbar(context, strTitle: "Call Note", row: noteRow()),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(bottom: 80),
        child: Column(
          children: [
            greenWidget(
              Icons.supervised_user_circle,
              _leads[0].name,
              "Tap to see profile",
              () {},
              col: callDetail == null
                  ? Column(
                      children: [
                        Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        StreamBuilder<int>(
                          stream: _stopWatchTimer.rawTime,
                          initialData: 0,
                          builder: (context, snap) {
                            final value = snap.data;
                            final displayTime =
                                StopWatchTimer.getDisplayTime(value!);
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Calling..",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  displayTime,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            );
                          },
                        ),
                        Divider(),
                      ],
                    )
                  : Column(),
            ),
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
      bottomSheet: button(isCalling ? "Stop Timer" : "Save", () {
        if (isCalling) {
          _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
          setState(() {
            _end = DateTime.now();
            isCalling = false;
          });
        } else {
          if (callDetail == null) {
            setState(() {
              _calls.add(Calls(DateTime.now().toString(), _leads[0].email,
                  _title.text, _start, _end, true, _notes.text));
              calls.add(Calls(DateTime.now().toString(), _leads[0].email,
                  _title.text, _start, _end, true, _notes.text));
              leads[leads.indexWhere((element) => element.email == email)]
                  .lastcall = _end;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Calls Recorded')));
              pageIndex = 2;
            });
          } else {
            setState(() {
              _calls[_calls.indexWhere(
                      (element) => element.callId == callDetail.callId)]
                  .title = _title.text;
              _calls[_calls.indexWhere(
                      (element) => element.callId == callDetail.callId)]
                  .note = _notes.text;
              calls[calls.indexWhere(
                      (element) => element.callId == callDetail.callId)]
                  .title = _title.text;
              calls[calls.indexWhere(
                      (element) => element.callId == callDetail.callId)]
                  .note = _notes.text;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Calls Recorded')));
              pageIndex = 2;
            });
          }
        }
      }, isCalling ? Colors.redAccent : Theme.of(context).accentColor,
          Colors.white),
    );
  }

  conclussionScreen() {
    return Scaffold(
        appBar: appbar(context, strTitle: "Call Details", row: close()),
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
                      callList("date", dateFormat.format(_calls[0].startDate)),
                      callList("start", timeFormat.format(_calls[0].startDate)),
                      callList("end", timeFormat.format(_calls[0].endDate)),
                      callList(
                          "duration",
                          _calls[0]
                                  .startDate
                                  .difference(_calls[0].endDate)
                                  .inMinutes
                                  .toString() +
                              "Minutes"),
                      callList(
                          "status", _calls[0].isSuccess ? "Success" : "Failed"),
                      Divider(
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 25,
                        spreadRadius: -10,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    textField("No Title", _title, isEnabled: false),
                    textField("No Notes", _notes,
                        multiline: true, isEnabled: false)
                  ],
                ),
              )
            ],
          ),
        ),
        bottomSheet: Offstage(
          offstage: !enableEdit,
          child: button("Edit", () {
            setState(() {
              pageIndex = 1;
            });
          }, Theme.of(context).accentColor, Colors.white),
        ));
  }

  Row noteRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (callDetail == null) {
              _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
              _end = DateTime.now();
              _calls.add(Calls(DateTime.now().toString(), _leads[0].email,
                  _title.text, _start, _end, false, _notes.text));
              pageIndex = 2;
            } else {
              calls.removeWhere((item) => item.callId == callDetail.callId);
              Navigator.pop(context, "deleted");
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Call Logs Deleted')));
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.red),
            width: 100,
            height: 40,
            child: Text(
              callDetail == null ? "Call Failed" : "Delete Logs",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Row close() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: iconButton(Icons.close, () {
            Navigator.pop(context);
          }),
        )
      ],
    );
  }
}
