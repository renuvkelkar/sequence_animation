import 'package:flutter/material.dart';
import 'dart:async';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with SingleTickerProviderStateMixin {
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
        animatable: new Tween<double>(begin: 0.0, end: 1.0),
        from:  const Duration(seconds: 0),
        to: const Duration(seconds: 1),
        tag: "opacity",
        curve: Curves.easeOut
    ).addAnimatable(
        animatable: new Tween<double>(begin: 0.0, end: 1.0),
        from:  const Duration(seconds: 2),
        to: const Duration(seconds: 7),
        tag: "opacity1",
        curve: Curves.easeOut
    ).addAnimatable(
        animatable: new Tween<double>(begin: 0.0, end: 1.0),
        //  animatable: new Tween<double>(begin: 200.0, end: 40.0),
        from:  const Duration(seconds: 8),
        to: const Duration(seconds: 9),
        tag: "opacity2",
        curve: Curves.fastOutSlowIn
    ).addAnimatable(
        animatable: new Tween<double>(begin: 0.0, end: 40),
        //  animatable: new Tween<double>(begin: 200.0, end: 40.0),
        from:  const Duration(seconds: 7),
        to: const Duration(seconds: 10),
        tag: "size1",
        curve: Curves.fastOutSlowIn
    ).addAnimatable(
        animatable: new Tween<double>(begin: 0.0, end: 1.0),
        from:  const Duration(seconds: 10),
        to: const Duration(seconds: 11),
        tag: "opacity3",
        curve: Curves.easeOut
    ).addAnimatable(
        animatable: new Tween<double>(begin: 0.0, end: 1.0),
        from:  const Duration(seconds: 12),
        to: const Duration(seconds: 13),
        tag: "opacity4",
        curve: Curves.easeOut
    )
        .addAnimatable(
        animatable: new Tween<double>(begin: 0, end: 500),
        //  animatable: new Tween<double>(begin: 200.0, end: 40.0),
        from:  const Duration(seconds: 4),
        to: const Duration(seconds: 8),
        tag: "scale",
        curve: Curves.fastOutSlowIn
    ).animate(controller);
    controller.forward();


  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF71D7FF),
      body: Stack(
        children: [
          AnimatedBuilder(
          builder: (context, child){
            return
            Stack(
              children: [
            VxBox(child: Column(
            children: [
              Image.network("https://events.flutter.dev/engage/assets/img/flutter-engage-sharing.jpg",height:context.screenHeight*0.5,fit: BoxFit.cover,).opacity(value: sequenceAnimation["opacity"].value),
            ],
            )).color(Color(0xFF71D7FF)).height(context.screenHeight).make(),
                Image.network("https://events.flutter.dev/engage/assets/img/birds.png",width: sequenceAnimation["scale"].value,).pOnly(top:350,left: 20).opacity(value: sequenceAnimation["opacity1"].value),
                "Flutter Engage".text.white.bold.size(sequenceAnimation["size1"].value).makeCentered().opacity(value: sequenceAnimation["opacity2"].value),
                "03.03.21".text.xl2.semiBold.makeCentered().opacity(value: sequenceAnimation["opacity3"].value).pOnly(top: 70),
                "9:30am - 1:00pm PST".text.gray700.makeCentered().opacity(value: sequenceAnimation["opacity3"].value).pOnly(top: 110),
                VxBox(child: "Sign up for Updates".text.semiBold.white.makeCentered()).height(30).width(200).roundedSM.color(Colors.blue).makeCentered().opacity(value: sequenceAnimation["opacity4"].value).pOnly(top: 110).pOnly(top: 400)

              ],
            );

    },
            animation: controller,

    )

        ],
      ),
    );
  }
}
