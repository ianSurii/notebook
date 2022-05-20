import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notebook/home.dart';
import 'package:notebook/screens/addnote.dart';
import 'package:notebook/screens/viewnote.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI and use it on Windows and linux
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(
    MaterialApp(
      title: 'Notebook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    ),
  );
}
