import 'package:flutter/material.dart';
import 'package:egg_timer/egg.dart';
import 'dart:async';

void main() {
  runApp(EggTimer());
}

class EggTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Egg Timer",
      home: Launch(),
    );
  }
}

class Launch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          color: Colors.orangeAccent,
          padding: EdgeInsets.all(50),
          shape: CircleBorder(),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contex) => EggOptions(),
              ),
            ),
          },
          child: Text("Lets Cook!"),
        ),
      ),
    );
  }
}

class EggOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EggOptionsState();
  }
}

class _EggOptionsState extends State<EggOptions> {
  Egg _selected;

  static const _eggTypes = [
    const Egg(name: "Boiled", value: "boiled", cookingTime: 20),
    const Egg(name: "Poached", value: "poached", cookingTime: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Egg"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: DropdownButton<Egg>(
              value: _selected,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                color: Colors.orangeAccent,
              ),
              underline: Container(
                height: 2,
                color: Colors.orange,
              ),
              onChanged: (Egg egg) {
                print("Egg ${egg.toString()}");
                setState(() {
                  _selected = egg;
                });
              },
              items: _eggTypes.map((Egg egg) {
                return DropdownMenuItem<Egg>(
                  value: egg,
                  child: Text(
                    egg.name,
                    style: TextStyle(
                      fontSize: 35.0,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: FlatButton(
              color: Colors.orangeAccent,
              padding: EdgeInsets.all(50),
              shape: CircleBorder(),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contex) => Countdown(_selected.cookingTime),
                  ),
                ),
              },
              child: Text("Cook!"),
            ),
          ),
        ],
      ),
    );
  }
}

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
