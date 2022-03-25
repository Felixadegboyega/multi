import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> addRecord(text, note) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> record = {
    "title": text,
    "note": note,
    "timeAdded": DateTime.now().toString(),
    "backedup": false,
    "email": ""
  };
  var jsonRecords = prefs.getString('records');
  if (jsonRecords != null) {
    List records = jsonDecode(jsonRecords) as List;
    records.add(record);
    prefs.setString('records', jsonEncode(records));
  } else {
    List records = [record];
    prefs.setString('records', jsonEncode(records));
  }
  return true;
}

Future<List> fetchRecord() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var jsonRecords = prefs.getString('records');
  if (jsonRecords != null) {
    var decodedRecords = jsonDecode(jsonRecords) as List;
    return decodedRecords;
  } else {
    return [];
  }
}

deleteRecord(List<int> toBeDeletedIndexArray) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var jsonRecords = prefs.getString('records');
  if (jsonRecords != null) {
    List records = jsonDecode(jsonRecords) as List;
    for (var i = 0; i < toBeDeletedIndexArray.length; i++) {
      records.removeAt(toBeDeletedIndexArray[i]);
    }
    prefs.setString('records', jsonEncode(records));
    return true;
  }
}
