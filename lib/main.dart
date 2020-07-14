import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController textEditingController =
      TextEditingController(text: "Noname");
  bool isOn = false;

  void saveData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("name", textEditingController.text);
    preferences.setBool("ison", isOn);
  }

  Future<String> getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("name") ?? "NoName";
  }

  Future<bool> getOn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("ison") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SharedPreference"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: textEditingController,
              ),
              Switch(
                value: isOn,
                onChanged: (newValue) {
                  setState(() {
                    isOn = newValue;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      saveData();
                    },
                    child: Text("Save"),
                  ),
                  SizedBox(width: 50),
                  RaisedButton(
                    onPressed: () {
                      setState(() {});
                      getName().then((value) => {
                            textEditingController.text = value,
                          });
                      getOn().then((value) => {isOn = value});
                    },
                    child: Text("Load"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
