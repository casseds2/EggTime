import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
        child: Container(
          height: 200.0,
          width: 200.0,
          child: NeumorphicButton(
            style: NeumorphicStyle(
              shape: NeumorphicShape.convex,
              depth: 8.0,
              lightSource: LightSource.topLeft,
              color: Colors.yellowAccent,
            ),
            boxShape: NeumorphicBoxShape.circle(),
            onClick: () => {
              print("Navigate to Options Screen"),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contex) => EggOptions(),
                  ))
            },
            child: Center(
              child: Text(
                "Lets Cook!",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
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
    const Egg(name: "Boiled", value: "boiled"),
    const Egg(name: "Poached", value: "poached"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Egg"),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
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
          )
        ],
      ),
    );
  }
}

class Egg {
  final String name;
  final String value;

  const Egg({this.name, this.value});
}
