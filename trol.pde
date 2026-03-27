import processing.net.*;

float UISCALE = 1;
int COLS      = 8;

Server server;

ArrayList<Player> players;

ArrayList<Pull> pulls;

int playerIndex = 0;

ArrayList<PImage> images;
ArrayList<PImage> imagesBW;

String imagePaths[] = {"none","200","300","400","500","600","x2","party","street","steal","stolen","lucky","street","none","skip"};

int h3  = 0;
int h8  = 0;
int h12 = 0;
int h16 = 0;
int h24 = 0;
int h32 = 0;
int h64 = 0;
float spaltmas = width/8;
int diceleft = 6;
String curMod = "none";

void setup(){
  pulls = new ArrayList<Pull>();
  pulls.add(new Pull());
  images = new ArrayList<PImage>();
  imagesBW = new ArrayList<PImage>();
  loadImages();
  players = new ArrayList<Player>();
  for(String n : loadStrings("players.txt")){
    players.add(new Player(n));
  }
  fullScreen();
  //surface.setResizable(true);
  //size(720,480);
  h3  = height/3;
  h8  = height/8;
  h12 = height/12;
  h16 = height/16;
  h24 = height/24;
  h32 = height/32;
  h64 = height/64;
  spaltmas = width/COLS;
  setupServer();
  doSB();
  UISCALE = width/1920.0;
}

void draw(){
  background(0,64,0);
  playerList();
  current();
  layout();
  runServer();
  //UISCALE = width/1920.0;
}

void handleInput(char k) {
  println("got key : "+k);
  if(k == '_'){
    pulls.add(new Pull());
  }else{
    keyPress(k);
  }
}
void keyPressed(){
  if(keyCode == ENTER){
    pulls.add(new Pull());
  }else{
    keyPress(key);
  }
  
}

void keyPress(char k){
  if(k >= '1' && k <= '6'){
    if(diceleft > 0){
      print(int(k));
      pulls.get(pulls.size()-1).add(int(k-'1'+1));
      diceleft --;
    }
    return;
  }
  
  
  if(!curMod.equals("none")){
    if(k == 'N'){endTurn(true,false);}
    if(k == '='){endTurn(false,false);}
    if(k == 'T' && (curMod.equals("steal") ||curMod.equals("street"))){endTurn(true,true);}
  }
  
  if(k == 'R'){
    fuck();
  }
  
  if(k == '8'){
    diceleft += pulls.get(pulls.size()-1).count;
    pulls.remove(pulls.size()-1);
    
    if(pulls.size() == 0){
      pulls.add(new Pull());
    }
  }
  if(k == 's'){curMod = "steal";}
  if(k == 'd'){curMod = "x2";}
  if(k == 'f'){curMod = "street";}
  if(k == 'a'){curMod = "party";}
  if(k == 'g'){curMod = "200";}
  if(k == 'h'){curMod = "300";}
  if(k == 'j'){curMod = "400";}
  if(k == 'k'){curMod = "500";}
  if(k == 'l'){curMod = "600";}
 
  if(k == 'x'){curMod = "skip";}
  if(k == 'U'){curMod = "lucky";endTurn(false,false);}
  if(k == 'n'){playerIndex--;if(playerIndex<0){playerIndex=players.size()-1;}}
  if(k == 'm'){playerIndex++;if(playerIndex>=players.size()){playerIndex=0;}}
}


void current(){
  float posX = 16*height/27;
  for(Pull p : pulls){
    posX += p.draw(posX);
  }
  fill(255);
  noStroke();
  textAlign(LEFT,CENTER);
  textSize(100*UISCALE);
  text(players.get(playerIndex).name,30*UISCALE,50*UISCALE);
  textSize(40*UISCALE);
  text("Score : "+players.get(playerIndex).score+"P",30*UISCALE,110*UISCALE);
  text("Table : "+calcScore()+"P",width/6,110*UISCALE);
  //text("Modifier : "+curMod,30,220);
  image(pickimage(curMod,true),(16*height/27)-(height/6)-(h32),(height/3)-(height/6)-h32,height/6,height/6);
  fill(255,200,0);
  textSize(45*UISCALE);

  text("1. "+first.name,h32,200*UISCALE);
  textAlign(RIGHT,CENTER);
  text(first.score,height/3,200*UISCALE);
  fill(200,200,255);
  textSize(40*UISCALE);
  textAlign(LEFT,CENTER);
  text("2. "+second.name,h32,260*UISCALE);
  textAlign(RIGHT,CENTER);
  text(second.score,height/3,260*UISCALE);
  fill(180,150,80);
  textSize(40*UISCALE);
  textAlign(LEFT,CENTER);
  text("3. "+third.name,h32,320*UISCALE);
  textAlign(RIGHT,CENTER);
  text(third.score,height/3,320*UISCALE);
}

void layout(){
  strokeWeight(4);
  stroke(255);
  line(0,h3,width,h3);
  line(16*height/27,0,16*height/27,h3);
  //line(3*spaltmas,height/3,3*spaltmas,height);
}

int pwrap(int i){
  return (i+players.size())%players.size();
}

