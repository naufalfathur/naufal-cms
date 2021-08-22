class User {
  User(this.email, this.name, this.isCalling);
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
  Status(this.statusId, this.name);
  String statusId;
  String name;
}

List<User> user = <User>[
  User("Jane Doe", "John", false),
];

List<Leads> leads = <Leads>[
  Leads("John Doe", "johndoe@gmail.com", "0123456789", DateTime.now(),
      "Bangsar, Kuala Lumpur", "525500", DateTime.now(), "Potential"),
  Leads("Alexander Pona", "lxnderpona@gmail.com", "012733226", DateTime.now(),
      "Bangsar, Kuala Lumpur", "525500", DateTime.now(), "Potential"),
  Leads("Bruce Man", "manbruce@gmail.com", "015673322", DateTime.now(),
      "Bangsar, Kuala Lumpur", "525500", DateTime.now(), "Potential"),
  Leads("Risa Joana", "risajoana@gmail.com", "0123112456", DateTime.now(),
      "Bangsar, Kuala Lumpur", "525500", DateTime.now(), "Potential"),
];

List<Calls> calls = <Calls>[
  Calls("242143425253", "johndoe@gmail.com", "Follow up Call", DateTime.now(),
      DateTime.now(), true, loremipsum),
  Calls("002012031214301", "johndoe@gmail.com", "Follow up call",
      DateTime.now(), DateTime.now(), false),
  Calls("00201203123131301", "johndoe@gmail.com", "First Call", DateTime.now(),
      DateTime.now(), true, loremipsum),
  Calls("54657475848343533", "lxnderpona@gmail.com", "First Call",
      DateTime.now(), DateTime.now(), true, loremipsum),
  Calls("96787697696946475", "manbruce@gmail.com", "Introduction Call",
      DateTime.now(), DateTime.now(), false),
  Calls("4634758696979696", "risajoana@gmail.com", "First Call", DateTime.now(),
      DateTime.now(), true, loremipsum),
];

String loremipsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tristique diam eu id neque, pellentesque nisl, nulla. Platea mauris consectetur volutpat vitae eget etiam pulvinar purus. Ut vitae nunc neque, sollicitudin scelerisque eu, aliquam. Varius enim proin cras semper. Turpis tempus morbi etiam facilisis gravida massa, quam.";
