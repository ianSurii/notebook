import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:notebook/database/core.dart';
import 'package:notebook/services/addnote.dart';

import 'models/note.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Core core = new Core();
  List<Note> _notes = [];

  Future<List<Note>> getNotes() async {
    _notes = await core.getNotes();

    return _notes;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotes().then((value) {
      setState(() {
        _notes = value;
        print(_notes.length.toString() + "this is the length");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: Text('Notebook'),
      ),
      body: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DottedBorder(
                  color: Colors.black,
                  strokeWidth: 1,
                  child: Container(
                      width: size.width,
                      height: size.height * 0.1,
                      //decoration border that is dotted

                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    focusColor: Colors.green.shade300,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddNote()));
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      size: 30,
                                      color: Colors.orange,
                                    ),
                                  ),
                                )),
                          ])),
                ),
              ),
              Expanded(
                  child: Container(
                width: size.width,
                height: size.height * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: (_notes.isEmpty)
                    ? Container(
                        child: Center(
                          child: Text("No Notes"),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: ((context, index) {
                          return Container(
                              width: size.width,
                              height: size.height * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Container(
                                width: size.width,
                                height: size.height * 0.1,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text((_notes[index].title == 0)
                                              ? "note"
                                              : "shoppig cart"),
                                          //parse date the split the date only
                                          Text(
                                              "${_notes[index].date!.split(" ")[0]}"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("${_notes[index].title}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        }),
                        itemCount: 10),
              ))
            ],
          )),
    );
  }
}