void playerList(){
  players.get(pwrap(playerIndex-1)).draw(0);
  players.get(pwrap(playerIndex)).draw(spaltmas);
  players.get(pwrap(playerIndex+1)).draw(spaltmas*2);
  int i = height/3;
  int xi = int(spaltmas*3);
  
  
  for(Player p : players){
    stroke(255);
    strokeWeight(2);
    textSize(40);
    noFill();
    rect(xi,i,spaltmas*5/3,height/12);
    fill(255);
    textAlign(LEFT,CENTER);
    text(p.name,xi+h32,i+h24);
    textAlign(RIGHT,CENTER);
    text(p.score+" P",xi+(spaltmas*5/3)-h32,i+h24);
    if(first == p){
      stroke(255,200,0);
      strokeWeight(6);
      noFill();
      rect(xi+4,i+4,spaltmas*5/3-8,height/12-8);
    }
    i += height/12;
    if(i > height*11/12){
      i = height/3;
      xi+=spaltmas*5/3;
    }
  }
}
/*
void playerList(){
  for(int i=0;i<10;i++){
    
    players.get(i).draw(i*(spaltmas));
    
  }
}

void playerList2(){
  int i = 0;
  for(Player p : players){
    p.draw(i*spaltmas-(min(1.0,max(0.0,(sin(float(millis())/2000.0)+0.5)))*max(players.size()-8,0)*(spaltmas)));
    i++;
  }
}

void playerList3(){
  int i = 0;
  for(Player p : players){
    p.draw((((millis()/2000.0+i)%players.size())-1)*(spaltmas));
    i++;
  }
}
*/
void endTurn(boolean safe , boolean tut){
  
  
  
  if(curMod.equals("party")){
    safe = true;
  }
  players.get(playerIndex).cscore(safe,tut);
  playerIndex = (playerIndex+1)%players.size();
  pulls = new ArrayList<Pull>();
  pulls.add(new Pull());
  diceleft = 6;
  curMod = "none";
  doSB();
}

Player first;
Player second;
Player third;
void doSB(){
  first = players.get(players.size()-1);
  second = players.get(players.size()-1);
  third = players.get(players.size()-1);
  for(Player p : players){
    if(first.score < p.score){
      first = p;
    }
  }
  for(Player p : players){
    if(second.score < p.score && first != p){
      second = p;
    }
  }
  for(Player p : players){
    if(third.score < p.score && second != p && first != p){
      third = p;
    }
  }
}


void die(int c,float posX, float posY){
  fill(188,0,0);
  stroke(80,0,0);
  strokeWeight(3);
  rect(posX,posY,h12,h12,h64);
  noStroke();
  fill(255);
  
  if(c%2==1){
    ellipse(posX+h24,posY+h24,h64,h64);
  }
  if(c>=2){
    ellipse(posX+(h24)-(h32),posY+(h24)-(h32),h64,h64);
    ellipse(posX+(h24)+(h32),posY+(h24)+(h32),h64,h64);
  }
  if(c>=4){
    ellipse(posX+(h24)+(h32),posY+(h24)-(h32),h64,h64);
    ellipse(posX+(h24)-(h32),posY+(h24)+(h32),h64,h64);
  }
  if(c>=6){
    ellipse(posX+(h24)+(h32),posY+(h24),h64,h64);
    ellipse(posX+(h24)-(h32),posY+(h24),h64,h64);
  }
}

int calcScore(){
  int sc = 0;
  for(Pull p : pulls){
    sc+=p.getScore();
  }
  return sc;
}

int bonusPoints(){
  if(curMod.equals("200")){return 200;}
  if(curMod.equals("300")){return 300;}
  if(curMod.equals("400")){return 400;}
  if(curMod.equals("500")){return 500;}
  if(curMod.equals("600")){return 600;}
  return 0;
}

boolean checkStreet(){
  int counts[] = {0,0,0,0,0,0,0};
    for(Pull p : pulls){
      for(int c : p.dice){
        counts[c]++;
      }
    }
    for(int i = 1; i<7;i++){
      if(counts[i]!=1){
        return false;
      }
    }
  return true;
}

void fuck(){
  
  //playerIndex -= 1;
  //if(playerIndex<0){playerIndex = players.size()-1;}
  if(players.get(playerIndex).plays.size() == 0){
    return;
  }
  Play a = players.get(playerIndex).plays.get(players.get(playerIndex).plays.size()-1);
  if(a.mod == "steal" && a.score != 0){
    playerIndex += 1;
    return;
  }
  players.get(playerIndex).score -= players.get(playerIndex).plays.get(players.get(playerIndex).plays.size()-1).score;
  players.get(playerIndex).plays.remove(players.get(playerIndex).plays.size()-1);
}

boolean checkTutto(){
  int c = 0;
  for(Pull p : pulls){
    c += p.count;
  }
  if(c==6){
    return true;
  }
  return false;
}

void loadImages(){
  for(String i : imagePaths){
    images.add(loadImage("icons/"+i+".png"));
    imagesBW.add(loadImage("icons/"+i+".png"));
    imagesBW.get(imagesBW.size()-1).filter(GRAY);
  }
}

//steal, stolen, 200,300,400,500,600,party,2x, street
PImage pickimage(String mod, boolean success){
  for(int i = 0;i<images.size();i++){
    if(mod.equals(imagePaths[i])){
      if(success){
        return images.get(i);
      }else{
        return imagesBW.get(i);
      }
    }
  }
  return images.get(0);
}
void moddraw(String mod, float posX, float posY, boolean success){
  image(pickimage(mod,success),posX+(h64),posY+(h64),h16,h16);
}
