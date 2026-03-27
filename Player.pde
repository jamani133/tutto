
class Player{
  ArrayList<Play> plays;
  String name;
  int score = 0;
  
  Player(String nname){
    plays = new ArrayList<Play>();
    name = nname;
  }
  
  void cscore(boolean safe,boolean tut){
    
    if(curMod.equals("lucky") || curMod.equals("skip")){
      addPlay(0,true);
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
    
    
    if(curMod.equals("x2") && checkTutto()){  //x2 
      addPlay(calcScore()*2,true);
      return;
    }
    if(checkTutto()){  //tutto 
      addPlay(calcScore()+bonusPoints(),true);
      return;
    }
    addPlay((safe)?calcScore():0,curMod.equals("party"));
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
    line(posX+spaltmas,h3,posX+spaltmas,height);
    fill(255);
    textSize(40*UISCALE);
    textAlign(LEFT,CENTER);
    text(name,posX+(10*UISCALE),h3+(25*UISCALE));
    textAlign(RIGHT,CENTER);
    text(str(score)+"P",posX+((spaltmas-10)*UISCALE),h3+(65*UISCALE));
    float posY = h3+(90*UISCALE);
    for( int i = plays.size()-1; i>=0;i--){
      posY += plays.get(i).render(posX,posY);
    }
    if(this == players.get(playerIndex)){
      stroke(0,200,255);
      strokeWeight(8*UISCALE);
      noFill();
      rect(posX+(5*UISCALE),height/3+(5*UISCALE),spaltmas-(9*UISCALE),2*height/3-(9*UISCALE));
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
      lp.score = -min(1000,p.score);
      lp.To = too.name;
      lp.success = true;
      lp.mod = "stolen";
      if(n.equals("")){
        n = p.name;
      }else{
        n = "Group";
      }
      p.plays.add(lp);
      p.score += lp.score;
    }
  }
  return n;
}
