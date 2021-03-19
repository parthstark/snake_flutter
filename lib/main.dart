import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Game(),
    );
  }
}

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  bool _isEnabled=true;
  List<int> snakePos=[25,45,65];
  int _count=760;
  static var randomNumber=Random();
  int food=randomNumber.nextInt(760);

//  _GameState(){
//    //_count=MediaQuery.of().size.height~/25;  //Efficient way suggested by VSCode
//    _count=760;
//  }
    
  void startGame(){
    snakePos=[25,45,65];
    const duration=const Duration(milliseconds: 200);
    Timer.periodic(duration, (timer) {
      updateSnake();
      if(gameOver()){
        timer.cancel();
        _showGameOverScreen();
      }
    });
  }

  void generateFood(){
    food=randomNumber.nextInt(_count);
  }

  var direction='down';

  void updateSnake(){
    setState(() {
      switch (direction) {
        case 'down':
          snakePos.last>(_count-20)
          ?snakePos.add(snakePos.last+20-_count)
          :snakePos.add(snakePos.last+20);
          break;
        case 'up':
          snakePos.last<20
          ?snakePos.add(snakePos.last-20+_count)
          :snakePos.add(snakePos.last-20);
          break;
        case 'left':
          snakePos.last % 20 == 0
          ?snakePos.add(snakePos.last-1 +20)
          :snakePos.add(snakePos.last-1);
          break;
        case 'right':
          (snakePos.last+1) % 20 == 0
          ?snakePos.add(snakePos.last+1 -20)
          :snakePos.add(snakePos.last+1);
          break;
        default:
      }
      if(snakePos.last==food){
        generateFood();
      }else{
        snakePos.removeAt(0);
      }
    });
  }

  bool gameOver(){
    for(int i=0;i<snakePos.length;i++){
      int count=0;
      for(int j=i+1;j<snakePos.length;j++){
        if(snakePos[i]==snakePos[j]){count++;}
      }
      if(count!=0){return true;}
    }
  return false;
  }

  void _showGameOverScreen(){
    showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your score: ' + (snakePos.length-3).toString()),
          actions: [
            FlatButton(onPressed:(){
              startGame();
              Navigator.of(context).pop();
            }, 
              child: Text('Play Again'))
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onVerticalDragUpdate: (details){
                  if(direction!='up' && details.delta.dy>0){
                    direction='down';
                  }
                  else if(direction!='down' && details.delta.dy<0){
                    direction='up';
                  }
                },
                onHorizontalDragUpdate: (details){
                  if(direction!='left' && details.delta.dx>0){
                    direction='right';
                  }
                  else if(direction!='right' && details.delta.dx<0){
                    direction='left';
                  }
                },
                child: Container(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _count,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:20), 
                    itemBuilder: (BuildContext context, int index){
                      if(index==food){
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.red,),)
                        );
                      }
                      if(snakePos.contains(index)){
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white,),)
                        );
                      }else{
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.black,),)
                        );
                      }
                    }
                  ),
                ),
              ),
              Expanded(child: Container(
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.horizontal(left:Radius.circular(50),right:Radius.circular(50)),
                  color: Colors.black
                ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(),
                  InkWell(
                    onTap: _isEnabled
                      ?(){
                        _isEnabled=false;
                        startGame();
                      }
                      :null,
                    child: Container(height: 50, alignment: Alignment.center, 
                              child: Text("Start", textScaleFactor: 2, style: TextStyle(color:Colors.white))
                            )
                  ),
                  SizedBox()
                  ],
                ),
              ),
            ),
          ]),
        ),
      )
    );
  }
}