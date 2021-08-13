import 'package:flutter/material.dart';

import 'game.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(),
              Text("SNAKE\nKING", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Girassol', color:Colors.white), textScaleFactor: 7),
              SizedBox(),
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
                  child: Text("PLAY", style: TextStyle(fontFamily: 'Girassol', color:Colors.white), textScaleFactor: 3),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image(image: AssetImage('assets/images/snake.png'),height: 300,)
                ],
              )
            ]
          )
        )
      )
    );
  }
}