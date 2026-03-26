class Play{
  int score = 0;
  String mod = null;
  float render(float posX,float posY){

    noStroke();
    fill(255);
    fill(200,200,140);
    textAlign(LEFT,CENTER);
    textSize(40);
    text("+"+str(score)+"P",posX+100,posY+25);
    moddraw(mod,posX,posY);
    strokeWeight(2);
    stroke(200);
    line(posX,posY,posX+width/8,posY);
    return 96;
  }
}

class PlaySub extends Play{
  String To = "";
  float render(float posX,float posY){

    fill(128,0,0);
    noStroke();
    rect(posX+2,posY+2,width/8-4,92);
    fill(200,200,140);
    textSize(40);
    textAlign(LEFT,CENTER);
    text(str(score)+"P",posX+100,posY+25);
    textSize(20);
    textAlign(RIGHT,CENTER);
    text("-> "+To,posX-20+width/8,posY+70);
    moddraw(mod,posX,posY);
    strokeWeight(2);
    stroke(255);
    line(posX,posY,posX+width/8,posY);
    return 96;
  }
}

class PlayAdd extends Play{
  String From = "";
  float render(float posX,float posY){
    
    fill(0,128,0);
    noStroke();
    rect(posX+2,posY+2,width/8-4,92);
    fill(200,200,140);
    textSize(40);
    textAlign(LEFT,CENTER);
    text("+"+str(score)+"P",posX+100,posY+25);
    textSize(20);
    textAlign(RIGHT,CENTER);
    text(From+" ->",posX-20+width/8,posY+70);
    moddraw(mod,posX,posY);
    strokeWeight(2);
    stroke(255);
    line(posX,posY,posX+width/8,posY);
    return 96;
  }
}
