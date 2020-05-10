import 'package:flutter/material.dart';
import 'package:egg_timer/egg_options.dart';

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
  AnimationController _eggController;
  Animation<double> _eggAnimation;

  @override
  void initState() {
    super.initState();
    _eggController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _eggAnimation = Tween<double>(begin: 0, end: 800).animate(_eggController)
    ..addListener(() {
      setState(() {
        // Nothing in here for the moment...
      });
    });
    _eggController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _eggController.dispose();
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
      Container(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        height: _eggAnimation.value,
        width: 100,
      ),
      Center(
        child: _cookButton(),
      ),
    ]);
  }
}
