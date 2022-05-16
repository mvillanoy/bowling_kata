// Dart implementation of https://codingdojo.org/kata/Bowling/

enum Type { 
   strike, 
   spare, 
   miss 
} 

class Frame {
    Type type = Type.miss;
    List<int> roll = [];
    Frame(String frameString){

        if(frameString == 'X' || frameString == 'x'){
            this.type = Type.strike;
            this.roll.add(10);
        } else if(frameString.contains("/")){
            this.type = Type.spare;
            this.roll.add(frameString[0] == "-" ? 0 : int.parse(frameString[0]));
            this.roll.add(10-this.roll[0]);
            if(frameString.length > 2){
              this.roll.add(int.parse(frameString[2]));
            }
        } else {
            this.roll.add(frameString[0] == "-" ? 0 : int.parse(frameString[0]));
            this.roll.add(frameString[1] == "-" ? 0 : int.parse(frameString[1]));
        }
    }
}

void main(List<String> arguments) {
    print(arguments);

    if(arguments.length < 10){
      print("Game has not yet finished.");
      return;
    }
  
    List<Frame> frameScores = [];
    
    for (int i=0; i<arguments.length; i++){
        frameScores.add(Frame(arguments[i]));
    }

    print("Final score: "+ computeScore(frameScores).toString());
}

int computeScore(List<Frame> frames){

    int score = 0;
    for (int i=0; i<10; i++){
        if(frames[i].type == Type.strike){
            score = score + frames[i].roll[0] + frames[i+1].roll[0] + 
              ((frames[i+1].type == Type.strike) ? frames[i+2].roll[0] : frames[i+1].roll[1]);
        } else if (frames[i].type == Type.spare){
            score = score + frames[i].roll[0] + frames[i].roll[1] + 
              ((i==9) ? frames[i].roll[2] : frames[i+1].roll[0]);
        } else {
            score = score + frames[i].roll[0] + frames[i].roll[1];
        }
    }
    return score;
    
}



