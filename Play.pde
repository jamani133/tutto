class Play{
  int score = 0;
  String mod = null;
  boolean success = false;
  float render(float posX,float posY){

    noStroke();
    fill(255);
    fill(200,200,140);
    textAlign(LEFT,CENTER);
    textSize(40*UISCALE);
    text("+"+str(score)+"P",posX+(100*UISCALE),posY+(25*UISCALE));
    moddraw(mod,posX,posY,success);
    strokeWeight(2);
    stroke(200);
    line(posX,posY,posX+spaltmas,posY);
    return 96*UISCALE;
  }
}

class PlaySub extends Play{
  String To = "";
  float render(float posX,float posY){

    fill(128,0,0);
    noStroke();
    rect(posX+2,posY+2,spaltmas-3,94*UISCALE);
    fill(200,200,140);
    textSize(40*UISCALE);
    textAlign(LEFT,CENTER);
    text(str(score)+"P",posX+(100*UISCALE),posY+(25*UISCALE));
    textSize(20*UISCALE);
    textAlign(RIGHT,CENTER);
    text("-> "+To,posX-(20*UISCALE)+spaltmas,posY+(70*UISCALE));
    moddraw(mod,posX,posY,success);
    strokeWeight(2);
    stroke(255);
    line(posX,posY,posX+spaltmas,posY);
    return 96*UISCALE;
  }
}

class PlayAdd extends Play{
  String From = "";
  float render(float posX,float posY){
    
    fill(0,128,0);
    noStroke();
    rect(posX+2,posY+2,spaltmas-3,94*UISCALE);
    fill(200,200,140);
    textSize(40*UISCALE);
    textAlign(LEFT,CENTER);
    text(str(score)+"P",posX+(100*UISCALE),posY+(25*UISCALE));
    textSize(20*UISCALE);
    textAlign(RIGHT,CENTER);
    text("<- "+From,posX-(20*UISCALE)+spaltmas,posY+(70*UISCALE));
    moddraw(mod,posX,posY,success);
    strokeWeight(2);
    stroke(255);
    line(posX,posY,posX+spaltmas,posY);
    return 96*UISCALE;
  }
}
