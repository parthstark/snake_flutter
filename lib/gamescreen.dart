import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'homescreen.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  @override
  void dispose() { 
    super.dispose();
  }

  List<int> snakePos=[25,45,65];
  int _count=760;
  static var randomNumber=Random();
  int food=randomNumber.nextInt(760);

//  _GameState(){
//    //_count=MediaQuery.of().size.height~/25;  //Efficient way suggested by VSCode
//    _count=760;
//  }

  _GameState(){
    direction='down';
    startGame();
  }
    
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
    if(mounted){setState(() {
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
              direction='down';
              startGame();
              Navigator.of(context).pop();
            }, 
              child: Text('Play Again')
            ),
            FlatButton(onPressed:(){
              Navigator.of(context).pop();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>Home()));
            },
              child: Text('Exit')
            )
          ],
        );
      }
    );
  }

  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Do you want to exit?'),
          actions: [
            FlatButton(
              child: Text('No'),
              onPressed:(){
              Navigator.of(context).pop();
            }, 
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed:(){
              Navigator.of(context).pop();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>Home()));
            },
            )
          ],
        );
      }
    );
    // DateTime now = DateTime.now();
    // if (currentBackPressTime == null || 
    //     now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    //   currentBackPressTime = now;
    //   return Future.value(false);
    // }
    // return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: WillPopScope(
        onWillPop:onWillPop,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
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
            ),
          ),
        ),
      )
    );
  }
}