import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds:1),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder:(context)=>const Home()
      ));
    });
  }
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
  }
  @override
  Widget build(BuildContext context) {
    
    return Material(
      child:Center(
        child:Icon(
          Icons.pages,
          size:MediaQuery.of(context).size.height/8,
          color:Theme.of(context).textTheme.titleLarge!.color
        )
      )
    );
  }
}

