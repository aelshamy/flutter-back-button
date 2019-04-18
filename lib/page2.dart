import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final formKey = GlobalKey<FormState>();
  bool _dirty = false;

  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  _printLatestValue() {
    setState(() {
      _dirty = myController.text.length != 0;
    });
  }

  void _submit(context) {
    final form = formKey.currentState;
    if (!form.validate()) {
      return;
    }
    // Theme.of(context).showSnackBar(new SnackBar(backgroundColor: Colors.black, content: new Text("Saved!")));
  }

  Future<bool> _canLeave(BuildContext context) {
    return myController.text.isEmpty ? Future<bool>.value(true) : _prompt(context);
  }

  Future<bool> _prompt(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Warning - Incomplete form'),
            content: Text('Do you want to stay and complete this form?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Yes'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Back Button'),
      ),
      body: Container(
        child: Center(
          child: Form(
            key: formKey,
            autovalidate: true,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Enter something'),
                    validator: (String val) => val.isEmpty ? "You must enter something" : null,
                    controller: myController,
                  ),
                  RaisedButton(
                    onPressed: () => _submit(context),
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
            onWillPop: () => _canLeave(context),
          ),
        ),
      ),
    );
  }
}
