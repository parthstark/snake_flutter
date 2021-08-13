class Score{
  int _id;
  int _position;
  int _score;
  String _date;

  Score(this._position,this._score,this._date);
  Score.withID(this._id,this._position,this._score,this._date);

  int get id=>_id;
  int get position=>_position;
  int get score=>_score;
  String get date=>_date;

  set score(int newScore){
    this._score=newScore;
  }

  set date(String newDate){
    this._date=newDate;
  }

  set position(int newPos){
    if(newPos>=1 && newPos<=3){
      this._position=newPos;
    }
  }

  Map<String, dynamic> toMap(){
    var map=Map<String, dynamic>();
    if(id!=null)
    {map['id']=_id;}

    map['position']=_position;
    map['score']=_score;
    map['date']=_date;

    return map;
  }

  Score.fromMapObject(Map<String,dynamic> map){
    this._id=map['id'];
    this._position=map['position'];
    this._score=map['score'];
    this._date=map['date'];
  }
}