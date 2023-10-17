import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    var timeSplash = Duration(seconds: 3);
    Future.delayed(timeSplash, () {
      context.go("/");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [

        /* TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: 0.0,),
          duration: const Duration(seconds: 2),
          curve: Curves.bounceInOut,
          builder: (context, value, child) {

            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: value * (MediaQuery.of(context).size.height * 0.03),
                child: child,
              ),
            );
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  )
                ),
              ),
            ],
          ),
        ), */

        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0,),
          duration: const Duration(seconds: 1),
          builder: (context, value, child) {

            return Transform.scale(
              scale: value * (MediaQuery.of(context).size.height * 0.03),
              child: child,
            );
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.amber, // Cambia el color del borde aquí
                      width: 20.0, // Cambia el grosor del borde aquí
                    ),
                  )
                ),
              ),
              
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  )
                ),
              ),

              /* TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 0.1,),
                duration: const Duration(seconds: 2),
                curve: Curves.bounceOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    alignment: Alignment.center,
                    scale: value,
                    child: child,
                  );
                },

                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    )
                  ),
                ),
              ) */
            ],
          ),
        ),
      ]),
    );
  }
}