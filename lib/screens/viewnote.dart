import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notebook/database/core.dart';
import 'package:notebook/home.dart';
import 'package:notebook/models/note.dart';

import '../models/cart.dart';

class ViewNote extends StatefulWidget {
  Note note;

  ViewNote({Key? key, required this.note}) : super(key: key);

  @override
  State<ViewNote> createState() {
    return _ViewNoteState();
  }
}

class _ViewNoteState extends State<ViewNote> {
  List<Cart> _cart = [];
  Core core = new Core();
  Future<List<Cart>> getCart(int noteid) async {
    _cart = await core.getCart(noteid);

    return _cart;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      (widget.note.type == 1)
          ? getCart(widget.note.id!).then((value) {
              setState(() {
                _cart = value;
              });
            })
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade200,
          title: Text(
            'Notebook',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                core.deleteNote("notes", widget.note.id!);
                kDebugMode ? print("DELETING") : null;
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: ((context) => Home())));
              },
            ),
          ],
        ),
        body: Container(
          width: size.width,
          height: size.height,
          child: (widget.note.type == 0)
              ? SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: size.width,
                        height: size.height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.note.title!,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.pink.shade200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: size.width,
                        height: size.height * 0.1,
                        child: Text(
                          widget.note.content!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    )
                  ]),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height * 0.1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            //center the items
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.note.title!,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.pink.shade400,
                      ),
                      Container(
                        width: size.width,
                        height: size.height - 125,
                        constraints: BoxConstraints(minHeight: 300),
                        child: (_cart.isEmpty)
                            ? Container(
                                child: Center(
                                  child: Text("No Notes"),
                                ),
                              )
                            : ListView.builder(
                                itemCount: _cart.length,
                                itemBuilder: ((context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // if status ==1 then show strike through

                                        Text(
                                          _cart[index].item!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            overflow: TextOverflow.visible,

                                            //strike
                                            decoration: _cart[index].status == 1
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                          ),
                                        ),
                                        //show checkbox
                                        IconButton(
                                          onPressed: () {
                                            getCart(widget.note.id!)
                                                .then((value) {
                                              setState(() {
                                                _cart = value;
                                              });

                                              core.updateCart(
                                                "cartitem",
                                                _cart[index],
                                              );
                                              print("UPDATED");
                                            });
                                          },
                                          icon: Icon(
                                            _cart[index].status == 1
                                                ? Icons.check_box
                                                : Icons.check_box_outline_blank,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                      )
                    ],
                  ),
                ),
        ));
  }
}
