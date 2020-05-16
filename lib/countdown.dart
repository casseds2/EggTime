import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';

class Countdown extends StatefulWidget {
  final int cookingTime;

  Countdown(this.cookingTime);

  @override
  State<StatefulWidget> createState() {
    return _CountdownState(cookingTime);
  }
}

class _CountdownState extends State<Countdown> {
  int _cookingTime;
  int _seconds;
  int _minutes;
  Timer _timer;

  _CountdownState(this._cookingTime);

  void _alertDialog(BuildContext context) {
    Widget ok = FlatButton(
      onPressed: () => {
        Navigator.pop(context),
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Launch()),
        ),
      },
      child: Text("Ok"),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Eggs Done!"),
      content: Text("Finish up..."),
      actions: <Widget>[
        ok,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
    );
  }

  void _startTimer() {
    const second = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      second,
      (Timer t) => setState(
        () {
          _cookingTime--;
          if (_cookingTime == 0) {
            _seconds = 0;
            _alertDialog(context);
            _stopTimer();
            return;
          }
          double dubMinutes = _cookingTime / 60;
          _minutes = dubMinutes.toInt();
          _seconds = _cookingTime % 60;
        },
      ),
    );
  }

  String _formattedTime() {
    return "${_seconds < 10 ? "0" : ""}$_minutes:${_seconds < 10 ? "0" : ""}$_seconds";
  }

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  initState() {
    super.initState();
    double dubMinutes = _cookingTime / 60;
    _minutes = dubMinutes.toInt();
    _seconds = _cookingTime % 60;
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              _formattedTime(),
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 3.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
