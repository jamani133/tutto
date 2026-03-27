
class Player{
  ArrayList<Play> plays;
  String name;
  int score = 0;
  
  Player(String nname){
    plays = new ArrayList<Play>();
    name = nname;
  }
  
  void cscore(boolean safe,boolean tut){
    
    if(curMod.equals("lucky")){
      addPlay(0,false);
      return;
    }
    
    if(curMod.equals("street")){  //street handler
      if(checkStreet() || tut){
        addPlay(2000,true);
      }else{
        addPlay(0,false);
      }
      return;
    }
    
    if(curMod.equals("steal")){ //steal checker
      if(checkTutto() || tut){
        PlayAdd lp = new PlayAdd();
        lp.score=1000;
        lp.mod = "steal";
        lp.From = remove1000top(this);
        lp.success = true;
        plays.add(lp);
        score += lp.score;
      }else{
        addPlay(0,false);
      }
      return;
    }
    
    
    if(curMod.equals("x2")){  //x2 
      addPlay(calcScore()*2,true);
      return;
    }
    if(checkTutto()){  //tutto 
      addPlay(calcScore()+bonusPoints(),true);
      return;
    }
    addPlay(safe?calcScore():0,false);
  }
  
  void addPlay(int sc,boolean succ){
    Play lp = new Play();
    lp.score=sc;
    lp.success = succ;
    lp.mod = curMod;
    plays.add(lp);
    score += sc;
  }
  
  
  void draw(float posX){
    stroke(255);
    strokeWeight(3);
    line(posX+width/8,h3,posX+width/8,height);
    fill(255);
    textSize(40);
    textAlign(LEFT,CENTER);
    text(name,posX+10,h3+25);
    textAlign(RIGHT,CENTER);
    text(str(score)+"P",posX+(width/8)-10,h3+65);
    float posY = h3+90;
    for( int i = plays.size()-1; i>=0;i--){
      posY += plays.get(i).render(posX,posY);
    }
    if(this == players.get(playerIndex)){
      stroke(0,200,255);
      strokeWeight(8);
      noFill();
      rect(posX+5,height/3+5,width/8-9,2*height/3-9);
    }
  }
}

String remove1000top(Player too){
  int best = players.get(0).score;
  for ( Player p : players){
    if(best < p.score){
      best = p.score;
    }
  }
  String n = "";
  for ( Player p : players){
    if(best == p.score && p != too){
      PlaySub lp = new PlaySub();
      lp.score = -1000;
      lp.To = too.name;
      lp.success = true;
      lp.mod = "stolen";
      if(n.equals("")){
        n = p.name;
      }else{
        n = "Group";
      }
      p.plays.add(lp);
      p.score -= 1000;
    }
  }
  return n;
}
