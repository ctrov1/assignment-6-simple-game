float Charx = 50;
float Chary = 50;
int coinNum = 10;
int Score = 0;
Coin[] coins = new Coin[coinNum];
void setup(){
  size(500,500);
  for (int i = 0; i < coinNum; i++) {
   coins[i] = new Coin(color(#ffeb16),random(width),random(height));
}
}

void draw() {
  background(200,200);
  
  for (int i = 0; i < coinNum; i++) {
  coins[i].displaycoin();
  coins[i].destroycoin();
  }
  ellipseMode(CENTER);
  ellipse(Charx,Chary,5,5);
  
}


class Coin {
  color c;
  float cxpos;
  float cypos;
  
  
  Coin(color c_, float cxpos_, float cypos_) {
   c = c_;
   cxpos = cxpos_;
   cypos = cypos_;
  }
  
   void displaycoin() {
   fill(c);
   noStroke();
   ellipse(cxpos,cypos,10,10);
   }
   void destroycoin(){
     float coindistance = sqrt((cxpos-Charx) * (cxpos-Charx) + (cypos-Chary) * (cypos-Chary));
     if (coindistance <=10){
       cxpos=-1000;
       cypos=-1000;
      
       Score++;
       println(Score);
     }
      
    
    stroke(1);     
}


}



void keyPressed(){

  if (key == CODED){
    if (keyCode == DOWN){
      Chary += 10;
    }else if (keyCode == UP){
      Chary -= 10;
    }else if (keyCode == RIGHT){
      Charx += 10;
    }else if (keyCode == LEFT){
      Charx -= 10;
    }
  }
  
}
