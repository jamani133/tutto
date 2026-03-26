
class Pull{
  int dice[] = {0,0,0,0,0,0};
  int count = 0;
  Pull(){
    
  }
  void add(int c){
    if(count >= 6){
      return;
    }
    dice[count] = c;
    count++;
  }
  float draw(float posX){
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(posX+h32,h32, max(1,int(count/2) + (count%2))*(h8+h64),(min(count,2)*(h8+h64)));
    for(int i = 0;i<count;i++){
      die(dice[i],posX+h16+(int(i/2)*(h8+h64)),h16+(int(i%2)*(h8+h64)));
    }
    return max(1,int(count/2) + (count%2))*(h8+h64)+h32;
  }
  int getScore(){
    
    int counts[] = {0,0,0,0,0,0,0};
    for(int i = 0;i<6;i++){
      counts[dice[i]]++;
    }
    int sc = 0;
    for(int i = 2; i<7;i++){
      sc+=int(counts[i]/3)*i*100;
    }
    sc+=int(counts[1]/3)*1000;
    sc+=(counts[1]%3)*100;    
    sc+=(counts[5]%3)*50;
    return sc;
  }
}
