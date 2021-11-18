import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _numbController = new TextEditingController();
  static Random ran = new Random();
  int randomnr = ran.nextInt(100) + 1;
  String mesaj = "";

  void guess() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    int guess = int.parse(_numbController.text);

    if (guess > 100 || guess < 1) {
      mesaj = "Numarul trebuie sa fie >=1 si <=100";
      _numbController.clear();
      return;
    }

    if (guess > randomnr) {
      mesaj = "Tasteaza mai mic!";
    } else if (guess < randomnr) {
      mesaj = "Tasteaza mai mare!";
    } else if (guess == randomnr) {
      mesaj = "Ai castigat! Numarul este: $randomnr";
      randomnr = ran.nextInt(100) + 1;
    }
    _numbController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyanAccent,
          title: Center(
            child: Text("Ghiceste Numarul"),
          ),
        ),
        body: Form(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Ma gandesc la un numar intre 1 si 100",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.greenAccent,
                  ),
                ),
                Text(
                  "Incearca sa il aflii",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.black,
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Incearca un numar",
                        style: TextStyle(
                          fontSize: 23.0,
                          color: Colors.black,
                        ),
                      ),
                      TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: false),
                        controller: _numbController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          guess();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Sa vedem :  "),
                              content: Text('$mesaj'),
                              actions: <Widget>[
                                ElevatedButton(
                                    onPressed: () {}, child: Text('Reincearca'))
                              ],
                            ),
                          );
                        },
                        child: Text(
                          "Ghici",
                          style: TextStyle(
                            fontSize: 15.22 ,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
