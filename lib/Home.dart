import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  String vocales = "aeiou";
  String consonantes = "bcdfghjklmnpqrstvwxyz";
  int longer = 8;
  String name = "Nickname";
  List<String> listName = ["A", "B", "C"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 64, 55, 110),
      appBar: AppBar(
        title: const Text("Menu"),
        actions: <Widget>[],
      ),
      body: Center(
          child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
              //!container for text
              decoration: BoxDecoration(
                  color: Color.fromARGB(200, 54, 85, 143),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(100, 0, 0, 0),
                      spreadRadius: 1,
                      blurRadius: 10,
                    )
                  ]),
              height: 50,
              width: 200,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
              alignment: Alignment.center,
              child: Text(
                name,
                style: TextStyle(
                  color: Color.fromARGB(255, 150, 172, 183),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )),
          SizedBox(
            //!button
            height: 50,
            width: 100,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.green),
                ),
                onPressed: () {
                  name = Generate(vocales, consonantes, longer);
                  print(name + "//" + name.length.toString());
                  setState(() {
                    name = name;
                    if (listName.length >= 3) {
                      listName.removeAt(0);
                    }
                    listName.add(name);
                  });
                },
                child: Text("Press")),
          ),
          Container(
            width: 100,
            height: 200,
          ),
          Container(
              height: 170,
              width: 300,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 54, 85, 143),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(100, 0, 0, 0),
                      spreadRadius: 1,
                      blurRadius: 10,
                    )
                  ]),
              child: ListView.builder(
                  reverse: true,
                  itemCount: listName.length,
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      title: Text('${listName[index]}'),
                      trailing: ElevatedButton(
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: listName[index]));
                        },
                        child: Icon(Icons.add),
                      ),
                    );
                  }))
        ],
      )),
    );
  }
}

String Generate(String vocales, String consonantes, int longitud) {
  String palabra = "";
  Random random = Random();
  int long = random.nextInt(longitud) + 3;

  for (int i = 0; i < long; i++) {
    if (i % 2 == 0) {
      int index = random.nextInt(consonantes.length);
      palabra += consonantes[index];
    } else {
      int index = random.nextInt(vocales.length);
      palabra += vocales[index];
    }
  }
  palabra = palabra[0].toUpperCase() + palabra.substring(1).toLowerCase();

  return palabra;
}
