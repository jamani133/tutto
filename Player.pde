
class Player{
  ArrayList<Play> plays;
  String name;
  int score = 0;
  
  Player(String nname){
    plays = new ArrayList<Play>();
    name = nname;
  }
  
  void cscore(boolean safe,boolean tut){
    if(safe && !tut && diceleft == 6){
      Play lp = new Play();
      lp.score = 0;
      lp.mod = "skip";
      plays.add(lp);
      return;
    }
    if(curMod.equals("street")){
      if(checkStreet() || tut){
        Play lp = new Play();
        lp.score = 2000;
        lp.mod = curMod;
        plays.add(lp);
        score += lp.score;
      }else{
        Play lp = new Play();
        lp.score = 0;
        lp.mod = curMod;
        plays.add(lp);
        score += lp.score;
      }
      return;
    }
    if((checkTutto() || (tut && curMod.equals("steal")))&& !curMod.equals("x2")){
      if(curMod.equals("steal")){
        PlayAdd lp = new PlayAdd();
        lp.score=1000;
        lp.mod = "steal";
        lp.From = remove1000top(this);
        plays.add(lp);
        score += lp.score;
        return;
      }
      
      Play lp = new Play();
      lp.score=calcScore();
      lp.score += bonusPoints();
      lp.mod = curMod;
      plays.add(lp);
      score += lp.score;
      return;
    }
    if(safe && !curMod.equals("steal")){
      Play lp = new Play();
      lp.score=calcScore();
      if(curMod.equals("x2")){
        lp.score *= 2;
      }
      lp.mod = curMod;
      plays.add(lp);
      score += lp.score;
    }else{
      //fail
      Play lp = new Play();
      lp.score = 0;
      lp.mod = curMod;
      plays.add(lp);
      score += lp.score;
    }
    
    
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
