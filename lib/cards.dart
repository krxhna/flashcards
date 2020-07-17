// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class cards extends StatelessWidget {
  final List<String> names;
  final List<String> msgCount;

  const cards({Key key, this.names, this.msgCount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Center(child: Text('Flash Cards')),
        ),
        body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: names.length,
          itemBuilder: (BuildContext context, int index) {
            return PageView(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: [Colors.amber, Colors.red])),
                    child: Center(
                        child: Text(
                      names[index],
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ))),
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.blue, Colors.green])),
                    child: Center(
                        child: Text(
                      msgCount[index],
                      style: TextStyle(fontSize: 30),
                    ))),
              ],
            );
          },
        ),
      ),
    );
  }
}
