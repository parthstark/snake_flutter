import 'package:flutter/material.dart';

import 'gamescreen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("SnakeKexigo", style: TextStyle(color:Colors.white), textScaleFactor: 5),
              SizedBox(height:200),
              InkWell(
                onTap:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>Game()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal:50,vertical:10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(left:Radius.circular(50),right:Radius.circular(50)),
                    color: Colors.black
                  ),
                  child: Text("Play", style: TextStyle(color:Colors.white), textScaleFactor: 3),),
              )
            ]
          )
        )
      )
    );
  }
}