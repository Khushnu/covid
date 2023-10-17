import 'dart:async';

import 'package:covid/Views/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () { 
      Navigator.push(context, MaterialPageRoute(builder: (context) => const WorldStates()));
    });
  }

  @override
  void dispose() { 
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          AnimatedBuilder(
            
            animation: _controller, builder: (context , Widget? child){
            return Transform.rotate(angle: _controller.value*2 * math.pi, child: child, );
          },
          // ignore: sized_box_for_whitespace
          child:   Container(
              height: 200,
              width: 200,
              child: const Center( child: Image(image: AssetImage('images/virus.png')),),
            ),),

          SizedBox(height: MediaQuery.of(context).size.height * .08,),
         const Align(alignment: Alignment.center,
          child: Text('COVID 19 \nTracker App', style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 23,
          ),),)
        ],
      )),
    );
  }
}