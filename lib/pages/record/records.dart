import 'package:flutter/material.dart';
import 'package:multi/Functions/record.dart';
import 'package:multi/constants.dart';
import 'package:multi/models/record.dart';

class Records extends StatefulWidget {
  const Records({Key? key}) : super(key: key);

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: FutureBuilder(
            future: fetchRecord(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data as List;
                List<Record> records =
                    data.map((e) => Record.fromJSON(e)).toList();
                if (records.isNotEmpty) {
                  return ListView.builder(
                      itemCount: records.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildRecordTile(index, records, data);
                      });
                } else {
                  return emptyRecordWidget();
                }
              } else {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.blueGrey));
              }
            }),
      ),
    );
  }

  Widget buildRecordTile(int index, List<Record> decodedRecords, List records) {
    return Container(
      decoration: tabTileDecoration.copyWith(color: Colors.white),
      margin: const EdgeInsets.only(bottom: 5),
      child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    deleteRecord([index]);
                  });
                },
                splashRadius: 20,
                icon:
                    Icon(Icons.delete_outline_rounded, color: Colors.red[800])),
          ]),
          title: Text(decodedRecords[index].title),
          subtitle: Text(decodedRecords[index].note)),
    );
  }

  Center emptyRecordWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.my_library_books_outlined,
            color: Colors.blueGrey,
            size: 80,
          ),
          Text('Empty, you will see your added records here.')
        ],
      ),
    );
  }
}
