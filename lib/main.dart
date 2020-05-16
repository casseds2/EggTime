import 'package:flutter/material.dart';
import 'package:egg_timer/egg_options.dart';
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

class Launch extends StatefulWidget {
  Launch({Key key}) : super(key: key);

  @override
  _LaunchState createState() => _LaunchState();
}

class _LaunchState extends State<Launch> with SingleTickerProviderStateMixin {
  double _opacity;
  Alignment _alignment;

  @override
  void initState() {
    super.initState();
    _alignment = Alignment.topCenter;
    _opacity = 0.0;
    Timer.run(() {
      setState(() {
        _alignment = Alignment.bottomCenter;
        _opacity = 1.0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _cookButton() {
    return FlatButton(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment(0.9, 0.0),
                  stops: [0.0, 0.5, 0.5, 1],
                  colors: [
                    Colors.white,
                    Colors.lightBlueAccent,
                    Colors.white,
                    Colors.lightBlueAccent,
                  ],
                  tileMode: TileMode.repeated,
                ),
              ),
              alignment: Alignment.topCenter,
              child: AnimatedAlign(
                alignment: _alignment,
                curve: Curves.bounceOut,
                duration: const Duration(seconds: 3),
                child: FlutterLogo(
                  size: 100,
                ),
              ),
            ),
          ),
        ],
      ),
      AnimatedOpacity(
        duration: const Duration(seconds: 3),
        opacity: _opacity,
        child: Center(
          child: _cookButton(),
        ),
      ),
    ]);
  }
}
