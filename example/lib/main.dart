import 'package:flutter/material.dart';

import 'package:awesome_switch/awesome_switch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  Example({Key key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  bool state = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Awesome Switch'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Text('Switch with Background'),
              AwesomeSwitch.bg(
                value: true,
                activeBG: 'assets/1.jpg',
                inactiveBG: 'assets/2.png',
                onChange: (v) {},
              ),
              Text('Switch with ON and OFF'),
              AwesomeSwitch.onOff(
                value: true,
                onChange: (v) {},
              ),
              Text('Switch with Yes and No'),
              AwesomeSwitch.yesNo(
                value: true,
                onChange: (v) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
