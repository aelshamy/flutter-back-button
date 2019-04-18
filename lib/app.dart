import 'package:flutter/material.dart';
import 'package:flutter_back_button/page2.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _handleBackPressed(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Back Button'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Page 1'),
              RaisedButton(
                child: Text('Go To Page 2'),
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => Page2()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _handleBackPressed(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Do you really want to exit the app'),
            actions: <Widget>[
              FlatButton(child: Text('No'), onPressed: () => Navigator.pop(context, false)),
              FlatButton(child: Text('Yes'), onPressed: () => Navigator.pop(context, true)),
            ],
          ),
    );
  }
}
