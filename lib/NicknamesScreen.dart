import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class NicknamesScreen extends StatefulWidget {
  @override
  _NicknamesScreenState createState() => _NicknamesScreenState();
}

class _NicknamesScreenState extends State<NicknamesScreen> {
  List<String> nicknames = [];

  Future<void> deleteData(String nickname) async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'nicknameDB.db'),
      version: 1,
    );
    await db.delete(
      'nickname',
      where: "nick = ?",
      whereArgs: [nickname],
    );
    setState(() {}); // actualiza el estado del widget
    await loadNicknames(); // actualiza la lista de nicknames
  }

  Future<void> loadNicknames() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'nicknameDB.db'),
      version: 1,
    );
    final List<Map<String, dynamic>> maps = await db.query('nickname');
    nicknames = List.generate(maps.length, (i) => maps[i]['nick']);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadNicknames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nicknames'),
      ),
      body: ListView.builder(
        itemCount: nicknames.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Text(nicknames[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: nicknames[index]));
                        final snackBar = SnackBar(
                          content: Text('You copied:' + nicknames[index]),
                          duration: Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: Icon(Icons.copy)),
                  IconButton(
                      onPressed: () async {
                        await deleteData(nicknames[index]);
                      },
                      icon: Icon(Icons.delete))
                ],
              ));
        },
      ),
    );
  }
}
