import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
void main() => runApp( MaterialApp(
   theme:
  ThemeData(primaryColor: Colors.red, accentColor: Colors.yellowAccent),
  debugShowCheckedModeBanner:false,
  home: SplashScreen(),
));

 class SplashScreen extends StatefulWidget{
   @override
   _SplashScreenState createState() => _SplashScreenState();
    }
   
   class _SplashScreenState extends State<SplashScreen>{

   @override
   void initState(){
     super.initState();
     //This is where you call the home screen you want to display next
     Timer(Duration(seconds: 5),() => print("Splash Done"));
   }

   @override
   Widget build(BuildContext context){
     return Scaffold(
       body: Stack(
         fit: StackFit.expand,
         children: <Widget>[
           Container(
             child: FlareActor("assets/splashscreen.flr",
             fit: BoxFit.cover),
             
           ),
           Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
               Expanded(
                 flex:2,
                 child: Container(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       CircleAvatar(
                         backgroundColor: Colors.red,
                         radius: 50.0,
                         child: Icon(
                           Icons.music_note,
                           color: Colors.purple[900],
                           size: 35.0,
                           )
                           ),
                           Padding(
                             padding: EdgeInsets.only(top: 10.0),
                             ),
                             Text("WeTheSauce", style: TextStyle(color: Colors.red,fontSize: 24.0, fontWeight:FontWeight.bold),)
                     ],
                   ),
                 ),
                 ),
                 Expanded(flex: 1,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Expanded(
                                            child: FlareActor("assets/testanime.flr",
                       animation: "Circular",
                       fit: BoxFit.contain,
                       ),
                     ),
                     Padding(padding: EdgeInsets.only(top: 10.0),
                     ),
                     Text("Sauce Radio!", style: TextStyle(color: Colors.red,fontSize: 18.0))
                   ],
                 ),)
             ],)
         ],
       ),
     );
   }
   }
   