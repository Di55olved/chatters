//import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:chatters/Screens/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:chatters/API/api.dart';
import 'package:chatters/Screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (APIs.auth.currentUser != null) {
        log("User: ${APIs.auth.currentUser}");
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const SignInPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text("Welcome to Chatters"),
        automaticallyImplyLeading: false,
      ),
      body: Stack(children: [
        Positioned(
            top: MediaQuery.of(context).size.height * .15,
            left: MediaQuery.of(context).size.width * .25,
            width: MediaQuery.of(context).size.width * .5,
            child: Image.asset('assets/images/chat.png')),
        Positioned(
          bottom: MediaQuery.of(context).size.height * .15,
          left: MediaQuery.of(context).size.width * .05,
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .06,
          child: const Text(
            "Powered by IBA",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        )
      ]),
    );
  }
}
