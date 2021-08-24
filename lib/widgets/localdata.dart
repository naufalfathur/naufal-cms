import 'package:intl/intl.dart';

class User {
  User(this.name, this.email, this.isCalling);
  String name;
  String email;
  bool isCalling;
}

class Leads {
  Leads(this.name, this.email, this.phone, this.dob, this.address,
      this.postcode, this.lastcall, this.status);
  String name;
  String email;
  String phone;
  DateTime dob;
  String address;
  String postcode;
  DateTime lastcall;
  String status;
}

class Calls {
  Calls(this.callId, this.email, this.title, this.startDate, this.endDate,
      this.isSuccess,
      [this.note]);
  String callId;
  String email;
  String title;
  DateTime startDate;
  DateTime endDate;
  bool isSuccess;
  dynamic note;
}

class Status {
  Status(this.name);
  String name;
}

List<User> user = <User>[
  User("Jane Doe", "janedoe@gmail.com", false),
];

List<Status> status = <Status>[
  Status("Potential"),
  Status("Interested"),
  Status("Uninterested"),
];

List<Leads> leads = <Leads>[
  Leads(
      "John Doe",
      "johndoe@gmail.com",
      "0123456789",
      DateTime.now(),
      "Bangsar, Kuala Lumpur",
      "525500",
      DateTime.parse("2021-07-21 12:30:41.169225"),
      "Potential"),
  Leads(
      "Alexander Pona",
      "lxnderpona@gmail.com",
      "012733226",
      DateTime.now(),
      "Bangsar, Kuala Lumpur",
      "525500",
      DateTime.parse("2021-08-17 16:50:41.169225"),
      "Potential"),
  Leads(
      "Bruce Man",
      "manbruce@gmail.com",
      "015673322",
      DateTime.now(),
      "Bangsar, Kuala Lumpur",
      "525500",
      DateTime.parse("2021-08-20 19:32:41.169225"),
      "Potential"),
  Leads(
      "Risa Joana",
      "risajoana@gmail.com",
      "0123112456",
      DateTime.now(),
      "Bangsar, Kuala Lumpur",
      "525500",
      DateTime.parse("2021-08-15 21:32:41.169225"),
      "Potential"),
  Leads(
      "Janis Hirthe",
      "Janishirthe@gmail.com",
      "04843498",
      DateTime.now(),
      "Petaling, Selangor",
      "12141",
      DateTime.parse("2021-08-21 21:32:41.169225"),
      "Interested"),
  Leads(
      "Erin Nitzsche",
      "Erinnitzsche@gmail.com",
      "01423422426",
      DateTime.now(),
      "Pulau Perhentian, Trengganu",
      "12314",
      DateTime.parse("2021-08-21 21:32:41.169225"),
      "Interested"),
  Leads(
      "Erik Mohr",
      "Erikmohr@gmail.com",
      "0123112456",
      DateTime.now(),
      "Port Dickson, Mellaca",
      "532525",
      DateTime.parse("2021-08-21 21:32:41.169225"),
      "Interested"),
  Leads(
      "Ashley Lindgren",
      "Ashleylindgren@gmail.com",
      "0123112456",
      DateTime.now(),
      "Johor, Johor Bahru",
      "65755",
      DateTime.parse("2021-08-21 21:32:41.169225"),
      "Interested"),
];

List<Calls> calls = <Calls>[
  Calls(
      "00201203123131301",
      "johndoe@gmail.com",
      "First Call",
      DateTime.parse("2021-08-19 14:32:41.169225"),
      DateTime.parse("2021-08-19 15:32:41.169225"),
      true,
      loremipsum),
  Calls(
      "002012031214301",
      "johndoe@gmail.com",
      "Follow up call",
      DateTime.parse("2021-08-20 15:32:41.169225"),
      DateTime.parse("2021-08-20 15:50:41.169225"),
      false),
  Calls(
      "242143425253",
      "johndoe@gmail.com",
      "Follow up Call",
      DateTime.parse("2021-07-21 12:30:41.169225"),
      DateTime.parse("2021-07-21 13:30:41.169225"),
      true,
      loremipsum),
  Calls(
      "54657475848343533",
      "lxnderpona@gmail.com",
      "First Call",
      DateTime.parse("2021-08-17 16:32:41.169225"),
      DateTime.parse("2021-08-17 16:50:41.169225"),
      true,
      loremipsum),
  Calls(
      "96787697696946475",
      "manbruce@gmail.com",
      "Introduction Call",
      DateTime.parse("2021-08-20 18:32:41.169225"),
      DateTime.parse("2021-08-20 19:32:41.169225"),
      false),
  Calls(
      "4634758696979696",
      "risajoana@gmail.com",
      "First Call",
      DateTime.parse("2021-08-15 20:32:41.169225"),
      DateTime.parse("2021-08-15 21:32:41.169225"),
      true,
      loremipsum),
  Calls(
      "4352525235252",
      "Janishirthe@gmail.com",
      "First Call",
      DateTime.parse("2021-08-21 10:32:41.169225"),
      DateTime.parse("2021-08-21 11:32:41.169225"),
      true,
      loremipsum),
  Calls(
      "2532523522131231",
      "Erinnitzsche@gmail.com",
      "First Call",
      DateTime.parse("2021-08-21 12:32:41.169225"),
      DateTime.parse("2021-08-21 13:32:41.169225"),
      true,
      loremipsum),
  Calls(
      "4634758696979696",
      "Erikmohr@gmail.com",
      "First Call",
      DateTime.parse("2021-08-21 14:32:41.169225"),
      DateTime.parse("2021-08-21 15:32:41.169225"),
      true,
      loremipsum),
  Calls(
      "4634758696979696",
      "Ashleylindgren@gmail.com",
      "First Call",
      DateTime.parse("2021-08-21 20:32:41.169225"),
      DateTime.parse("2021-08-21 21:32:41.169225"),
      true,
      loremipsum),
];

String loremipsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tristique diam eu id neque, pellentesque nisl, nulla. Platea mauris consectetur volutpat vitae eget etiam pulvinar purus. Ut vitae nunc neque, sollicitudin scelerisque eu, aliquam. Varius enim proin cras semper. Turpis tempus morbi etiam facilisis gravida massa, quam.";

var dayFormat = DateFormat('EEEE dd/MM');
var timeFormat = DateFormat('HH:mm');
var dateFormat = DateFormat('dd/MM/yyyy');
var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
