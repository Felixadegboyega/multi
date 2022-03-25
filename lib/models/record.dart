class Record {
  String title;
  String timeAdded;
  String note;
  bool backedup = false;
  String email = "";

  Record({required this.title, required this.timeAdded, required this.note});

  factory Record.fromJSON(Map<String, dynamic> json) {
    return Record(
        title: json['title'], timeAdded: json['timeAdded'], note: json['note']);
  }
}
