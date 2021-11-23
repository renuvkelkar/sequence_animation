import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:velocity_x/velocity_x.dart';

class SequencePage extends StatefulWidget {
  @override
  _SequencePageState createState() => new _SequencePageState();
}

class _SequencePageState extends State<SequencePage> with SingleTickerProviderStateMixin{


  AnimationController controller;
  SequenceAnimation sequenceAnimation;

  bool forward;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(vsync: this);

    sequenceAnimation = new SequenceAnimationBuilder()
        .addAnimatable(
        animatable: new ColorTween(begin: Colors.red, end: Colors.yellow),
        from:  const Duration(seconds: 0),
        to: const Duration(seconds: 2),
        tag: "color"
    ).addAnimatable(
        animatable: new Tween<double>(begin: 0.0, end: 0.9),
        from:  const Duration(seconds: 2),
        to: const Duration(seconds: 9),
        tag: "height",
        curve: Curves.easeOut
    ).addAnimatable(
        animatable: new Tween<dynamic>(begin: -20, end: 20),
        //  animatable: new Tween<double>(begin: 200.0, end: 40.0),
        from:  const Duration(seconds: 5),
        to: const Duration(seconds: 6),
        tag: "offset",
        curve: Curves.fastOutSlowIn
    ).animate(controller);
    controller.forward();


  }


  Future<Null> _playAnimation() async {
    try {
      await controller.forward().orCancel;
      await controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sequence"),
      ),
      body: new AnimatedBuilder(
        builder: (context, child) {
          return Column(
            children: [
              new Center(
                child: new Container(
                  color: sequenceAnimation["color"].value,
                  height: 200.0,
                  width: 200.0,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 200,
                width: 300,
                color: Colors.yellow.withOpacity(sequenceAnimation["height"].value),
              ),
              SizedBox(height: 20,),
              Container(
                height: 200,
                width: 300,
                color: Colors.pink.withOpacity(sequenceAnimation["height"].value),



              ),

            ],
          );
        },
        animation: controller,
      ),
    );
  }

}