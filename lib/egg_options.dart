import 'package:flutter/material.dart';
import 'package:egg_timer/countdown.dart';
import 'package:egg_timer/data/egg.dart';

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

  void _openTimer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (contex) => Countdown(_selected.cookingTime),
      ),
    );
  }

  Widget _buildButton() {
    return FlatButton(
      color: Colors.orangeAccent,
      padding: EdgeInsets.all(50),
      shape: CircleBorder(),
      onPressed: () =>
      {
        _selected == null ? null : _openTimer()
      },
      child: Text("Cook!"),
    );
  }

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
                print(egg.toString());
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
            child: _buildButton(),
          ),
        ],
      ),
    );
  }
}