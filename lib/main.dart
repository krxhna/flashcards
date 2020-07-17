import 'package:flutter/material.dart';
import 'package:chat/cards.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  List<String> names = <String>[];
  String nameKey = "_key_name";
  String nameKey1 = "_key_name1";
  List<String> msgCount = <String>[];

  TextEditingController nameController = TextEditingController();
  TextEditingController msgcontroller = TextEditingController();

  void addItemToList() {
    setState(() {
      names.insert(0, nameController.text);
      msgCount.insert(0, msgcontroller.text);
    });
  }

  Future<bool> SaveData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setStringList(nameKey, names);
  }

  Future<List> loaddata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(nameKey);
  }

  setData() {
    loaddata().then((value) {
      setState(() {
        names = value.toList();
      });
    });
  }

  //hunkmk

  Future<bool> SaveData1() async {
    SharedPreferences preferences1 = await SharedPreferences.getInstance();
    return await preferences1.setStringList(nameKey1, msgCount);
  }

  Future<List> loaddata1() async {
    SharedPreferences preferences1 = await SharedPreferences.getInstance();
    return preferences1.getStringList(nameKey1);
  }

  setData1() {
    loaddata1().then((value1) {
      setState(() {
        msgCount = value1.toList();
      });
    });
  }

  @override
  void initState() {
    setData();
    setData1();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => cards(
                    msgCount: msgCount,
                    names: names,
                  )),
        );
      }),
      appBar: AppBar(
        title: Text('cards app'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: nameController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Text is empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Text is empty';
                  }
                  return null;
                },
                controller: msgcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'sub',
                ),
              ),
            ),
            // RaisedButton(
            //   child: Text('set'),
            //   onPressed: () {

            //       // setData();
            //       // setData1();

            //   },
            // ),
            RaisedButton(
              child: Text('Add'),
              onPressed: () {
                
                SaveData();
                SaveData1();
                addItemToList();
                nameController.clear();
                msgcontroller.clear();
              },
            ),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: names.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        margin: EdgeInsets.all(2),
                        color: Colors.red,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${names[index]} (${msgCount[index]})',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    names.removeAt(index);
                                  });
                                  setState(() {
                                    msgCount.removeAt(index);
                                  });
                                })
                          ],
                        )),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

// Container(
//         color: Colors.red,
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Contact Name',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: TextField(
//                 controller: msgcontroller,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Contact Name',
//                 ),
//               ),
//             ),
//             RaisedButton(
//               child: Text('Add'),
//               onPressed: () {
//                 addItemToList();
//               },
//             ),
//             ListView.builder(
//               itemCount: names.length,
//               itemBuilder: (BuildContext context, int index) {
//               return Container(color: Colors.red,height: 30,);
//              },
//             ),
//           ]
//         ),
//       )
