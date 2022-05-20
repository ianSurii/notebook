import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notebook/models/cart.dart';

import '../database/core.dart';
import '../home.dart';
import '../models/note.dart';

class AddNote extends StatefulWidget {
  AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  Core core = new Core();
  int? type = 1;
  int? cartID;
  List list = [];
  String content2 = "";
  String stringType = "Note";
  TextEditingController title2 = new TextEditingController();

  TextEditingController content = new TextEditingController();
  TextEditingController title = new TextEditingController();
  DateTime dateTime = new DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade200,
          title: Text('Add Note'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          actions: [
            //dropdown button to select type of note
            Padding(
              padding: const EdgeInsets.only(right: 38.0),
              child: DropdownButton<String>(
                value: stringType,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    // type = value;

                    if (value == "Note") {
                      type = 0;
                      stringType = "Note";
                    } else {
                      stringType = "Cart";
                      type = 1;
                    }
                  });
                },
                items: <String>["Cart", "Note"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        body: Container(
          width: size.width,
          height: size.height,
          child: (type == 0)
              ? SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: title,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Title',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height * 0.71,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: content,
                          minLines: 1,
                          maxLines: 100,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Note',
                          ),
                        ),
                      ),
                    ),
                    //Container for setting the Type of Note,
                    Container(
                      width: size.width,
                      height: 70,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(size.width, 70),
                                  primary: Colors.pink.shade300),
                              onPressed: () {
                                setState(() {
                                  // type = 0;
                                  int random = Random().nextInt(4294967296);
                                  Note note = new Note(
                                      id: random,
                                      title: title.text,
                                      content: content.text,
                                      date: dateTime.toString(),
                                      type: 0);
                                  core.insertNote("notes", note);
                                  //clear all the field
                                  title.clear();
                                  content.clear();

                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Home()));
                                });
                              },
                              child: Text('Add Note'),
                            ),
                          ]),
                    )
                  ]),
                )
              : SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: size.width,
                        height: size.height * 0.1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: title2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'List Name',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black12,
                      width: size.width,
                      height: size.height * 0.72,
                      // constraints: BoxConstraints(
                      //   // maxHeight: size.height * 0.7,
                      //   minHeight: size.height * 0.1,
                      // ),
                      child: ListView.builder(
                          itemCount: list.length + 1,
                          itemBuilder: (context, index) {
                            if (index == list.length) {
                              return Container(
                                width: size.width - 16,
                                height: size.height * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 1),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width - 60,
                                      height: size.height * 0.1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: content,
                                          minLines: 1,
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Item',
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          //append to the list
                                          setState(() {
                                            if (content.text.isNotEmpty) {
                                              list.add(content.text);
                                              content.clear();
                                            }
                                          });
                                        },
                                        icon: Icon(Icons.add))
                                  ],
                                ),
                              );
                            }

                            return (list.isEmpty)
                                ? SizedBox()
                                : Container(
                                    width: size.width,
                                    height: size.height * 0.1,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border(
                                      //   bottom: BorderSide(
                                      //     color: Colors.black,
                                      //     width: 1,
                                      //   ),
                                      // ),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 1),
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // width: size.width / 2,
                                            // height: size.height * 0.1,
                                            child: Center(
                                                child: Text(list[index])),
                                          ),
                                          Container(
                                            // width: size.width / 2,
                                            // height: size.height * 0.1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      list.removeAt(index);
                                                    });
                                                  },
                                                  icon: Icon(Icons.delete,
                                                      color: Colors.redAccent)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                          }),
                    ),

                    Container(
                      width: size.width,
                      height: 70,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(size.width, 70),
                                  primary: Colors.pink.shade300),
                              onPressed: () {
                                //  check  if the fields are empty or the list is empty
                                if (title2.text.isEmpty || list.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text(
                                            "Please fill all the fields and add items to the list"),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  int id = Random().nextInt(4294967296);
                                  Note note = new Note(
                                      id: id,
                                      title: title2.text,
                                      content: "cart list",
                                      date: dateTime.toString(),
                                      type: 1);

                                  core.insertNote("notes", note);
                                  for (int i = 0; i < list.length; i++) {
                                    int idItem = Random().nextInt(4294967296);
                                    Cart cart = new Cart(
                                        id: idItem,
                                        noteid: id,
                                        item: list[i],
                                        status: 0);

                                    core.insertCart("cartitem", cart);
                                    list.removeAt(i);
                                  }
                                  //clear all the fields,
                                  title2.clear();
                                  content.clear();

                                  setState(() {
                                    list.clear();
                                  });
                                }
                              },
                              child: Text('Add Note'),
                            ),
                          ]),
                    )
                    // Container(
                    //   width: size.width,
                    //   height: size.height * 0.1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       children: [
                    //         TextField(
                    //           decoration: InputDecoration(
                    //             border: OutlineInputBorder(),
                    //             labelText: 'Item',
                    //           ),
                    //         ),
                    //         IconButton(
                    //           icon: Icon(Icons.add),
                    //           onPressed: () {
                    //             setState(() {
                    //               list.add(TextField(
                    //                 decoration: InputDecoration(
                    //                   border: OutlineInputBorder(),
                    //                   labelText: 'Item',
                    //                 ),
                    //               ));
                    //             });
                    //           },
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ]),
                ),
        ));
  }
}
