import 'package:flutter/material.dart';

class FallingEgg extends StatefulWidget {
  FallingEgg({Key key}) : super(key: key);

  @override
  _FallingEggState createState() => _FallingEggState();
}

class _FallingEggState extends State<FallingEgg>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration());
    _animation = Tween<double>(begin: 0, end: 300).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      height: _animation.value,
      width: 200,
    );
  }
}
