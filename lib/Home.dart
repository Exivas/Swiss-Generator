import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  String vocales = "aeiou";
  String consonantes = "bcdfghjklmnpqrstvwxyz";
  int long = 5;
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        actions: <Widget>[],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name),
            ElevatedButton(
                onPressed: () {
                  name = Generate(vocales, consonantes, long);
                  print(name + "//" + name.length.toString());

                  setState(() {
                    name = name;
                  });
                },
                child: Text("hello"))
          ],
        ),
      ),
    );
  }
}

String Generate(String vocales, String consonantes, int longitud) {
  String palabra = "";
  Random random = Random();
  int long = random.nextInt(3) + longitud - 2;

  for (int i = 0; i < long; i++) {
    if (i % 2 == 0) {
      // agregar consonante
      int index = random.nextInt(consonantes.length);
      palabra += consonantes[index];
    } else {
      // agregar vocal
      int index = random.nextInt(vocales.length);
      palabra += vocales[index];
    }
  }

  return palabra;
}
